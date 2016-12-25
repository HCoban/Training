require './stack.rb'

class Queue
  def initialize
    @enter = Stack.new
    @leave = Stack.new
  end

  def enqueue(el)
    @enter.push(el)
  end

  def dequeue
    slide if @leave.empty?
    @leave.pop
  end

  def slide
    raise "Error" if @enter.empty?
    until @enter.empty?
      @leave.push(@enter.pop)
    end
  end
end
