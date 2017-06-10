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

  attr_reader :stack_history, :status

  def initialize(code)
    @code = code
    @count = 0
    @stack_history = MyStack.new
    @errors = []
    @return = nil
    @error_counter = 0
    @stack_history_counter = 0
  end

  # def eval_in_sandbox
  #   if @code == ""
  #     @stack_history.push({ errors: "Error: Code may not be empty"})
  #   else
  #     result = EvalIn.eval(:ruby,@code)
  #     if result.status[0..1] == "OK"
  #       @status = true
  #     else
  #       @stack_history.push({ errors: "Error: #{result.status}"})
  #     end
  #   end
  # end

  def evaluate
    begin
    $SAFE = 1
    @return = eval(@code)
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
    if @code == ""
      @stack_history.push({ errors: "Error: Code may not be empty"})
    else
      tracer = TracePoint.new(:line) do |tp|
        @error_counter += 1
        if @error_counter > 9999
          break
        end
      end.enable do
        evaluate
      end
      if @error_counter > 9999
        @stack_history.push({errors: "Error: Your code exceeded 9999 stacks, you are probably in an infinite loop or stack overflow"})
      else
        trace
      end
    end
  end

  def trace
    block_lines = getBlockLineNumbers
    tracer = TracePoint.new(:line) do |tp|
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

  def retrieve_variables(lineno, is_block = false)
    count = 2
    unless ["trace", "evaluate", "step", "ensure_iteration_allowed"].include?(get_method_name(count))
      stack_frame, block_method = MyStack.new, false
      until get_method_name(count) == "evaluate"
        @stack_history_counter += 1
        count += 1 if get_method_name(count) == "step"
        if is_block
          function_obj = get_function_variables(block_method, count+1)
          block_method = true
        else
          block_method = true
          function_obj = get_function_variables(block_method, count+1)
        end
        stack_frame.push(function_obj)
        count += 1
      end
      @stack_history.push( { "lineno#{lineno}" => stack_frame.stack_store } )
      return @stack_history
    end
  end

  def get_function_variables(swap, count)
    methodObj = {}
    swap ? methodObj['method_name'] = get_method_name(count) : methodObj['method_name'] = 'block'
    binding.of_caller(count).eval('local_variables').each do |var|
      curr_var = binding.of_caller(count+1).eval(var.to_s)
      if curr_var.is_a?(Array) || curr_var.is_a?(Hash) || curr_var.is_a?(String)
        methodObj[var] = binding.of_caller(count+1).eval(var.to_s).deep_dup
      else
        if curr_var.is_a?(Symbol)
          curr_var = curr_var.to_s + 'SYM'
        end
        methodObj[var] = curr_var
      end
    end
    return methodObj
  end

  def get_method_name(count)
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
