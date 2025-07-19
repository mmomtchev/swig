/* This testcase checks whether SWIG correctly uses the new result_of class
   and its templating capabilities introduced in C++11. */
%module cpp11_result_of

// std::result_of is deprecated in C++17 and removed in C++20
// Replace std implementation with a simple implementation in order to continue testing with C++17 compilers and later
%begin %{
// Rename the std version in case someone includes <functional>
#if __cplusplus >= 201703L && __cplusplus < 202002L
#define result_of _result_of_deprecated
#endif
%}

%inline %{
typedef double(*fn_ptr)(double);
%}

%{
// node-addon-api includes functional, in this case redefine only on C++>=20
#if __cplusplus >= 201703L
#if __cplusplus < 202002L
#undef result_of
#endif
namespace std {
  // Forward declaration of result_of
  template<typename Func> struct result_of;
  // Add in the required partial specialization of result_of
  template<> struct result_of< fn_ptr(double) > {
    typedef double type;
  };
}
#else
#include <functional>
#endif
%}

namespace std {
  // Forward declaration of result_of
  template<typename Func> struct result_of;
  // Add in the required partial specialization of result_of
  template<> struct result_of< fn_ptr(double) > {
    typedef double type;
  };
}

%template() std::result_of< fn_ptr(double) >;

%inline %{

double square(double x) {
  return (x * x);
}

template<class Fun, class Arg>
typename std::result_of<Fun(Arg)>::type test_result_impl(Fun fun, Arg arg) {
  return fun(arg);
}

std::result_of< fn_ptr(double) >::type test_result_alternative1(double(*fun)(double), double arg) {
  return fun(arg);
}
%}

%inline %{
#include <iostream>

void cpp_testing() {
  std::cout << "result: " << test_result_impl(square, 3.0) << std::endl;
  std::cout << "result: " << test_result_impl<double(*)(double), double>(square, 4.0) << std::endl;
  std::cout << "result: " << test_result_impl< fn_ptr, double >(square, 5.0) << std::endl;
  std::cout << "result: " << test_result_alternative1(square, 6.0) << std::endl;
}
%}

%template(test_result) test_result_impl< fn_ptr, double>;
%constant double (*SQUARE)(double) = square;
