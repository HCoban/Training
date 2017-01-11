require './BST.rb'

arr = [5,3,2,6,7,1]

root = Node.new(4)

arr.each { |el| root.insert(Node.new(el))}

puts root
