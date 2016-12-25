# A simple Trie implementation using a Hash
class Trie < Hash
  def initialize
    super
  end

  def build(string)
    ((string.chars)+[""]).inject(self) do |h, char|
      h[char] ||= { }
    end
  end

  def find(string)
    hash = self
    string.each_char do |c|
      return {} unless hash[c]
      hash = hash[c]
    end

    hash
  end
end
