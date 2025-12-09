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

// ======================================================
// This typemap converts C++ std::function to JS function
// ======================================================

// The C++ case
%typemap(out, fragment="SWIG_NAPI_Function") std::function<std::string(int, const std::string &)> ReturnCPPFunction {  
  $result = SWIG_NAPI_Function<std::string, int, const std::string &>(
    env,
    // TODO: SwigValueWrapper gets in the way
    (std::function<std::string(int, const std::string &)>)($1),
    std::function<void(Napi::Env, const Napi::CallbackInfo &, int &, std::string &)>(
        [](Napi::Env env, const Napi::CallbackInfo &info, int &passcode, std::string &name) -> void {
        // TODO: this is ugly
        int val1;
        int ecode1 = 0;
        $typemap(in, int, input=info[0], 1=passcode, argnum=passcode);
        $typemap(in, std::string, input=info[1], 1=name, argnum=name);
      }
    ),
    [](Napi::Env env, std::string c_result) -> Napi::Value {
      Napi::Value js_result;
      $typemap(out, std::string, 1=c_result, result=js_result, argnum=C result)
      return js_result;
    }
  );
}

// This is the TypeScript type associated
%typemap(ts) std::function<std::string(int, std::string)> giver
  "(this: pass: number, name: string) => string";

// The C case
%inline %{
  typedef char * (*CFunctionType)(int, char *);
%}

%typemap(out, fragment="SWIG_NAPI_Function") CFunctionType ReturnCFunction {  
  $result = SWIG_NAPI_Function<char*, int, char*>(
    env,
    std::function<char *(int, char *)>($1),
    std::function<void(Napi::Env, const Napi::CallbackInfo &, int &, char* &)>(
        [](Napi::Env env, const Napi::CallbackInfo &info, int &passcode, char* &name) -> void {
        // TODO: this is ugly
        int val1;
        int ecode1 = 0;
        int res1;
        char *buf1 = 0;
        int alloc1 = 0;
        $typemap(in, int, input=info[0], 1=passcode, argnum=passcode);
        $typemap(in, char*, input=info[1], 1=name, argnum=name);
      }
    ),
    [](Napi::Env env, char* c_result) -> Napi::Value {
      Napi::Value js_result;
      $typemap(out, char*, 1=c_result, result=js_result, argnum=C result)
      free(c_result);
      return js_result;
    }
  );
}

// We are wrapping these C/C++ function which return functions
%inline %{
#include <functional>
#include <string>
#include <stdio.h>

std::function<std::string(int, const std::string &)> ReturnCPPFunction() {
  return [](int passcode, const std::string &name) {
    if (passcode != 420)
      throw std::runtime_error{"Invalid passcode"};
    return std::string{name + " passed the test"};
  };
}

char *CFunction(int passcode, char *name) {
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
