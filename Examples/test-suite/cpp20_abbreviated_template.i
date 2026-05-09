%module cpp20_abbreviated_template

// C++20 abbreviated function templates - 'auto' as a parameter type in an ordinary function.  Each auto
// parameter introduces an invented type template parameter (per [dcl.fct]/22), so the function becomes
// a function template that the user can instantiate with %template just like a regular template.
//
// The function must declare an explicit (non-auto) return type for SWIG to wrap it - SWIG cannot deduce
// auto return types (this restriction is shared with the C++14 auto return feature; see the existing
// cpp14_auto_return_type.i test and docs).

%inline %{
// Single auto parameter, explicit int return.
int twice(auto x) { return x + x; }

// Two auto parameters, explicit double return.
double scale(auto x, auto factor) { return x * factor; }

// Three auto parameters, explicit int return.
int sum3(auto a, auto b, auto c) { return a + b + c; }

// Unnamed auto parameter - the invented type template parameter is still introduced even though the parm has no name.
int unnamed_auto(auto) { return 42; }
%}

%template(twice_int)         twice<int>;
%template(twice_short)       twice<short>;
%template(scale_id)          scale<int, double>;
%template(sum3_iii)          sum3<int, int, int>;
%template(unnamed_auto_int)  unnamed_auto<int>;
