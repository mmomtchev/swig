var global_vars = require("global_vars");

// In javascript, assigning to a non-existent variable is
// not an error

/* await */(global_vars.init());
var b = global_vars.b;
if (b != "string b") {
    throw new Error("Unexpected string: " + b.toString());
}
global_vars.b = "a string value";
b = global_vars.b;
if (b != "a string value") {
    throw new Error("Unexpected string: " + b.toString());
}

var x = global_vars.x;
if (x != 1234) {
    throw new Error("Unexpected x: " + x.toString());
}
global_vars.x = 9876;
x = global_vars.x;
if (x != 9876) {
    throw new Error("Unexpected string: " + x.toString());
}

// check for symbol leaks
var symbols = [
  'A',
  'b',
  'a',
  'ap',
  'cap',
  'ar',
  'x',
  'xp',
  'c_member',
  'vp',
  'Hi',
  'Hola',
  'h',
  'hp',
  'hr',
  'init',
  'read_x',
  'read_b'
];
if (JSON.stringify(symbols) != JSON.stringify(Object.getOwnPropertyNames(global_vars)))
    throw new Error(`Unexpected symbols: ` + Object.getOwnPropertyNames(global_vars));
