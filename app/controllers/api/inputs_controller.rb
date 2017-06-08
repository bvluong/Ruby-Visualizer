require 'binding_of_caller'
require 'json'
require_relative 'my_stack'

class Api::InputsController < ApplicationController

  def create
    littleEval = Eval.new(params[:input])
    littleEval.check_infinite
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
    @errors = []
    @return = nil
    @error_counter = 0
    @stack_history_counter = 0
  end

  def evaluate
    begin
    $SAFE = 1
    eval(@code)
    rescue => e
      @errors << e
    rescue SyntaxError => e
      @errors << e
    rescue SystemStackError => e
      @errors << e
    rescue IndexError => e
      @errors << e
    rescue SecurityError => e
      @errors << e
    end
  end

  def check_infinite
    tracer = TracePoint.new(:line) do |tp|
      @error_counter += 1
      if @error_counter > 9999
        break
      end
    end.enable do
      evaluate
    end
    if @error_counter > 9999
      p @error_counter
      @stack_history.push({errors: "Error: Your code exceeded 9999 stacks, you are probably in an infinite loop or stack overflow"})
      p @stack_history
    else
      trace
    end
  end

  def trace
    counter = 0
    block_lines = getBlockLineNumbers
    tracer = TracePoint.new(:line) do |tp|
      counter += 1
      @stack_history_counter += 1
      if @stack_history_counter < 3000
        if block_lines.any? { |x,y| tp.lineno.between?(x,y)}
          retrieve_variables(tp.lineno, true)
        else
          retrieve_variables(tp.lineno)
        end
      else
        @stack_history.push({ errors: "Error: stack frames exceeded" })
        break
      end
    end.enable do
      evaluate
    end
    if @errors.length > 0
      @stack_history.push({ errors: "Error: #{@errors[0]}"})
    elsif @return
      @stack_history.push({ return_value: "Return Value: #{@return}" })
    end
  end

  def retrieve_variables(lineno, blocks = false)
    count = 2
    unless ["trace", "evaluate", "step", "ensure_iteration_allowed"].include?(grabMethodName(count))
      object = {}
      stack_frame = MyStack.new
      swap = false
      until grabMethodName(count) == "evaluate"
        @stack_history_counter += 1
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
      @stack_history.push( { "lineno#{lineno}" => stack_frame.stack_store.reverse } )
      return @stack_history
    end
  end

  def grabMethodName(count)
    binding.of_caller(count+1).eval('__method__').to_s
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

end
