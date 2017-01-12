def nonuniform_random(numbers, probabilities)
  selection = []

  i = 0
  while i < numbers.length
    number = numbers[i]
    prob = probabilities[i]
    if selection.empty?
      lower = 0
    else
      lower = selection.last.last
    end

    higher = lower + prob

    selection.push([lower, higher])

    i += 1
  end

  random = rand
  idx = find_idx(random, selection)
  numbers[idx]
end

def find_idx(random, selection)
  selection.each_with_index do |s, i|
    next if random > s.last
    return i if random >= s.first
  end
end

numbers = [3, 5, 7, 11]
probabilities = [9.0/18, 6.0/18, 2.0/18, 1.0/18]

freq_hash = { 3 => 0, 5 => 0, 7 => 0, 11 => 0 }

# should generate frequencies similar to
# 3 => 500000, 5 => 333333, 7 => 111111, 11 => 55555
1000000.times { freq_hash[nonuniform_random(numbers, probabilities)] += 1 }

puts freq_hash
