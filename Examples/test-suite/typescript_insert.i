%module typescript_insert

#ifdef SWIGTYPESCRIPT
%typemap(ts) int "Custom";

%insert("typescript") {
export type Custom = number;
}
#endif

%inline %{
int add(int a, int b) {
  return a + b;
}
%}
