var ret_by_value = require("ret_by_value");

var a = /* await */(ret_by_value.get_test());
if (a.myInt != 100)
    throw "RuntimeError";

if (a.myShort != 200)
    throw "RuntimeError";
