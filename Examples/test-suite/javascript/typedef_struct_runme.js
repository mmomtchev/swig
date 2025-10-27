var typedef_struct = require("typedef_struct");

var x = new typedef_struct.LineObj;
if (x.numpoints != 0)
  throw new Error;
x.numpoints = 100;
if (x.numpoints != 100)
  throw new Error;

if (typedef_struct.MS_NOOVERRIDE != -1111)
  throw new Error;

var y = /* await */(typedef_struct.make_a());
if (y.a != 0)
  throw new Error;
var z = /* await */(typedef_struct.make_b());
if (z.a != 0)
  throw new Error;

var foo = new typedef_struct.Foo;
var enumvar = foo.enumvar;
if (enumvar != typedef_struct.Foo.NONAME1)
  throw new Error;
/* TODO: fix TS types for anonymous enums */
/* no-ts-expect-error ensure it is not any */
enumvar = 'invalid'
