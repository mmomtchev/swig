%module cpp20_concepts_constrained_param

// C++20 type constrained template parameters: 'template<Concept T>' as a
// shorthand for 'template<typename T> requires Concept<T>'.  Covers the
// single parm form, mixed type-constraint and plain typename, ::-qualified
// concept-ids, variadic packs, default arguments, and constrained class
// templates.

%inline %{
#include <concepts>

template<typename T>
concept Numeric = std::integral<T> || std::floating_point<T>;

template<typename T>
concept SmallNumeric = Numeric<T> && (sizeof(T) <= 4);

template<typename T>
concept FloatingPoint = std::floating_point<T>;

namespace nest {
  template<typename T>
  concept Integral = std::integral<T>;
}

// 1. Textbook form: single type constrained parameter.
template<Numeric T>
T cube(T x) { return x * x * x; }

// 2. ::-qualified concept-id.
template<nest::Integral T>
T half(T x) { return x / 2; }

// 3. Mixed type-constraint + plain typename in the same head.
template<Numeric T, typename U>
T scale(T x, U factor) { return T(x * factor); }

// 4. Default template argument paired with a type-constraint.
template<Numeric T = int>
T identity(T x) { return x; }

// 5. Two type-constraints in one head, one of them refining the other.
template<Numeric T, SmallNumeric U>
T combine(T x, U y) { return x + T(y); }

// 6. Variadic type constrained pack.
template<Numeric... Ts>
int count_numeric(Ts...) { return int(sizeof...(Ts)); }

// 6a. Leading plain typename followed by a type constrained pack.
template<typename X, Numeric... Ts>
int tag_count(X, Ts...) { return int(sizeof...(Ts)); }

// 6b. Two type-constraints with the trailing one a variadic pack.
template<SmallNumeric X, Numeric... Ts>
int small_tag_count(X, Ts...) { return int(sizeof...(Ts)); }

// 7. Constrained class template.
template<Numeric T>
class Box {
  T v;
public:
  Box() : v(T()) {}
  Box(T x) : v(x) {}
  T get() const { return v; }
  void set(T x) { v = x; }
};

// 8. Constrained class template, locally defined ::-qualified concept-id.
template<FloatingPoint T>
class FloatBox {
  T v;
public:
  FloatBox() : v(T()) {}
  FloatBox(T x) : v(x) {}
  T get() const { return v; }
};
%}

%template(cube_int) cube<int>;
%template(cube_double) cube<double>;
%template(half_int) half<int>;
%template(scale_di) scale<double, int>;
%template(identity_int) identity<int>;
%template(combine_id) combine<int, char>;
%template(count_numeric_1) count_numeric<int>;
%template(count_numeric_3) count_numeric<int, double, char>;
%template(tag_count_si)    tag_count<const char *, int>;
%template(tag_count_s3)    tag_count<const char *, int, double, char>;
%template(small_tag_count_ci) small_tag_count<char, int>;
%template(small_tag_count_c3) small_tag_count<char, int, double, char>;
%template(BoxInt) Box<int>;
%template(BoxDouble) Box<double>;
%template(FloatBoxFloat) FloatBox<float>;
