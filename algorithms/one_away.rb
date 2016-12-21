# check if two strings are one or zero edits different
# edit can be deletion, insertion, or replacement

require 'rspec/autorun'

def one_away(str1, str2)
  return false if (str1.length - str2.length).abs > 1

  i = 0
  while i < str1.length
    if str1[i] != str2[i]
      if str1.length > str2.length
        return str1[(i+1)..-1] == str2[i..-1]
      elsif str2.length > str1.length
        return str1[i..-1] == str2[(i+1)..-1]
      else
        return str1[(i+1)..-1] == str2[(i+1)..-1]
      end
    end

    i += 1
  end
end

describe 'one_away' do
  it 'handles single deletions' do
    expect(one_away('pale', 'ple')).to be true
  end

  it 'handles single insertions' do
    expect(one_away('ple', 'pale')).to be true
  end

  it 'handles single replacement' do
    expect(one_away('pale', 'bale')).to be true
  end

  it 'handles multiple deletions' do
    expect(one_away('pale', 'paalle')).to be false
  end
end
