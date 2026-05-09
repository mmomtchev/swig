from cpp20_concepts_constrained_param import *

from swig_test_utils import swig_check


# 1. Single type constrained parameter.
swig_check(cube_int(3), 27)
swig_check(cube_double(2.5), 15.625)

# 2. ::-qualified concept-id.
swig_check(half_int(10), 5)

# 3. Mixed type-constraint + plain typename.
swig_check(scale_di(2.5, 4), 10.0)

# 4. Default template argument paired with a type-constraint.
swig_check(identity_int(7), 7)

# 5. Two type-constraints in one head.
swig_check(combine_id(40, 2), 42)

# 6. Variadic type constrained pack.
swig_check(count_numeric_1(1), 1)
swig_check(count_numeric_3(1, 2.0, 3), 3)

# 6a. Leading plain typename followed by a type constrained pack.
swig_check(tag_count_si("hello", 1), 1)
swig_check(tag_count_s3("hello", 1, 2.0, 3), 3)

# 6b. Two type-constraints with the trailing one a variadic pack.
swig_check(small_tag_count_ci('x', 1), 1)
swig_check(small_tag_count_c3('x', 1, 2.0, 3), 3)

# 7. Constrained class template.
b = BoxInt(11)
swig_check(b.get(), 11)
b.set(42)
swig_check(b.get(), 42)

bd = BoxDouble(3.5)
swig_check(bd.get(), 3.5)

# 8. Constrained class template using a refining concept.
fb = FloatBoxFloat(1.25)
swig_check(fb.get(), 1.25)

# 9. Concept not parsed by SWIG.
swig_check(tag_int(41), 42)
