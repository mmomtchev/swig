var dynamic_cast = require("dynamic_cast");

var f = new dynamic_cast.Foo();
if (!(f instanceof dynamic_cast.Foo)) throw new Error;
var b = new dynamic_cast.Bar();
if (!(b instanceof dynamic_cast.Foo)) throw new Error;
if (!(b instanceof dynamic_cast.Bar)) throw new Error;

var x = /* await */(f.blah());
if (!(x instanceof dynamic_cast.Foo)) throw new Error;
var y = /* await */(b.blah());
if (!(y instanceof dynamic_cast.Foo)) throw new Error;
// This line allows TS to infer the type 
if (!(y instanceof dynamic_cast.Bar)) throw new Error;

var a = /* await */(dynamic_cast.do_test(y));
if (a !== "Bar::test") {
  throw new Error("Failed.");
}
