%module cpp20_concepts

// SWIG provides only basic parser level support for C++20 concept declarations
// and requires-clauses: both are silently consumed and produce no node in the
// parse tree, so a constrained template wraps as if it were unconstrained.

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

// Function template with a prefix requires-clause - the constraint sits
// between the template head and the return type.
template<typename T>
requires Numeric<T>
T quad(T x) {
  return x * x * x * x;
}

// Prefix requires-clause with a compound constraint joined by '&&'.
template<typename T>
requires Numeric<T> && SmallNumeric<T>
T half(T x) {
  return x / 2;
}

// Prefix requires-clause with a parenthesised constraint subexpression.
template<typename T>
requires (Numeric<T> || std::same_as<T, bool>)
T identity(T x) {
  return x;
}
%}

%template(cube_int)     cube<int>;
%template(cube_double)  cube<double>;
%template(quad_int)     quad<int>;
%template(quad_double)  quad<double>;
%template(half_int)     half<int>;
%template(identity_int) identity<int>;
