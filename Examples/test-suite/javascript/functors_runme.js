var functors = require("functors");

var a = new functors.Functor0(10);
var b = new functors.Functor1(10);
var c = new functors.Functor2(10);

if (/* await */(a.Funktor()) != -10)
    throw Error("a failed");
if (/* await */(b.Funktor(1)) != 11)
    throw Error("b failed");
if (/* await */(c.Funktor(1, 2)) != 13)
    throw Error("c failed");
