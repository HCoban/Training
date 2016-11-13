class QuickFindUF

  #O(n) time
  def initialize(n)
    @array = Array.new(n)

    @array.length.times do |i|
      @array[i] = i
    end
  end

  #O(1) time
  def connected?(p, q)
    @array[p] == @array[q]
  end

  #O(n) time
  def union(p, q)
    p_id = @array[p]
    q_id = @array[q]

    @array.each_index do |idx|
      @array[idx] = q_id if @array[idx] == p_id
    end
  end

  def print
    p @array
  end
end

trial = QuickFindUF.new(10)
trial.union(4,3)
trial.union(3,8)
trial.union(6,5)
trial.union(9,4)
trial.union(2,1)
trial.union(8,9)
trial.union(5,0)
trial.union(7,2)
trial.union(6,1)
trial.print
