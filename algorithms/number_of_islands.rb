require 'rspec/autorun'

def nummber_of_islands(matrix)
  visited = Array.new(matrix.length) { Array.new(matrix[0].length)}

  count = 0

  i = 0
  while i < matrix.length
    j = 0
    while j < matrix[0].length
      if visited[i][j].nil? && matrix[i][j] == 1
        visited[i][j] = true
        count += 1
        mark_neighbors!(matrix, visited, i, j)
      end
      j += 1
    end
    i += 1
  end

  count
end

def mark_neighbors!(matrix, visited, i, j)
  offsets = [-1, 0, 1]
  offsets.each do |x|
    offsets.each do |y|
      next if x == 0 && y == 0
      if i + x >= 0 && i + x < matrix.length && j + y >= 0 && j + y < matrix[0].length
        next if visited[i+x][j+y]
        if matrix[i+x][j+y] == 1

          visited[i+x][j+y] = true
          mark_neighbors!(matrix, visited, i+x, j+y)
        end
      end
    end
  end
end

matrix = [
  [1, 0, 1, 0, 1],
  [1, 1, 0, 0, 0],
  [0, 1, 0, 1, 1]
]

describe "nummber_of_islands" do
  it "correctly calculates number of islands" do
    expect(nummber_of_islands(matrix)).to be(3)
  end
end
