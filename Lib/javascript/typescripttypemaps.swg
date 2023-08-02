/**
 * Typescript typemaps
 *
 * Shared for all JavaScript generators
 */

%typemap(ts) char* "string";
%typemap(ts) boolean "bool";

#define SIGNS(N) N, unsigned N, signed N
%typemap(ts) SIGNS(short), SIGNS(int), SIGNS(long), SIGNS(long long) "number";

%typemap(ts) float, double "number";

%typemap(ts) SWIGTYPE, SWIGTYPE *, SWIGTYPE & "$jstype";

%typemap(ts) void "void";
