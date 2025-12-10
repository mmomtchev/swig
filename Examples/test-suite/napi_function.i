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

// The C case
%inline %{
  typedef std::function<std::string(int, const std::string &)> CPPFunctionType;
  typedef char * (*CFunctionType)(int, const char *);
%}

%types(CPPFunctionType);

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
