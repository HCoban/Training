require 'byebug'

n,k,q = gets.strip.split(' ')
n = n.to_i
k = k.to_i
q = q.to_i
a = gets.strip
a = a.split(' ').map(&:to_i)

rotated = Array.new(n)

n.times do |i|
    rotated[(i + k) % n] = a[i]
end

for a0 in (0..q-1)
    m = gets.strip.to_i
    puts rotated[m]
end
