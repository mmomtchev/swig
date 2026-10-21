var typemap_string_alloc = require("typemap_string_alloc");

function check(actual, expected) {
  if (actual !== expected)
    throw new Error("Expected " + expected + ", got " + actual);
}

/* await */(typemap_string_alloc.Custom_Reset());
typemap_string_alloc.some_text = "one";
typemap_string_alloc.some_text = "two";

check(/* await */(typemap_string_alloc.Custom_WasAllocated()), true);
check(/* await */(typemap_string_alloc.Custom_WasDeallocated()), true);
