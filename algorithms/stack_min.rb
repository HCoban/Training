# A stack with a min function operating in O(1) time

class Stack
  def initialize
    @store = []
    @mins = []
  end

  def push(el)
    @store.push(el)
    if @mins.empty? || min > el
      @mins.push(el)
    end
    
    el
  end

  def pop
    raise "Error" if @store.empty?
    if @store.last == min
      @mins.pop
    end

    @store.pop
  end

  def min
    @mins.last
  end

end
