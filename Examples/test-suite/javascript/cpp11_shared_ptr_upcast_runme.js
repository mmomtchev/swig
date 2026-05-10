var cpp11_shared_ptr_upcast = require('cpp11_shared_ptr_upcast');

var { Derived, Derived2 } = cpp11_shared_ptr_upcast;

// This is a port from the Ruby equivalent test and some tests ported from
// Examples/test-suite/ruby/cpp11_shared_ptr_upcast_runme.rb are not working and commented out with:
// not working:

/* async */ function swig_assert_equal_simple(expected, got) {
  if (expected != /* await */(got))
    throw new Error(`Expected: ${expected}. Got: ${got}`);
}

// This test compiles in JSC and SWIG V8 but does not work
// since there is no smart pointer support
if (!(cpp11_shared_ptr_upcast.SWIG_NODE_API in [0, 1]))
  throw new Error('SWIG Node-API marker not defined');
if (cpp11_shared_ptr_upcast.SWIG_NODE_API === 1) {

// non-overloaded
swig_assert_equal_simple(7, cpp11_shared_ptr_upcast.derived_num1(new Derived(7)));
swig_assert_equal_simple(7, cpp11_shared_ptr_upcast.derived_num2([new Derived(7)]));
swig_assert_equal_simple(7, cpp11_shared_ptr_upcast.derived_num3({ 0: new Derived(7) }));

swig_assert_equal_simple(-1, cpp11_shared_ptr_upcast.base_num1(new Derived(7)));
swig_assert_equal_simple(-1, cpp11_shared_ptr_upcast.base_num2([new Derived(7)]));
swig_assert_equal_simple(-1, cpp11_shared_ptr_upcast.base_num3({ 0: new Derived(7) }));

swig_assert_equal_simple(999, cpp11_shared_ptr_upcast.derived_num1(null));
swig_assert_equal_simple(999, cpp11_shared_ptr_upcast.derived_num2([null]));
swig_assert_equal_simple(999, cpp11_shared_ptr_upcast.derived_num3({ 0: null }));

swig_assert_equal_simple(999, cpp11_shared_ptr_upcast.base_num1(null));
swig_assert_equal_simple(999, cpp11_shared_ptr_upcast.base_num2([null]));
swig_assert_equal_simple(999, cpp11_shared_ptr_upcast.base_num3({ 0: null }));

// overloaded
swig_assert_equal_simple(7, cpp11_shared_ptr_upcast.derived_num(new Derived(7)));
swig_assert_equal_simple(7, cpp11_shared_ptr_upcast.derived_num([new Derived(7)]));
swig_assert_equal_simple(7, cpp11_shared_ptr_upcast.derived_num({ 0: new Derived(7) }));

swig_assert_equal_simple(-1, cpp11_shared_ptr_upcast.base_num(new Derived(7)));
swig_assert_equal_simple(-1, cpp11_shared_ptr_upcast.base_num([new Derived(7)]));
swig_assert_equal_simple(-1, cpp11_shared_ptr_upcast.base_num({ 0: new Derived(7) }));

// ptr to shared_ptr
swig_assert_equal_simple(7, cpp11_shared_ptr_upcast.derived2_num1(new Derived2(7)));
swig_assert_equal_simple(7, cpp11_shared_ptr_upcast.derived2_num2([new Derived2(7)]));
swig_assert_equal_simple(7, cpp11_shared_ptr_upcast.derived2_num3({ 0: new Derived2(7) }));

swig_assert_equal_simple(-1, cpp11_shared_ptr_upcast.base2_num1(new Derived2(7)));

swig_assert_equal_simple(888, cpp11_shared_ptr_upcast.derived2_num1(null));
swig_assert_equal_simple(888, cpp11_shared_ptr_upcast.derived2_num2([null]));
swig_assert_equal_simple(888, cpp11_shared_ptr_upcast.derived2_num3({ 0: null }));

swig_assert_equal_simple(888, cpp11_shared_ptr_upcast.base2_num1(null));
swig_assert_equal_simple(888, cpp11_shared_ptr_upcast.base2_num2([null]));
swig_assert_equal_simple(888, cpp11_shared_ptr_upcast.base2_num3({ 0: null }));

}
else console.log('test skipped');
