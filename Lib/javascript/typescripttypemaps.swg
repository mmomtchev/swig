#ifdef SWIGTYPESCRIPT

%insert("begin") %{
#define SWIGTYPESCRIPT
%}

/**
 * Typescript typemaps
 *
 * Shared for all JavaScript generators
 */

%typemap(ts) char*, std::string, std::string *, std::string & "string";
%typemap(ts) boolean "bool";

#define SIGNS(N) N, unsigned N, signed N
%typemap(ts) SIGNS(short), SIGNS(int), SIGNS(long), SIGNS(long long) "number";

%typemap(ts) float, double "number";

%typemap(ts) SWIGTYPE, SWIGTYPE *, SWIGTYPE & "$jstype";

%typemap(ts) void "void";

%typemap(ts) (int ARGC, char **ARGV) "string[]";

%typemap(ts) (char *STRING, size_t LENGTH) "string";

%typemap(ts) (Char *STRING, size_t LENGTH),
  (Char *STRING, int LENGTH), (Char *STRING, size_t SIZE), (Char *STRING, int SIZE), 
  (int LENGTH, Char *STRING), (int SIZE, Char *STRING)
  = (char *STRING, size_t LENGTH);

%typemap(ts) (const void *indata, size_t inlen) = (Char *STRING, size_t LENGTH);

#endif
