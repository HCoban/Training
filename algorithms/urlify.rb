require 'rspec/autorun'


def urlify(string)
  string.gsub(" ", "%20")
end

describe 'urlify' do
  it 'converts a string to url' do
    expect(urlify('Mr John Smith')).to eq('Mr%20John%20Smith')
  end
end
