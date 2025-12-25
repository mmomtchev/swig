%module napi_typescript_typemaps

// Mismatched merge strategies between argument and the function
%typemap(ts, merge="array") int fn2 "number";
%typemap(tsout, merge="object") int y "number";

int fn2(int x, int y, int z);
