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
  end

  def pop
    raise "Error" if @store.empty?
    to_pop = @store.pop
    if to_pop = min
      @mins.pop
    end

    to_pop
  end

  def min
    @mins.last
  end

end
