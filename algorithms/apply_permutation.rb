require 'rspec/autorun'

def apply_permutation(arr, perm)
  i = 0
  while i < arr.length
    next_idx = i

    while perm[next_idx]
      arr[i], arr[perm[next_idx]] = arr[perm[next_idx]], arr[i]
      temp = perm[next_idx]
      perm[next_idx] = false
      next_idx = temp
    end
    i += 1
  end

  arr

end

describe 'apply_permutation' do
  it 'correctly applies a permutation to an array' do
    array = ['a', 'b', 'c', 'd']
    permutations = [3, 1, 2, 0]
    expect(apply_permutation(array, permutations)).to eq(['d', 'b', 'c', 'a'])
  end
end
