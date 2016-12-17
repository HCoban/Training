#find two indices add up to target in a sorted array
def two_sum(array, target)
  i = 0
  j = (array.length) -1

  while i <= j
    case array[i] + array[j] <=> target
    when 0
      return [i, j]
    when -1
      i += 1
    when 1
      j -= 1
    end
  end

  return false
end
