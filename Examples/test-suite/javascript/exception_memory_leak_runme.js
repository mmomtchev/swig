var exception_memory_leak = require('exception_memory_leak');

var { Foo } = exception_memory_leak;

// This test works correctly only in Node-API
// @ts-ignore
if (typeof print === 'undefined' && typeof exception_memory_leak.Foo.prototype.equals === 'undefined') {

  var a = new Foo;
  if (Foo.get_count() != 1) throw new Error("Should have 1 Foo objects");
  var b = new Foo;
  if (Foo.get_count() != 2) throw new Error("Should have 2 Foo objects");

  // Normal behaviour
  exception_memory_leak.trigger_internal_swig_exception("no problem", a);
  if (Foo.get_count() != 2) throw new Error("Should have 2 Foo objects");
  if (Foo.get_freearg_count() != 1) throw new Error("freearg should have been used once");

  // SWIG exception triggered and handled (return new object case).
  var fail = false;
  try {
    exception_memory_leak.trigger_internal_swig_exception("null", b);
    fail = true;
  } catch { }
  if (fail) throw new Error("Expected an exception");

  if (Foo.get_count() != 2) throw new Error("Should have 2 Foo objects");
  if (Foo.get_freearg_count() != 2) throw new Error("freearg should have been used twice");

  // SWIG exception triggered and handled (return by value case).
  try {
    exception_memory_leak.trigger_internal_swig_exception("null");
    fail = true;
  } catch { }
  if (fail) throw new Error("Expected an exception");
}
