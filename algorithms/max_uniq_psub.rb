def max_uniq_psub(string)
  alphabet = ("a".."z").to_a
  return nil if string.empty?
  return string if string.length == 1

  current = alphabet.index(string[0])
  next_e = alphabet.index(string[1])
  if next_e > current
    return max_uniq_psub(string[1..-1])
  else
    return string[0] + max_uniq_psub(string[1..-1])
  end
end
