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
    @stackcount += 1
    object = {}
    binding.of_caller(2).eval('local_variables').each do |var|
      object[var] = binding.of_caller(3).eval(var.to_s)
    end
    object["lineno"] = lineno
    @answer[@stackcount] = object
  end

end
