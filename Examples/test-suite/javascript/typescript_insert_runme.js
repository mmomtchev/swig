var typescript_insert = require('typescript_insert');

var a = 2; //  @ts-replace var a: typescript_insert.Custom = 2;
var r = /* await */(typescript_insert.add(a, 3));
if (r !== 5) throw new Error;

var pass = false;
try {
  // @ts-expect-error
  /* await */(typescript_insert.add('a', 'b'));
} catch {
  pass = true;
}
if (!pass) throw new Error;
