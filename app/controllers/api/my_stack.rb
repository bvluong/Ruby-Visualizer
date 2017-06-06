class MyStack
  attr_accessor :stack_store

  def initialize(stack_store = [])
    @stack_store = stack_store
  end

  def empty?
    @stack_store.empty?
  end

  def peek
    @stack_store.last
  end

  def get_info
    @stack_store
  end

  def pop
    @stack_store.pop
  end

  def push(val)
    @stack_store.push(val)
  end

  def size
    @stack_store.size
  end
end
