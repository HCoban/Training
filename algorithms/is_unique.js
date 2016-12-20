function isUnique (string) {
  let store = {};

  for (var i = 0; i < string.length; i++) {
    let char = string[i];
    if (store[char]) {
      return false;
    } else {
      store[char] = true;
    }
  }

  return true;
}

console.log(isUnique('hello'));
console.log(isUnique('hi'));
