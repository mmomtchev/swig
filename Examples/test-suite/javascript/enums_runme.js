
var enums = require("enums");

/* await */(enums.bar2(enums.FGHJI));
/* await */(enums.bar3(enums.ABCDE));
/* await */(enums.bar1(enums.CSP_ITERATION_BWD));
/* await */(enums.barptr(enums.CSP_ITERATION_BWD));

let ok = false
try {
  // @ts-expect-error ensure that argument is not any
  /* await */(enums.bar1('test'))
} catch {
  ok = true
}
if (!ok) throw new Error;

let x = enums.FGHJI
// @ts-expect-error ensure the variable is not any
x = 'invalid'

if (enums.enumInstance != 2) {
    throw new Error;
}

if (enums.Slap != 10) {
    throw new Error;
}

if (enums.Mine != 11) {
    throw new Error;
}

if (enums.Thigh != 12) {
    throw new Error;
}
