class Node
  attr_reader :value, :left, :right
  def initialize(value)
    @value = value
    @left = nil
    @right = nil
  end

  def insert(node)
    if @value >= node.value
      if @left.nil?
        @left = node
      else
        @left.insert(node)
      end
    else
      if @right.nil?
        @right = node
      else
        @right.insert(node)
      end
    end
  end

  # def to_s(indent, last=nil)
  #   print indent
  #   if last
  #     print "└─"
  #     indent += "  "
  #   else
  #     print "├─"
  #     indent += "| "
  #   end
  #   print @value.to_s + "\n"
  #   if @left
  #     @left.to_s(indent)
  #   end
  #   if @right
  #     @right.to_s(indent, true)
  #   end
  # end

end

# root = Node.new(5)
# current = 5
# until current == 9
#   root.insert(Node.new(current-1))
#   root.insert(Node.new(current+1))
#   current += 1
# end

# root.to_s("  ", true)

def height(node)
  return -1 unless node
  [height(node.left), height(node.right)].max + 1
end

# puts height(root)

def balanced?(node)
  return true unless node

  l_height = height(node.left)
  r_height = height(node.right)

  if (l_height - r_height).abs > 1
    return false
  else
    balanced?(node.left) && balanced?(node.right)
  end
end

# puts balanced?(root)

# r = Node.new(5)
# r.insert(Node.new(4))
# r.insert(Node.new(6))
#
# puts r.to_s("  ")
# puts balanced?(r)
