require 'binding_of_caller'
require 'json'

class Api::InputsController < ApplicationController

  def create
    littleEval = Eval.new(params[:input])
    littleEval.trace
    render json: littleEval.answer
  end

end


class Eval

  attr_reader :answer

  def initialize(code)
    @code = code
    @state = {}
    @count = 0
    @stackcount = 0
    @answer = Hash.new
  end

  def evaluate
    begin
      eval(@code)
    rescue
      p @answer
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
      @stackcount += 1
      object = {}
      object["lineno"] = lineno

      until grabMethodName(count) == "evaluate"
        variableInfo = {}
        variableInfo['depth'] = count

        binding.of_caller(count).eval('local_variables').each do |var|
          variableInfo[var] = binding.of_caller(count+1).eval(var.to_s)
        end

        object[grabMethodName(count)] = variableInfo
        count += 1
      end

      @answer["frame#{@stackcount}"] = object
    end
  end

  def grabMethodName(count)
    binding.of_caller(count+1).eval('__method__').to_s
  end

end
