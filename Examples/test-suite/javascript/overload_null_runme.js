// There are no typecheck typemaps in Javascript yet, so most of this test
// does not actually worked - the check functions have thus been commented out.
var overload_null = require("overload_null");

var check = function(expected, actual) {
  if (expected !== actual) {
    throw new Error(`${actual} does not equal ${expected}`);
  }
};


var o = new overload_null.Overload();
var x = new overload_null.X();

check(1, /* await */(o.byval1(x)));
// check(2, o.byval1(null));

// check(3, o.byval2(null));
check(4, /* await */(o.byval2(x)));

check(5, /* await */(o.byref1(x)));
// check(6, o.byref1(null));

// check(7, o.byref2(null));
check(8, /* await */(o.byref2(x)));

check(9, /* await */(o.byconstref1(x)));
// check(10, o.byconstref1(null));

// check(11, o.byconstref2(null));
check(12, /* await */(o.byconstref2(x)));

// const pointer references
check(13, /* await */(o.byval1cpr(x)));
// check(14, o.byval1cpr(null));

// check(15, o.byval2cpr(null));
check(16, /* await */(o.byval2cpr(x)));

// fwd class declaration
check(17, /* await */(o.byval1fwdptr(x)));
// check(18, o.byval1fwdptr(null));

// check(19, o.byval2fwdptr(null));
check(20, /* await */(o.byval2fwdptr(x)));

check(21, /* await */(o.byval1fwdref(x)));

check(22, /* await */(o.byval2fwdref(x)));
