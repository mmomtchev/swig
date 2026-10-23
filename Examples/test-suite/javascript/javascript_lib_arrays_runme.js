var javascript_lib_arrays = require("javascript_lib_arrays");

var arr = [1, 2, 3, 4, 5];

function check(a, b) { //  @ts-replace function check<T>(a: T, b: T) {
  if (a !== b) {
    throw new Error("Not equal: " + a + " " + b)
  }
}

function check_array(a, b) { //  @ts-replace function check_array<T>(a: T[], b: T[]) {
  if (a.length != b.length)
    throw new Error("Array length mismatch " + a.length + " " + b.length)
  if (!a.every(function(element, index) { return element === b[index]; }))
    throw new Error("Arrays don't match a:" + a + " b:" + b)
}

check(15, /* await */(javascript_lib_arrays.sum1(arr, arr.length)));
check(6, /* await */(javascript_lib_arrays.sum2(arr)));
check_array([1, 2, 3, 4], javascript_lib_arrays.data3);

// null is passed on as a NULL pointer for an array parameter
check(1, /* await */(javascript_lib_arrays.isnull(null)));
check(1, /* await */(javascript_lib_arrays.isnull_sized(null)));
check(0, /* await */(javascript_lib_arrays.isnull(arr)));

// Setting an array variable to null throws, leaving the array unchanged
var threw = false;
try {
  javascript_lib_arrays.data3 = null;
} catch (e) {
  threw = true;
}
if (!threw)
  throw new Error("data3 = null did not throw");
check_array([1, 2, 3, 4], javascript_lib_arrays.data3)
