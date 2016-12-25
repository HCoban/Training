class Stack
  def initialize
    @store = []
  end

  def push(el)
    @store.push(el)
  end

  def pop
    raise "Error" if @store.empty?
    @store.pop
  end

  def empty?
    @store.empty?
  end

  def peek
    @store.last
  end
end
