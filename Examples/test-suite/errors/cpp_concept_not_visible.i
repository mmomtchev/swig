%module xxx

// SWIG follows a "best effort wrap on partial type information" policy.  A
// type constrained template parameter ('template<Concept T>') referencing a
// concept SWIG hasn't seen is remapped to 'typename T'; warning 332
// (SWIGWARN_PARSE_TEMPLATE_TYPE_CONSTRAINT_UNDEF) fires only if the template
// is actually instantiated via %template.  The wrapper for an instantiation
// emits the templated call literally (e.g. 'cube< int >(arg1)') and leaves
// constraint resolution to the C++ compiler at wrapper compile time.

// Scenario 1: 'Numeric' is not declared anywhere SWIG has seen and 'cube' IS
// instantiated below, so warning 332 fires for the unresolved type-constraint.
%inline %{
template<Numeric T>
T cube(T x) { return x * x * x; }
%}
%template(cube_int) cube<int>;

// Scenario 2: same shape with an unresolved 'AnotherUnknown' type-constraint,
// but no %template instantiation - the warning is suppressed because the
// declaration is never actually used.  The cpp20_concepts_constrained_param
// test in the regular test suite covers the corresponding "instantiated but
// suppressed via #pragma SWIG nowarn" case.
%inline %{
template<AnotherUnknown T>
T noop(T x) { return x; }
%}
