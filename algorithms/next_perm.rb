require 'rspec/autorun'


def next_perm(perm)
  return [] if perm.length < 2
  idx = perm.length - 1
  while idx > 0
    if perm[(idx-1)] < perm[idx]
      swap_idx = (idx - 1)
    end
    idx -= 1
  end

  return [] unless swap_idx

  idx = perm.length - 1
  while idx > swap_idx
    if perm[idx] > perm[swap_idx]
      perm[idx], perm[swap_idx] = perm[swap_idx], perm[idx]
      break
    end

    idx -= 1
  end

  perm[0..swap_idx].concat(perm[swap_idx+1..-1].reverse)
end

describe 'next_perm' do
  it 'correctly finds the next permutation' do
    perm = [6, 2, 1, 5, 4, 3, 0]
    expect(next_perm(perm)).to eq([6, 2, 3, 0, 1, 4, 5])
  end
end

describe 'next_perm' do
  it 'returns empty array if there is no next permutation' do
    perm = [6, 5, 3, 3, 2, 1, 0]
    expect(next_perm(perm)).to eq([])
  end
end

describe 'next_perm' do
  it 'returns empty array if there is no permutation' do
    perm = [0]
    expect(next_perm(perm)).to eq([])
  end
end
