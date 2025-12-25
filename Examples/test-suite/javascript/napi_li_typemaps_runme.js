var napi_li_typemaps = require("napi_li_typemaps");

function check(a, b) { // @ts-replace function check<T>(a: T, b: T): void {
  if (a !== b) {
    throw new Error("Not equal: " + a + " " + b);
  }
}

function check_object(a, b) { // @ts-replace function check_object<T>(a: T, b: T): void {
  if (Object.getOwnPropertyNames(a).length != Object.getOwnPropertyNames(b).length)
    throw new Error(`Object properties mismatch "${Object.getOwnPropertyNames(a).join(',')}" != "${Object.getOwnPropertyNames(b).join(',')}"`);
  for (const p of Object.getOwnPropertyNames(a)) {
    if (a[p] !== b[p])
      throw new Error(`Properties ${p} don't match a["${p}"] (${a[p]}) != b["${p}"] (${b[p]})`);
  }
}

// Check double INPUT typemaps
check(/* await */(napi_li_typemaps.in_double(22.22)), 22.22);
check(/* await */(napi_li_typemaps.inr_double(22.22)), 22.22);

// Check double OUTPUT typemaps
check_object(/* await */(napi_li_typemaps.out_double(22.22)), { OUTPUT_FIELD: 22.22 });
check_object(/* await */(napi_li_typemaps.outr_double(22.22)), { OUTPUT_FIELD: 22.22 });

// Check double INOUT typemaps
check_object(/* await */(napi_li_typemaps.inout_double(22.22)), {  INOUT_FIELD: 22.22 });
check_object(/* await */(napi_li_typemaps.inoutr_double(22.22)), { INOUT_FIELD: 22.22 });

// check long long
check(/* await */(napi_li_typemaps.in_ulonglong(20)), 20);
check(/* await */(napi_li_typemaps.inr_ulonglong(20)), 20);
check_object(/* await */(napi_li_typemaps.out_ulonglong(20)), { OUTPUT_FIELD: 20 });
check_object(/* await */(napi_li_typemaps.outr_ulonglong(20)), { OUTPUT_FIELD: 20 });
check_object(/* await */(napi_li_typemaps.inout_ulonglong(20)), { INOUT_FIELD: 20 });
check_object(/* await */(napi_li_typemaps.inoutr_ulonglong(20)), { INOUT_FIELD: 20 });

// check bools
check(/* await */(napi_li_typemaps.in_bool(true)), true);
check(/* await */(napi_li_typemaps.inr_bool(false)), false);
check_object(/* await */(napi_li_typemaps.out_bool(true)), { OUTPUT_FIELD: true });
check_object(/* await */(napi_li_typemaps.outr_bool(false)), { OUTPUT_FIELD: false });


check_object(/* await */(napi_li_typemaps.inout_bool(true)), { INOUT_FIELD: true });
check_object(/* await */(napi_li_typemaps.inoutr_bool(false)), { INOUT_FIELD: false });

// the others
check_object(/* await */(napi_li_typemaps.inoutr_int2(1, 2)), { INOUT_FIELD: 1, inout2: 2 });

// return object
var fi = /* await */(napi_li_typemaps.out_foo(10));
check(fi.result.a, 10);
check(fi.OUTPUT_FIELD, 20);
check(fi.OUTPUT_FIELD2, 30);

// rename result
var fi2 = /* await */(napi_li_typemaps.out_foo_status(10));
check(fi2.status.a, 10);
check(fi2.OUTPUT_FIELD, 20);
check(fi2.OUTPUT_FIELD2, 30);

// remove result
var fi3 = /* await */(napi_li_typemaps.out_foo_void(10));
check_object(fi3, { OUTPUT_FIELD: 20, OUTPUT_FIELD2: 30 });

// real world example
var r = /* await */(napi_li_typemaps.return_multiple_values(-1));
check_object(r, { value1: 1, value2: -2, value3: -1 });
r = /* await */(napi_li_typemaps.return_multiple_values(1));
check_object(r, { value1: -1, value2: true, value3: 1 });
var pass = false;
try {
  /* await */(napi_li_typemaps.return_multiple_values(0));
} catch (e) {
  if (e.message.match(/Zero/))
    pass = true;
}
if (!pass) throw new Error('Did not throw');
