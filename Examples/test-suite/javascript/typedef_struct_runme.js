var typedef_struct = require("typedef_struct");

var x = new typedef_struct.LineObj;
if (typeof x.numpoints !== 'number')
  throw new Error;
x.numpoints = 100;
if (x.numpoints !== 100)
  throw new Error;

let MS_NOOVERRIDE = typedef_struct.MS_NOOVERRIDE
if (MS_NOOVERRIDE !== -1111)
  throw new Error;
/* @ts-expect-error ensure the type is not any */
MS_NOOVERRIDE = 'invalid';

var y = /* await */(typedef_struct.make_a());
if (typeof y.a !== 'number')
  throw new Error;
/* @ts-expect-error ensure the type is not any */
y = 'invalid'

var z = /* await */(typedef_struct.make_b());
if (typeof z.a !== 'number')
  throw new Error;
/* @ts-expect-error ensure the type is not any */
z = 'invalid'

// ensure y and z have the same TS type
y = z

var foo = new typedef_struct.Foo;
var enumvar = foo.enumvar;
if (typeof enumvar !== typeof typedef_struct.Foo.NONAME1)
  throw new Error;
/* TODO: fix TS types for anonymous enums */
/* no-ts-expect-error ensure it is not any */
enumvar = 'invalid'
