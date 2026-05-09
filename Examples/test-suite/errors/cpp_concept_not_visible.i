%module xxx

// 'Numeric' is referenced as a type-constraint in the template parameter list
// but no concept named 'Numeric' is declared in scope.  SWIG cannot disambiguate
// this from a misspelt non-type template parameter type and rejects it with a
// pointed error.
%inline %{
template<Numeric T>
T cube(T x) { return x * x * x; }
%}
