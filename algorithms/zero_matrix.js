function zeroMatrix (matrix) {
  let rows = [];
  let cols = [];

  for (var i = 0; i < matrix.length; i++) {
    for (var j = 0; j < matrix.length; j++) {
      if (matrix[i][j] === 0) {
        rows.push(i);
        cols.push(j);
      }
    }
  }


  rows.forEach(row => {
    matrix[row] = matrix[row].map (el => {
      return 0;
    });
  });

  cols.forEach(col => {
    for (var i = 0; i < matrix.length; i++) {
      matrix[i][col] = 0;
    }
  });

  return matrix;
}


let matrix = [
  [1, 2, 0, 4],
  [5, 6, 7, 8],
  [9, 0, 11, 12],
  [13, 14, 15, 16]
];

console.log(zeroMatrix(matrix));


// [01, 02, 00, 04]
// [05, 06, 07, 08]
// [09, 00, 11, 12]
// [13, 14, 15, 16]

// =>

// [00, 00, 00, 00]
// [05, 00, 00, 08]
// [00, 00, 00, 00]
// [13, 00, 00, 16]
