// basic string compression using the counts of repeated characters

function stringCompression (str) {
  var result = "";
  var current;
  let count;
  for (var i = 0; i < str.length; i++) {
    if (current == undefined || current != str[i]) {
      current = str[i];
      if (count) {
        result += count;
      }
      result += str[i];
      count = 1;
    } else {
      count += 1;
    }

  }

  result += count;
  if (result.length < str.length) {
    return result;
  } else {
    return str;
  }
}

console.log(stringCompression('aabcccccaaa'));
