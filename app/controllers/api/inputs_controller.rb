require 'binding_of_caller'
require 'json'
require_relative 'my_stack'

class Api::InputsController < ApplicationController

  def create
    littleEval = Eval.new(params[:input])
    littleEval.trace
    render json: littleEval.stack_history.stack_store
  end

end


class Eval

  attr_reader :stack_history

  def initialize(code)
    @code = code
    @state = {}
    @count = 0
    @stack_history = MyStack.new
  end

  def evaluate
    begin
      eval(@code)
    rescue
      p @stack_history
    end
  end

  def trace
    counter = 0
    block_lines = getBlockLineNumbers
    tracer = TracePoint.new(:line) do |tp|
      counter += 1

      if block_lines.any? { |x,y| tp.lineno.between?(x,y)}
        retrieve_variables(tp.lineno, true)
      else
        retrieve_variables(tp.lineno)
      end
    end.enable do
      evaluate
    end
  end

  def getBlockLineNumbers
    startnumbers = []
    endnumbers = []
    trace2 = TracePoint.trace(:b_call) do |tp2|
      unless startnumbers.include?(tp2.lineno)
        startnumbers << tp2.lineno
      end
    end.enable do
      evaluate
    end
    trace3 = TracePoint.trace(:b_return) do |tp3|
      unless endnumbers.include?(tp3.lineno)
        endnumbers << tp3.lineno
      end
    end.enable do
      evaluate
    end
    startnumbers.pop
    startnumbers.shift
    endnumbers.pop
    return [startnumbers,endnumbers].transpose
  end


  def retrieve_variables(lineno, blocks = false)
    count = 2
    unless ["trace", "evaluate", "step", "ensure_iteration_allowed"].include?(grabMethodName(count))
      object = {}
      stack_frame = MyStack.new
      swap = false
      until grabMethodName(count) == "evaluate"
        count += 1 if grabMethodName(count) == "step"
        if blocks
          blockObj = {}
          swap ? blockObj['method_name'] = grabMethodName(count) : blockObj['method_name'] = 'block'
          swap = true
          binding.of_caller(count).eval('local_variables').each do |var2|
            if binding.of_caller(count+1).eval(var2.to_s).is_a?(Array)
              blockObj[var2] = binding.of_caller(count+1).eval(var2.to_s).dup
            else
              curr_var2 = binding.of_caller(count+1).eval(var2.to_s)
              if curr_var2.is_a?(Symbol)
                curr_var2 = curr_var2.to_s + 'SYM'
              end
              blockObj[var2] = curr_var2
            end
          end
          stack_frame.push(blockObj)
        else
          functionObj = {}
          functionObj['method_name'] = grabMethodName(count)
          binding.of_caller(count).eval('local_variables').each do |var|
            if binding.of_caller(count+1).eval(var.to_s).is_a?(Array)
              functionObj[var] = binding.of_caller(count+1).eval(var.to_s).dup
            else
              curr_var = binding.of_caller(count+1).eval(var.to_s)
              if curr_var.is_a?(Symbol)
                curr_var = curr_var.to_s + 'SYM'
              end
              functionObj[var] = curr_var
            end
          end
          stack_frame.push(functionObj)
        end
        count += 1
      end
      @stack_history.push( { "lineno#{lineno}" => stack_frame.stack_store } )
      p @stack_history
    end
  end

  def grabMethodName(count)
    binding.of_caller(count+1).eval('__method__').to_s
  end

end
