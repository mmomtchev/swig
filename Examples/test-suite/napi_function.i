%module napi_function

%header %{
#include <functional>
#include <string>
#include <stdexcept>
#include <stdio.h>
%}

%include <std_string.i>
%include <std_function.i>
%include <exception.i>

%exception {
    try {
        $action
    } catch (const std::exception& e) {
      SWIG_exception(SWIG_RuntimeError, e.what());
    }
}

%typemap(out) char* _SWIG_call_funcptr<char *, int, const char*> {
  $typemap(out, char *);
  free($1);
}

%napi_std_function(cpp_function, std::string, int, const std::string &);
%napi_funcptr(c_funcptr, char *, int, const char *);

%inline %{
typedef char *(*c_funcptr)(int, const char *);
extern "C++" std::function<std::string(int, const std::string &)> return_function(int ask_for_pass);
extern "C" c_funcptr return_function_ptr();
%}

%wrapper %{
extern "C++" std::function<std::string(int, const std::string &)> return_function(int ask_for_pass) {
  return [ask_for_pass](int passcode, const std::string &name) -> std::string {
    if (passcode == ask_for_pass) {
      return name + " passed the C++ test";
    }
    throw std::runtime_error{"Test failed"};
  };
}
extern "C" c_funcptr return_function_ptr() {
  return [](int passcode, const char *name) -> char* {
    if (passcode == 42) {
      static const char suffix[] = " passed the C test";
      size_t len = strlen(name) + strlen(suffix);
      char *r = (char *)malloc(len + 1);
      snprintf(r, len + 1, "%s%s", name, suffix);
      return r;
    }
    return NULL;
  };
}
%}

// This is an example in the JavaScript manual.
// Ensure that it works.
%typemap(out) char *CWrappedFuncPtr::call {
  $typemap(out, char *);
  free($1);
}

%typemap(out) char* (*return_function_ptr2) (int, const char*) {
  CWrappedFuncPtr r;
  r.fn = $1;
  $typemap(out, CWrappedFuncPtr, 1=r);
}

%typemap(in) CWrappedFuncPtr {
  $typemap(in, char* (*) (int, const char*), input=$input.fn);
}

%typemap(ts) char* (*return_function_ptr2) (int, const char*) "CWrappedFuncPtr";

%inline %{
struct CWrappedFuncPtr {
  c_funcptr fn;
};
extern "C" c_funcptr return_function_ptr2() {
  return return_function_ptr();
};
%}

%extend CWrappedFuncPtr {
  char *call(int pass, const char *name) {
    return (*$self->fn)(pass, name);
  }
}
