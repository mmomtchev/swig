from cpp20_concepts_classes import *


def check_equal(a, b):
    if a != b:
        raise RuntimeError("{} is not equal to {}".format(a, b))


# Class template with a prefix requires-clause on the template head.
nb = NumericBoxInt(7)
check_equal(nb.get(), 7)
nb.set(9)
check_equal(nb.get(), 9)
check_equal(nb.cube(), 729)

ndb = NumericBoxDouble(2.0)
check_equal(ndb.get(), 2.0)
check_equal(ndb.cube(), 8.0)

# Class template whose ordinary methods carry their own trailing requires-clauses.
hi = HolderInt(5)
check_equal(hi.get(), 5)
check_equal(hi.doubled(), 10)
hi.set(-3)
check_equal(hi.doubled(), -6)

hd = HolderDouble(1.5)
check_equal(hd.doubled(), 3.0)

# Class template with a compound prefix requires-clause joined by '&&'.
sb = SmallBoxInt(42)
check_equal(sb.get(), 42)

# Class template with a constrained constructor.
cb = CheckedBoxInt(11)
check_equal(cb.get(), 11)
