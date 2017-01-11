# Enter your code here. Read input from STDIN. Print output to STDOUT
class Graph
  attr_accessor :nodes

  def initialize
    @nodes = []
  end

  def find(val)
    @nodes.select { |node| node.value == val }.first
  end
end

class Node
  attr_reader :value
  attr_accessor :adjacent

  def initialize(graph, val)
    @value = val
    @adjacent = []
    graph.nodes << self
  end

  def add_adjacent(node)
    @adjacent << node unless @adjacent.include?(node)
    node.adjacent << self unless node.adjacent.include?(self)
  end

  def path(node)
    distance = 0
    queue = [];
    visited = []
    return 0 if self == node
    queue.push(self)
    visited.push(self)
    until queue.empty?
      distance += 1
      current = queue.shift
      current.adjacent.each { |c| queue.push(c) unless visited.include?(c) }
      queue.length.times do
        c = queue.shift
        return distance*6 if c == node
        visited << c
        c.adjacent.each { |cc| queue << cc }
      end
    end
    return -1
  end

end


queries = gets.chomp.to_i

queries.times do
  graph = Graph.new

  nodes, edges = gets.chomp.split(" ").map(&:to_i)
  nodes.times do |i|
    Node.new(graph, i+1)
  end

  edges.times do
    from, to = gets.chomp.split(" ").map(&:to_i)
    graph.find(from).add_adjacent(graph.find(to))
  end
  index = gets.chomp.to_i
  result = []
  from = graph.find(index)
  graph.nodes.each do |n|
    next if n.value == index
    result.push(from.path(n))
  end

  puts result.join(" ")
end
