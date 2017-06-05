require 'binding_of_caller'
require 'json'

class Api::InputsController < ApplicationController

  def create
    littleEval = Eval.new(params[:input])
    littleEval.trace
    p littleEval.answer
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
    @answer = Hash.new {|h,k| h[k] = []}
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

  def printsomething
    @y = 0
    (20..25).step do |x|
      @y += x
    end
    return @y
  end

  def retrieve_variables(lineno)
    @stackcount += 1
    array = []
    binding.of_caller(2).eval('local_variables').each do |var|
      # p var
      # p binding.of_caller(2).eval('p ' + var.to_s)
      array << {var => binding.of_caller(3).eval('p ' + var.to_s)}
      array << {"lineno" => lineno}
    end
    @answer[@stackcount] << array
    # p @answer
    # p @stackcount
  end

end
