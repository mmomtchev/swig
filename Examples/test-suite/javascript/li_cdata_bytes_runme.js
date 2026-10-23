var li_cdata_bytes = require("li_cdata_bytes");

var m = /* await */(li_cdata_bytes.predefStr());
var s = /* await */(li_cdata_bytes.cdata(m, 512));
// 's' is Uint8Array, verify its property
if (!ArrayBuffer.isView(s) || s.byteLength != 512 ||
    s.length != 512 || s.BYTES_PER_ELEMENT != 1) {
  throw new Error("'s' do not have proper properties");
}
// verify 's' content
for (var i = 0; i < 256; i++) {
  if (s[i] != i)
    throw new Error("Wrong value " + s[i] + " at index " + i);
  if (s[i + 256] != i)
    throw new Error("Wrong value " + s[i + 256] + " at index " + (i + 256));
}
// Fill 's' with new content
for (var i = 0; i < 256; i++) {
  var v = 256 - 1 - i;
  s[i] = v;
  s[i + 256] = v;
}
var m2 = /* await */(li_cdata_bytes.malloc(512));
// Copy 's' into a new allocated memory
/* await */(li_cdata_bytes.memmove(m2, s));
if (/* await */(li_cdata_bytes.verifyBytes(m2)) != 0) {
  throw new Error("verifyBytes fails");
}
/* await */(li_cdata_bytes.free(m2));
