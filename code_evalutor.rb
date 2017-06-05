require 'binding_of_caller'
require 'ruby-prof'
require 'debug_inspector'
require 'byebug'

class Eval

  def initialize()
    @state = {}
    @count = 0
    @stackcount = 0
    @answer = Hash.new {|h,k| h[k] = []}
  end

  def evaluate
    begin
    def jumble_sort(str, alphabet = nil)
      # @state[@count] = {"str" => str, "alphabet" => alphabet }
      # c
      alphabet = ("a".."z").to_a if alphabet == nil
      # @state[@count] = {"str" => str, "alphabet" => alphabet }
      # c
        answer = ""
      # @state[@count] = {"str" => str, "alphabet" => alphabet, "answer" => answer}
      # c
        str = str.split("")
      # @state[@count] = {"str" => str, "alphabet" => alphabet, "answer" => answer}
      # c
        until str.length == 0
          alphabet.each do |x|
            # @state[@count] = {"str" => str, "alphabet" => alphabet, "answer" => answer, "x" => x}
            # c
            if str.include? x
              count = str.count(x)
              # @state[@count] = {"str" => str, "alphabet" => alphabet, "answer" => answer, "x" => x}
              # c
              answer << x*count
              asdf
              # @state[@count] = {"str" => str, "alphabet" => alphabet, "answer" => answer, "x" => x}
              # c
              str.delete(x)
              # @state[@count] = {"str" => str, "alphabet" => alphabet, "answer" => answer, "x" => x}
              # c
              break
            end
          end
        end
        answer
    end
    jumble_sort("hello", ['o', 'l', 'h', 'e'])
  rescue
    p @answer
  end

  end

  def trace
    counter = 0
    tracer = TracePoint.new(:line) do |tp|
      counter += 1
      [tp.event]
      # p counter
      c(tp.lineno)
    end.enable do
      evaluate
    end
    puts @answer
  end

  def printsomething
    @y = 0
    (20..25).step do |x|
      @y += x
    end
    return @y
  end

  def c(lineno)
    @stackcount += 1
    array = []
    binding.of_caller(2).eval('local_variables').each do |var|
      # p var
      # p binding.of_caller(2).eval('p ' + var.to_s)
      p var
      array << {var => binding.of_caller(3).eval('p ' + var.to_s)}
      array << {"lineno" => lineno}
    end
    @answer[@stackcount] << array
    # p @answer
    # p @stackcount
  end

end


Eval.new.trace






# method = <<-EOF
#   def printsomething
#     y = 0
#     c
#     (20..25).step do |x|
#       c
#       y += x
#     end
#
#     return y
#   end
# p printsomething

# EOF

# RubyVM::InstructionSequence.compile_option=({:inline_const_cache=>true, :peephole_optimization=>true, :tailcall_optimization=>true, :specialized_instruction=>true, :operands_unification=>true, :instructions_unification=>true, :stack_caching=>true, :trace_instruction=>true, :frozen_string_literal=>true, :debug_frozen_string_literal=>true, :debug_level=>0})
# puts RubyVM::InstructionSequence.new(method).to_a
#
# RubyVM::DebugInspector.open { |dc|
#   # backtrace locations (returns an array of Thread::Backtrace::Location objects)
#   locs = dc.backtrace_locations
#
#   # you can get depth of stack frame with `locs.size'
#   locs.size.times do |i|
#     # binding of i-th caller frame (returns a Binding object or nil)
#     p dc.frame_binding(i)
#
#     # iseq of i-th caller frame (returns a RubyVM::InstructionSequence object or nil)
#     p dc.frame_iseq(i)
#
#     # class of i-th caller frame
#     p dc.frame_class(i)
#   end
# }

# RubyProf.start
#
# def printsomething
#   y = 0
#   (20..25).step do |x|
#     y += x
#   end
#   return y
# end
#
# p printsomething
#
#
# result = RubyProf.stop
#
# p result
# printer = RubyProf::FlatPrinter.new(result)
# printer.print(STDOUT)
