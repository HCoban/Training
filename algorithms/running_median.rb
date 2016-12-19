# Find the Running Median
require 'byebug'

n = gets.strip.to_i
a = Array.new(n)
for a_i in (0..n-1)
    a[a_i] = gets.strip.to_f.round(1)
end

class Heap

    attr_reader :store

    def initialize(values)
        @store = []
        values.each { |v| insert(v) }
    end

    def insert(value)
        @store.push(value)
        heapify_up!
    end

    def pop_top
        top = @store.first
        @store[0], @store[@store.length-1] = @store[@store.length-1], @store[0]
        @store.pop
        heapify_down!
        top
    end

    def parent_idx(i)
        i == 0 ? 0 : (i - 1) / 2
    end

    def children_idx(i)
        [(2 * i) + 1, (2 * i) + 2].select { |el| el < @store.length }
    end

    def top
        @store.first
    end

    def length
      @store.length
    end

end

class MinHeap < Heap
    def heapify_down!
        i = 0
        smallest = children_idx(i).min_by { |idx| @store[idx] }
        while smallest
            if @store[i] > @store[smallest]
                @store[i], @store[smallest] = @store[smallest], @store[i]
                i = smallest
            else
                break
            end
            smallest = children_idx(i).min_by { |idx| @store[idx] }
        end
    end

    def heapify_up!
        i = @store.length - 1
        while i > 0
            current = @store[i]
            parent = parent_idx(i)
            break unless parent
            if @store[parent] > @store[i]
                @store[parent], @store[i] = @store[i], @store[parent]
                i = parent
            else
                break
            end
        end
    end
end

class MaxHeap < Heap
    def heapify_down!
        i = 0
        largest = children_idx(i).max_by { |idx| @store[idx] }
        while largest
            if @store[i] < @store[largest]
                @store[i], @store[largest] = @store[largest], @store[i]
                i = largest
            else
                break
            end
            largest = children_idx(i).max_by { |idx| @store[idx] }
        end
    end

    def heapify_up!
        i = @store.length - 1
        while i > 0
            current = @store[i]
            parent = parent_idx(i)
            break unless parent
            if @store[parent] < @store[i]
                @store[parent], @store[i] = @store[i], @store[parent]
                i = parent
            else
                break
            end
        end
    end
end

maxHeap = ""
minHeap = ""

a.each_with_index do |el, idx|
    if idx%2 == 0
        if idx == 0
            maxHeap = MaxHeap.new([el])
        else
            maxHeap.insert(el)
        end
    else
        if idx == 1
            minHeap = MinHeap.new([el])
        else
            minHeap.insert(el)
        end
    end

    if minHeap.class != String && maxHeap.top > minHeap.top
      t = maxHeap.pop_top
      q = minHeap.pop_top

      maxHeap.insert(q)
      minHeap.insert(t)
    end

    if minHeap && minHeap.class != String
      if maxHeap.length == minHeap.length
        puts (maxHeap.top + minHeap.top)/2
      else
        puts maxHeap.top
      end
    else
        puts maxHeap.top
    end

end
