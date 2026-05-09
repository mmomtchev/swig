from cpp20_concepts_lambda import *

from swig_test_utils import swig_check

# Trailing requires-clause - bare concept.
swig_check(run_trailing(5), 10)

# Trailing requires-clause - compound '&&'.
swig_check(run_compound(7), 14)

# Trailing requires-clause - inline 'requires requires'.
swig_check(run_inline_req(2, 3), 5)

# 'mutable' followed by trailing requires-clause.
swig_check(run_with_mut(4), 8)
