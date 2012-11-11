if (typeof vr == 'undefined') {
  vr = {};
}

if(typeof vr.graphs == 'undefined') {
  vr.graphs = {};
}

vr.integerGenerator = function(max) {
  if (max == 0) {
    return [0];
  } else {
    var array = vr.integerGenerator(max - 1);
    array.push(max);
    return array;
  }
}