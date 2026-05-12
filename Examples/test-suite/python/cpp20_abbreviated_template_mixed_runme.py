from cpp20_abbreviated_template_mixed import *

from swig_test_utils import swig_check

# Each non-decorated case pairs std::string with a numeric type, so Python's type system catches an
# argument order swap (it isn't enough to compare ints to doubles - those would silently convert).

# a. Explicit typename + auto.  T=std::string, auto=int.
swig_check(a_mix_si("hello", 5), "hello:5")

# b. Auto + explicit typename.  Template <U=std::string, auto=int> -> wrapped (int x, std::string y).
# The function body returns to_text(x) + ":" + to_text(y), so passing (3, "hi") -> "3:hi".
swig_check(b_mix_is(3, "hi"), "3:hi")

# c. Two explicit parms surrounding an auto.  Template <T=int, V=int, auto=std::string> ->
# wrapped (int, string, int) per the function parm order.
swig_check(c_mix_isi(1, "x", 2), "1/x/2")

# d. Constrained explicit + constrained auto.  T=int, auto=short.
#    Return = x*1000 + y*10 + sizeof(T) - sizeof(auto) = 3*1000 + 4*10 + (4 - 2) = 3042
#    Swapping bindings would change the (sizeof(T) - sizeof(auto)) term, so a wrong binding fails.
swig_check(d_mix_is(3, 4), 3042)

# e. Two autos surrounding an explicit typename.  auto=string, T=int, auto=string.
swig_check(e_mix_iss("a", 7, "b"), "a/7/b")
