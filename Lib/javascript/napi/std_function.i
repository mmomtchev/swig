%include <std/std_function.i>

/**
 * Native-feel support for std::function in SWIG Node-API
 *
 * Example for
 *   std::function<std::string(int, const std::string &)>
 *
 *   %napi_std_function(cpp_function, std::string, int, const std::string &);
 *
 * The first argument is the name of the JS type.
 *
 *   %feature("sync", "0")  _SWIG_call_std_function<std::string, int, const std::string &>;
 *   %feature("async", "1") _SWIG_call_std_function<std::string, int, const std::string &>;
 */

%rename(_cpp_std_function, regextarget=1, fullname=1) "^std::function";

// The logic:
//    * SWIG creates a JS-call convention wrapper function called _wrap__##NAME##_call
//    * Whenever C++ returns an std::function, this result is replaced by the out typemap
//      with a JS function that calls the wrapper setting the CallBackInfo::Data
//    * When SWIG created the wrapper, it applied the in typemap which gets the function
//      from CallBackInfo::Data without consuming an input argument
//    * When the JS function is GCed, Node API will destroy the Callable which holds in its
//      lambda capture the copy of std::function that was used

%define %napi_std_function(NAME, RET, ...)

%typemap(out) std::function<RET(__VA_ARGS__)> {
  // The std::function is stored as a copy in the Callable lambda
  std::function<RET(__VA_ARGS__)> fn = $1;
  $result = Napi::Function::New(env, [fn](const Napi::CallbackInfo &info) -> Napi::Value {
    // We are slightly bending the const rules here, but we know that this works
    const_cast<Napi::CallbackInfo &>(info).SetData(reinterpret_cast<void *>(const_cast<std::function<RET(__VA_ARGS__)> *>(&fn)));
    return _wrap__##NAME##_call(info);
  }, "call_cpp_function_"#NAME);
}

%typemap(in, numinputs=0) std::function<RET(__VA_ARGS__)> _swig_std_fn {
  if (!info.Data())
    SWIG_NAPI_Raise(env, "Do not call this function directly");
  $1 = *reinterpret_cast<std::function<RET(__VA_ARGS__)> *>(info.Data());
}

%rename(NAME) std::function<RET(__VA_ARGS__)>;
%template(NAME) std::function<RET(__VA_ARGS__)>;
%template(_##NAME##_call) _SWIG_call_std_function<RET, __VA_ARGS__>;
%enddef


/**
 * Native-feel support for function pointers in SWIG Node-API
 *
 * Example for
 *   char * (*) (int, const char *)
 *
 *   %napi_funcptr(c_funcptr, char *, int, const char *);
 *
 * The first argument is the name of the JS type.
 *
 * For an async transform, add:
 *
 *   %feature("sync", "0")  _SWIG_call_funcptr<char *, int, const char *>;
 *   %feature("async", "1") _SWIG_call_funcptr<char *, int, const char *>;
 */


// Same as the above except the C function pointers cannot disappear,
// these are static const pointers to code in the text section of the binary
%inline %{
template <typename RET, typename... ARGS>
RET _SWIG_call_funcptr(RET (*_swig_funcptr)(ARGS...), ARGS ...args) {
  return _swig_funcptr(args...);
}
%}

%define %napi_funcptr(NAME, RET, ...)

typedef RET (*NAME)(__VA_ARGS__);

%typemap(out) RET (*)(__VA_ARGS__) {
  $result = Napi::Function::New(env,  _wrap__##NAME##_call, "call_c_function_ptr_"#NAME, (void *)$1);
}

%typemap(in, numinputs=0) RET (*_swig_funcptr)(__VA_ARGS__) {
  $1 = *reinterpret_cast<RET (*) (__VA_ARGS__)>(info.Data());
}

%rename(NAME) NAME;
%template(_##NAME##_call) _SWIG_call_funcptr<RET, __VA_ARGS__>;

%enddef
