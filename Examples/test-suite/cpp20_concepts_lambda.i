%module cpp20_concepts_lambda

// Concepts and requires-clauses on C++20 templated lambdas.  Lambdas themselves are not wrapped (per the
// existing cpp20_lambda_template.i and the manual section "Lambda templates"), but the parser must
// accept the requires-clause syntax and the lambda must remain callable from a wrapped function.
//
// Per [expr.prim.lambda.general], a lambda may carry a template-parameter-list (since C++14 for generic
// lambdas with auto, since C++20 for explicit '<typename T>' parameters), an optional prefix
// requires-clause between the template head and the lambda-declarator, and an optional trailing
// requires-clause at the end of the lambda-declarator.  SWIG accepts the trailing form in several
// constraint shapes; the prefix form, the trailing-return-type combination and the auto parameter
// trailing form all currently fail to parse - those cases are documented at the bottom of the file.

%warnfilter(SWIGWARN_CPP11_LAMBDA);

%inline %{
#include <concepts>

template<typename T>
concept Numeric = std::integral<T> || std::floating_point<T>;

template<typename T>
concept Sized = (sizeof(T) <= 8);

// 1. Templated lambda with a trailing requires-clause - bare concept.
auto trailing = []<typename T>(T x) requires Numeric<T> { return x + x; };

// 2. Trailing requires-clause - compound '&&'.
auto compound = []<typename T>(T x) requires Numeric<T> && Sized<T> { return x + x; };

// 3. Trailing requires-clause - inline 'requires requires' with a simple-requirement.
auto inline_req = []<typename T>(T a, T b) requires requires(T t) { t + t; } { return a + b; };

// 4. Templated lambda with 'mutable' followed by a trailing requires-clause.  The C++20 grammar puts
// requires-clause after the decl-specifier-seq (mutable, constexpr, etc.) inside lambda-declarator.
auto with_mut = []<typename T>(T x) mutable requires Numeric<T> { return x + x; };

// Lambdas are not directly wrapped, so call each through an ordinary wrapped function.
int run_trailing(int x)        { return trailing(x); }
int run_compound(int x)        { return compound(x); }
int run_inline_req(int a, int b) { return inline_req(a, b); }
int run_with_mut(int x)        { return with_mut(x); }
%}

// Lambda-and-concept forms that SWIG does not currently parse (kept here as documentation):
//
//   // Prefix requires-clause on a templated lambda - syntax error in SWIG.
//   auto prefix = []<typename T> requires Numeric<T> (T x) { return x + x; };
//
//   // Trailing-return type combined with a trailing requires-clause - syntax error in SWIG.
//   auto with_ret = []<typename T>(T x) -> T requires Numeric<T> { return x + x; };
//
//   // Auto-parameter lambda with a trailing requires-clause - syntax error in SWIG.
//   auto auto_param = [](auto x) requires Numeric<decltype(x)> { return x + x; };
//
// The abbreviated function template syntax inside a lambda parameter list ('Numeric auto x') is
// unsupported across SWIG generally - see the C++20 chapter Limitations note about type-constraints
// used in place of typename.
