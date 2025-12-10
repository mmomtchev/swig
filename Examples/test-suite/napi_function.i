%module napi_callback

// Test the SWIG Node-API function support

%include <std_string.i>

%include <exception.i>

// Rethrow all C++ exceptions as JS exceptions
%exception {
  try {
    $action
  } catch (const std::exception &e) {
    SWIG_Raise(e.what());
    SWIG_fail;
  }
}

// ===================================================================
// Create SWIG wrappers for calling std::function and function pointer
// ===================================================================

// For C we use a typedef
%inline %{
  typedef char * (*CFunctionType)(int, const char *);
%}

// For C++ we instantiate the std::function template:
//  * First things first, function is a JS keyword and must be renamed
%rename(__CPPFunctionType) function;
//  * However do not rename this particular type
%rename(CPPFunctionType) std::function<std::string(int, const std::string &)>;
//  * Provide a declaration for SWIG to chew on, it does not include <functional>
namespace std {
template <class R, class ...Args> class function {};
}
//  * Just for brevity
%inline %{
  using CPPFunctionType = std::function<std::string(int, const std::string &)>;
%}
//  * Instantiate the template with a JS name so that SWIG
//    knows about it, it will have to delete this object
%template(CPPFunctionType) std::function<std::string(int, const std::string &)>;

// Use SWIG to generate normal wrappers
%inline %{
  std::string CallCPPFunction(CPPFunctionType fn, int passcode, const std::string &name) {
    return fn(passcode, name);
  }
  const char *CallCFunction(CFunctionType fn, int passcode, const char *name) {
    return fn(passcode, name);
  }
%}


// We are wrapping these C/C++ function which return functions
%inline %{
#include <functional>
#include <string>
#include <stdio.h>

CPPFunctionType ReturnCPPFunction() {
  return [](int passcode, const std::string &name) {
    if (passcode != 420)
      throw std::runtime_error{"Invalid passcode"};
    return std::string{name + " passed the test"};
  };
}

char *CFunction(int passcode, const char *name) {
  static const char suffix[] = " passed the C test";
  if (passcode != 420)
    return NULL;
  int len = strlen(name) + strlen(suffix) + 1;
  char *r = (char *)malloc(len);
  snprintf(r, len, "%s%s", name, suffix);
  return r;
}

CFunctionType ReturnCFunction() {
  return &CFunction;
}
%}
