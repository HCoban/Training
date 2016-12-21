require 'rspec/autorun'

# O(n) time O(1) space
def palindrome_permutation(str)
  freq_hash = {}

  # O(n) time
  str.each_char do |c|
    next if c == ' '
    c = c.downcase
    if freq_hash[c]
      freq_hash[c] += 1
    else
      freq_hash[c] = 1
    end
  end

  # O(n) time
  freq_hash.select { |char, count| count%2 == 1 }.count <= 1
end

describe 'palindrome_permutation' do

  it 'correctly returns true for strings that are permutations of a palindrome' do
    expect(palindrome_permutation('Tact Coa')).to be true
  end

  it 'correctly returns false for strings that are not permutations of a palindrome' do
    expect(palindrome_permutation('hello')).to be false
  end
end
