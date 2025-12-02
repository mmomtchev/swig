var iadd = require('iadd');

var f = new iadd.Foo();

f.AsA.x = 3;
/* await */(f.AsA.addto(f.AsA));

var pass = false;
try {
  // @ts-expect-error
  f.AsA.addto('invalid');
} catch (e) {
  pass = true;
}
if (!pass) throw new Error();

if (f.AsA.x != 6)
    throw new Error;
