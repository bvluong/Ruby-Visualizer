require 'binding_of_caller'
require 'json'
require_relative 'my_stack'

class Api::InputsController < ApplicationController

  def create
    littleEval = Eval.new(params[:input])
    littleEval.trace
    p littleEval.stack_history
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
    tracer = TracePoint.new(:line) do |tp|
      counter += 1
      [tp.event]
      retrieve_variables(tp.lineno)
    end.enable do
      evaluate
    end
  end

  def retrieve_variables(lineno)
    count = 2
    unless ["trace", "evaluate"].include?(grabMethodName(count))
      object = {}
      stack_frame = MyStack.new

      until grabMethodName(count) == "evaluate"
        unless binding.of_caller(count-1).eval('local_variables').include?(:tracer)
          blockObj = {}
          blockObj['method_name'] = 'block'
          binding.of_caller(count-1).eval('local_variables').each do |var2|
            blockObj[var2] = binding.of_caller(count).eval(var2.to_s)
          end
          stack_frame.push(blockObj)
        end

        functionObj = {}
        binding.of_caller(count).eval('local_variables').each do |var|
          functionObj[var] = binding.of_caller(count+1).eval(var.to_s)
        end
        stack_frame.push(functionObj)
        count += 1
      end

      @stack_history.push( { "lineno#{lineno}" => stack_frame.stack_store } )
    end
  end

  def grabMethodName(count)
    binding.of_caller(count+1).eval('__method__').to_s
  end

end
