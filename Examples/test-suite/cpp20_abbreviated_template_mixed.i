%module cpp20_abbreviated_template_mixed

// C++20 lets the abbreviated function template form (an 'auto' parameter) be combined with an explicit
// template-parameter list.  Per [dcl.fct]/19 each 'auto' parameter introduces an invented type template
// parameter that is appended to the explicit parameter list.  When using %template the user supplies
// arguments for the explicit parameters first, then for each invented one in the order the auto parms
// appear in the function declaration.

%include <std_string.i>

%inline %{
#include <concepts>
#include <string>

template<typename T>
concept Numeric = std::integral<T> || std::floating_point<T>;

namespace {
  template<typename U> std::string to_text(U v) { return std::to_string(v); }
  template<> std::string to_text(std::string v) { return v; }
}

// a. Explicit typename followed by an auto parameter.
//    T binds to std::string, the invented auto parm binds to int; result encodes both.
template<typename T>
std::string a_mix(T x, auto y) { return to_text(x) + ":" + to_text(y); }

// b. Auto parameter followed by an explicit typename.
//    auto binds to std::string, U binds to int.
template<typename U>
std::string b_mix(auto x, U y) { return to_text(x) + ":" + to_text(y); }

// c. Two explicit parms surrounding an auto, with trailing return type.
//    T binds to int, auto to std::string, V to int.
template<typename T, typename V>
auto c_mix(T x, auto y, V z) -> std::string {
  return to_text(x) + "/" + to_text(y) + "/" + to_text(z);
}

// d. Constrained explicit parm with a constrained auto parm.
//    Numeric T binds to int; Numeric auto binds to short.  short and int are distinct enough that
//    the runme uses the bound width to detect a swap (sizeof(int) != sizeof(short)).
template<Numeric T>
int d_mix(T x, Numeric auto y) {
  return int(x) * 1000 + int(y) * 10 + int(sizeof(T)) - int(sizeof(decltype(y)));
}

// Note: mixing an 'auto' parm with a variadic explicit pack (e.g.
// 'template<typename...Ts> int f(auto, Ts...)') is legal C++20 but %template
// cannot currently instantiate it.  SWIG's %template matcher requires the
// variadic parm to be last in the templateparms list, while C++20 [dcl.fct]/19
// appends the invented auto parm after the variadic.  The two orderings
// disagree on how %template arguments bind to the templateparms.  %template
// users in this position can write a thin non-templated wrapper.

// e. Two auto parms with an explicit typename between them.
//    First auto binds to std::string, T to int, second auto to std::string.
template<typename T>
std::string e_mix(auto x, T y, auto z) {
  return to_text(x) + "/" + to_text(y) + "/" + to_text(z);
}
%}

// The user supplies one %template argument for each template parameter, in order: every explicit
// parameter first, then one for each auto parameter in the declaration order.
%template(a_mix_si)   a_mix<std::string, int>;
// For b_mix the function signature is 'U b_mix(auto x, U y)'.  Template args go explicit first so
// <U=std::string, auto=int> means the wrapped signature is 'b_mix(int x, std::string y)'.  The
// suffix reflects the function parm order rather than the template arg order.
%template(b_mix_is)   b_mix<std::string, int>;
// c_mix(T x, auto y, V z) with template args <T=int, V=int, auto=std::string> -> wrapped (int, string, int).
%template(c_mix_isi)  c_mix<int, int, std::string>;
%template(d_mix_is)   d_mix<int, short>;
%template(e_mix_iss)  e_mix<int, std::string, std::string>;
