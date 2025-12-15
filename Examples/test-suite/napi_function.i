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
