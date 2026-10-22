local v=require("cpp11_attribute_specifiers")

-- assert(not pcall(function() v.noReturn() end)) TODO crash instead of exception
assert(v._noDiscard())
assert(v._noDiscardDeprecated())
v.maybeUnused1(false)
-- v.maybeUnused1() TODO maybe_unused ignored
assert(v.maybeUnused2(true, false))
-- assert(not v.maybeUnused2(false)) TODO maybe_unused ignored
assert(v._likely(true, true))
assert(not v._likely(false, false))
-- assert(v.likely(true)) TODO maybe_unused ignored

assert(v.test_string_literal() == 'Test [[ and ]] in string literal', "test_string_literal")

local s = v.S()
assert(s ~= nil)

assert(v.aa == 0)
assert(swig_type(v.a) == "int *")
assert(v.b == 0)
assert(v.newval == 1)
