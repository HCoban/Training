def number_to_english(num)
  result = []
  m = num / 1000000
  if m > 0
    result.push(to_hundred(m) + ' million')
    num = num % 1000000
  end

  t = num / 1000
  if t > 0
    result.push(to_hundred(t) + ' thousand')
    num = num % 1000
  end

  result.push(to_hundred(num)) if num > 0

  result.join(" ")
end

def to_hundred(num)
  h = num / 100
  left = up_to_19(h) + ' hundred' if h > 0

  remainder = num % 100
  if remainder >= 20
    middle = up_to_90((remainder / 10) * 10)
    remainder -= ((remainder / 10) * 10)
  end

  last = up_to_19(remainder)

  [left, middle, last].select { |t| !t.nil? && !t.empty? }.join(' ')

end

def up_to_19(n)
  store = {
    1 => 'one',
    2 => 'two',
    3 => 'three',
    4 => 'four',
    5 => 'five',
    6 => 'six',
    7 => 'seven',
    8 => 'eight',
    9 => 'nine',
    10 => 'ten',
    11 => 'eleven',
    12 => 'twelve',
    13 => 'thirteen',
    14 => 'fourteen',
    15 => 'fifteen',
    16 => 'sixteen',
    17 => 'seventeen',
    18 => 'eighteen',
    19 => 'nineteen'
  }

  store[n]
end

def up_to_90(n)
  store = {
    20 => 'twenty',
    30 => 'thirty',
    40 => 'fourty',
    50 => 'fifty',
    60 => 'sixty',
    70 => 'seventy',
    80 => 'eighty',
    90 => 'ninety'
  }

  store[n]
end
