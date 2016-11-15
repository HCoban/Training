require_relative 'two_sum'

#find if two elements add up to target in an array
def three_sum(array, target)
  array.each_with_index do |el, idx|
    remaining = target - el
    res = two_sum(array, remaining)
    return true if res
  end

  false
end
