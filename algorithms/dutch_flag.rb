#O(n) time, O(1) space
def dutch_flag(pivotindex, array)
  pivot = array[pivotindex]

  smaller = 0
  i = 0
  while i < array.length
    if array[i].ord < pivot.ord
      array[i], array[smaller] = array[smaller], array[i]
      smaller += 1
    end
    i += 1
  end

  larger = array.length - 1
  i = array.length - 1
  while i >=0
    if array[i].ord > pivot.ord
      array[i], array[larger] = array[larger], array[i]
      larger -= 1
    end
    i -= 1
  end

  array
end
