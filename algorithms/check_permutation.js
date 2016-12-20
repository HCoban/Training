// O(n) time O(1) space
function checkPermutation (str1, str2) {
  let freqHash = {};

  // O(n) time, O(1) space (space is O(1) considering limited character variability)
  for (var i = 0; i < str1.length; i++) {
    let char = str1[i];
    if (freqHash[char]) {
      freqHash[char]++;
    } else {
      freqHash[char] = 1;
    }
  }

  // O(n) time
  for (var i = 0; i < str2.length; i++) {
    let char = str2[i];
    if (freqHash[char] && freqHash[char] > 0) {
      freqHash[char]--;
    } else {
      return false;
    }
  }

  // O(n) time
  Object.keys(freqHash).forEach(key => {
    if (freqHash[key] !== 0) {
      return false;
    }
  });

  return true;

}

console.log(checkPermutation('hello', 'olhle'));
console.log(checkPermutation('hi', 'hello'));
