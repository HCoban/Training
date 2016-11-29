function leftRotation(n, k, a) {
    let rotated = new Array(n);

    a.forEach((el, idx) => {
      debugger;
      rotated[((idx - k + n) % n)] = el;
    });

    console.log(rotated);
}

leftRotation(5, 4, [1,2,3,4,5]);
