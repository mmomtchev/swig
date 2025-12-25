%module napi_typescript_typemaps

// Mismatched merge strategies in arguments
%typemap(tsout, merge="object") int b "number";
%typemap(tsout, merge="array") int c "number";

void fn1(int a, int b, int c);
