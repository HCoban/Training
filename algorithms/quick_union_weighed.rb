
class QuickUnionW

  #O(n)
  def initialize(n)
    @array = Array.new(n)
    @array.each_index do |idx|
      @array[idx] = idx
    end

    @sizes = Array.new(n) {1}
  end

  #O(nlogn) time
  def root(idx)
    current = @array[idx]
    until current == @array[current]
      current = @array[current]
    end

    current
  end

  #O(logn) time
  def connected?(p, q)
    root(p) == root(q)
  end

  #O(logn)
  def union(p, q)
    return if connected?(p, q)
    if @sizes[root(p)] < @sizes[root(q)]
      @array[root(p)] = root(q)
    elsif @sizes[root(p)] == @sizes[root(q)]
      @sizes[root(p)] += 1
      @array[root(q)] = root(p)
    else
      @array[root(q)] = root(p)
    end
  end

  def print
    p @array
  end
end

trial = QuickUnionW.new(10)
trial.union(4,3)
trial.union(3,8)
trial.union(6,5)
trial.union(9,4)
trial.union(2,1)
trial.union(5,0)
trial.union(7,2)
trial.union(6,1)
trial.union(7,3)
trial.print
