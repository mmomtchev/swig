%module typescript_insert

%typemap(ts) int "Custom";

%insert("typescript") {
export type Custom = number;
}

%inline %{
int add(int a, int b) {
  return a + b;
}
%}
