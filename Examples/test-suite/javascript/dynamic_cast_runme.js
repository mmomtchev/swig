var dynamic_cast = require("dynamic_cast");

var f = new dynamic_cast.Foo();
if (!(f instanceof dynamic_cast.Foo)) throw new Error;
var b = new dynamic_cast.Bar();
if (!(b instanceof dynamic_cast.Bar)) throw new Error;

var x = /* await */(f.blah());
var y = /* await */(b.blah());

/* @ts-ignore */
var a = /* await */(dynamic_cast.do_test(y));
if (a !== "Bar::test") {
  throw new Error("Failed.");
}
