# check if n number of strings are balanced brackets

t = gets.strip.to_i
hash = { ")" => "(", "]" => "[", "}" => "{" }

for a0 in (0..t-1)
  maybe_yes = true
  stack = []
  expression = gets.strip
  expression.chars do |c|

    if stack.include?(hash[c])
      peek = stack.pop
      unless peek == hash[c]
        puts "NO\n"
        maybe_yes = false
        break
      end
    else
        if hash.keys.include?(c)
          puts "NO\n"
          maybe_yes = false
          break
        else
          stack.push(c)
        end
    end
  end


  if maybe_yes
    puts stack.empty? ? "YES" : "NO"
  end
end
