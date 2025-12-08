var typesscript_type_restrictions = require("typescript_type_restrictions");

var a = new typesscript_type_restrictions.A;
if (/* await */(a.method()) != 'A') throw new Error('Failed a');
if (/* await */(typesscript_type_restrictions.takeA(a)) != 'A') throw new Error('Failed a');

var b = new typesscript_type_restrictions.B;
var pass = false;
if (/* await */(b.method()) != 'B') throw new Error('Failed b');
try {
// @ts-expect-error
/* await */(typesscript_type_restrictions.takeA(b));
} catch {
  pass = true;
}
if (!pass) throw new Error('b should have failed');

var c = new typesscript_type_restrictions.C;
if (/* await */(c.method()) != 'C') throw new Error('Failed c');
if (/* await */(typesscript_type_restrictions.takeA(c)) != 'C') throw new Error('Failed c');
