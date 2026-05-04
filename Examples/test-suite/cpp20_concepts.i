%module cpp20_concepts

// SWIG provides only basic parser level support for C++20 concept declarations
// and trailing requires-clauses: both are silently consumed and produce no
// node in the parse tree, so a constrained template wraps as if it were
// unconstrained.  Prefix requires-clauses (between the template head and the
// declarator) are not yet supported.

%inline %{
#include <concepts>

template<typename T>
concept Numeric = std::integral<T> || std::floating_point<T>;

// A concept whose body refers to another concept (and uses sizeof in a
// parenthesised subexpression to exercise paren tracking in the skipper).
template<typename T>
concept SmallNumeric = Numeric<T> && (sizeof(T) <= 4);

// Function template with a trailing requires-clause.
template<typename T>
T cube(T x) requires Numeric<T> {
  return x * x * x;
}
%}

%template(cube_int)    cube<int>;
%template(cube_double) cube<double>;
