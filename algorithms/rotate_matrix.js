function rotateMatrix (matrix) {
  if (matrix.length === 0 || matrix.length != matrix[0].length) {
    return [];
  }

  for (var layer = 0; layer < matrix.length /2; layer++) {
    let first = layer;
    let last = matrix.length - layer - 1;

    for (var i = first; i < last; i++) {
      let offSet = i - first;
      let top = matrix[first][i];

      matrix[first][i] = matrix[last-offSet][first];
      matrix[last-offSet][first] = matrix[last][last-offSet];
      matrix[last][last-offSet] = matrix[i][last];
      matrix[i][last] = top;
    }
  }

  return matrix;
}

let matrix = [
  [1, 2, 3, 4],
  [5, 6, 7, 8],
  [9, 10, 11, 12],
  [13, 14, 15, 16]
];

console.log(rotateMatrix(matrix));

// [01, 02, 03, 04]
// [05, 06, 07, 08]
// [09, 10, 11, 12]
// [13, 14, 15, 16]

// =>

// [13, 09, 05, 01]
// [14, 10, 06, 02]
// [15, 11, 07, 03]
// [16, 12, 08, 04]
