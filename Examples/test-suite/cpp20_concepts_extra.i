%module cpp20_concepts_extra

// Additional C++20 concept and requires-clause forms beyond the core suite:
// negation via parens, multi parameter requires-expression with mixed types,
// fold-expression over a pack (variadic concept), type trait primary, and
// deeper nesting of '&&' / '||' inside parens.

%inline %{
#include <concepts>
#include <type_traits>

template<typename T>
concept Numeric = std::integral<T> || std::floating_point<T>;

template<typename T>
concept Sized = (sizeof(T) <= 8);

// Negation of a concept-id is not a primary-expression in C++20; the user
// must wrap it in parens.  A struct that is not Numeric satisfies the
// constraint, so the function instantiates only for non-numeric types.
struct Tag {
  int n;
  Tag(int v) : n(v) {}
  int value() const { return n; }
};

template<typename T>
T identity_non_numeric(T x) requires (!Numeric<T>) { return x; }

// Multi parameter requires-expression mixing two unrelated template
// parameters, exercising the requirement-parameter-list with more than one
// parm of differing type.
template<typename T, typename U>
T mix_add(T a, U b) requires requires(T t, U u) { t + u; } {
  return a + (T)b;
}

// Variadic concept defined by a fold-expression over '&&' on a pack.
template<typename... Ts>
concept AllNumeric = (Numeric<Ts> && ...);

// Variadic function template constrained by the variadic concept.  The base
// case is unconstrained; the recursive case adds the constraint.
template<typename T>
T sum_all(T t) { return t; }

template<typename T, typename... Rest>
T sum_all(T first, Rest... rest) requires AllNumeric<T, Rest...> {
  return first + sum_all<T>((T)rest...);
}

// Type trait primary - 'std::is_integral_v<T>' is a constexpr bool, used
// here as a constraint atom rather than a concept-id.
template<typename T>
T trait_primary(T x) requires std::is_integral_v<T> { return x + x; }

// Deeper nesting of '&&' and '||' inside parens.
template<typename T>
T deeper(T x) requires (Numeric<T> && (Sized<T> || std::is_pointer_v<T>)) {
  return x;
}
%}

%template(identity_non_numeric_tag) identity_non_numeric<Tag>;
%template(mix_add_id)               mix_add<int, double>;
%template(sum_all_iii)              sum_all<int, int, int>;
%template(sum_all_ddd)              sum_all<double, double, double>;
%template(trait_primary_int)        trait_primary<int>;
%template(deeper_int)               deeper<int>;
