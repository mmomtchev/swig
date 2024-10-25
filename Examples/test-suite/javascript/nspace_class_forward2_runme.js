var nspace_class_forward2 = require('nspace_class_forward2');

var foo = new nspace_class_forward2.NS.Foo(2);
if (/* await */(nspace_class_forward2.NS.fn(foo)) !== 2)
  throw new Error('Expected 2');

let fail = true;
// In TS mode, this checks that the TS type is not any (it fails when compiling)
// In JS mode, this checks that the exception is thrown (it fails when run)
try {
  /* @ts-expect-error */
  /* await */(nspace_class_forward2.NS.fn(12));
} catch (e) {
  fail = false;
}

if (fail)
  throw new Error('expected exception');