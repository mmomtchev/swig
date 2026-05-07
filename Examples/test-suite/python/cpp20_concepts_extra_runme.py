from cpp20_concepts_extra import *


def check_equal(a, b):
    if a != b:
        raise RuntimeError("{} is not equal to {}".format(a, b))


# Negation via parens: '(!Numeric<T>)' on a non-numeric type.
t = Tag(7)
out = identity_non_numeric_tag(t)
check_equal(out.value(), 7)

# Multi parameter requires-expression with mixed types.
check_equal(mix_add_id(2, 3.5), 5)
check_equal(mix_add_id(-4, 1.0), -3)

# Variadic concept defined by a fold-expression over '&&'.
check_equal(sum_all_iii(1, 2, 3), 6)
check_equal(sum_all_iii(-5, 10, 2), 7)
check_equal(sum_all_ddd(1.5, 2.5, 1.0), 5.0)

# Type trait primary used as a constraint atom.
check_equal(trait_primary_int(7), 14)
check_equal(trait_primary_int(-3), -6)

# Deeper nesting of '&&' and '||' inside parens.
check_equal(deeper_int(42), 42)
check_equal(deeper_int(-7), -7)
