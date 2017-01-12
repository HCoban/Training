def random_subarray(arr, n)
  dup = arr.dup
  r = rand(dup.length)

  dup[0], dup[r] = dup[r], dup[0]
  i = 1
  while i < n
    r = rand(dup.length-i) + i
    dup[i], dup[r] = dup[r], dup[i]
    i += 1
  end

  dup[0...n]
end

arr = [3, 7, 5, 11, 12]
freq = { 3 => 0, 7 => 0, 5 => 0, 11 => 0, 12 => 0 }

10000000.times do
  r = random_subarray(arr, 3)
  r.each { |el| freq[el] += 1 }
end

indexes = {0 => 0, 1 => 0, 2 => 0, 3 => 0, 4 => 0}

10000000.times do
  r = random_subarray(arr, arr.length)
  indexes[r.index(3)] += 1
end

def frequency(hash)
  total = hash.values.inject(&:+).to_f
  freq = {}
  hash.each do |k, v|
    freq[k] = (v.to_f / total) * 100.0
  end

  freq
end

puts frequency(freq)
puts frequency(indexes)
