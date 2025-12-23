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
check_object(/* await */(napi_li_typemaps.out_double(22.22)), { result: undefined, OUTPUT_FIELD: 22.22 });
check_object(/* await */(napi_li_typemaps.outr_double(22.22)), { result: undefined, OUTPUT_FIELD: 22.22 });

// Check double INOUT typemaps
//check_object(/* await */(napi_li_typemaps.inout_double(22.22)), { result: undefined, OUTPUT_FIELD: 22.22 });
//check_object(/* await */(napi_li_typemaps.inoutr_double(22.22)), { result: undefined, OUTPUT_FIELD: 22.22 });

// check long long
check(/* await */(napi_li_typemaps.in_ulonglong(20)), 20);
check(/* await */(napi_li_typemaps.inr_ulonglong(20)), 20);
check_object(/* await */(napi_li_typemaps.out_ulonglong(20)), { result: undefined, OUTPUT_FIELD: 20 });
check_object(/* await */(napi_li_typemaps.outr_ulonglong(20)), { result: undefined, OUTPUT_FIELD: 20 });
//check_object(/* await */(napi_li_typemaps.inout_ulonglong(20)), { result: undefined, OUTPUT_FIELD: 20 });
//check_object(/* await */(napi_li_typemaps.inoutr_ulonglong(20)), { result: undefined, OUTPUT_FIELD: 20 });

// check bools
check(/* await */(napi_li_typemaps.in_bool(true)), true);
check(/* await */(napi_li_typemaps.inr_bool(false)), false);
check_object(/* await */(napi_li_typemaps.out_bool(true)), { result: undefined, OUTPUT_FIELD: true });
check_object(/* await */(napi_li_typemaps.outr_bool(false)), { result: undefined, OUTPUT_FIELD: false });


//check_object(/* await */(napi_li_typemaps.inout_bool(true)), [true]);
//check_object(/* await */(napi_li_typemaps.inoutr_bool(false)), [false]);

// the others
//check_object(/* await */(napi_li_typemaps.inoutr_int2(1, 2)), [1, 2]);

//var fi = /* await */(napi_li_typemaps.out_foo(10));
/* @_ts-ignore : too twisted to support */
//check(fi[0].a, 10);
//check(fi[1], 20);
//check(fi[2], 30);
