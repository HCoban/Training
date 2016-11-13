class QuickUnionUF

  #O(n) time
  def initialize(n)
    @array = Array.new(n)
    @array.each_index do |idx|
      @array[idx] = idx
    end
  end

  #O(n) time
  def root(idx)
    current = @array[idx]
    until current == @array[current]
      current = @array[current]
    end

    current
  end

  #O(n) time
  def connected?(p, q)
    root(p) == root(q)
  end

  #O(n) time
  def union(p, q)
    unless connected?(p, q)
      @array[root(p)] = root(q)
    end
  end

  def print
    p @array
  end
end

trial = QuickUnionUF.new(10)
trial.union(4,3)
trial.union(3,8)
trial.union(6,5)
trial.union(9,4)
trial.union(2,1)
trial.union(8,9)
trial.union(5,0)
trial.union(7, 2)
trial.union(6, 1)
trial.union(7, 3)
trial.print
