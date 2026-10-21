%module cpp11_attribute_specifiers

%warnfilter(SWIGWARN_TYPEMAP_SWIGTYPELEAK) a;

//%rename("$ignore", %$isgnuhidden) "";
%rename("$ignore", match$attribute$gnu$visibility="\"hidden\"") "";
//%rename("$ignore", match$storage="static") "";
//%rename("$ignore", regexmatch$name="hidden") "";

%inline %{

struct [[nodiscard, gnu::aligned(16)]] S {
  [[gnu::visibility("hidden")]] static int hiddenWithString(const int &n = int()) { return 4; }
};


%}
