
var li_cdata = require("li_cdata");

// Set "ABC abc"
var s = new Uint8Array([65, 66, 67, 32, 97, 98, 99]);
var m = /* await */(li_cdata.malloc(256));
/* await */(li_cdata.memmove(m, s));
var ss = /* await */(li_cdata.cdata(m, 7));
// Translate Uint8Array to string
var a = ""; ss.forEach((i) => a += String.fromCharCode(i));
if (a !== "ABC abc") {
  throw new Error("failed");
}
