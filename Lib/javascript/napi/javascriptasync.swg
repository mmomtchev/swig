/* ------------------------------------------------------------
 *  Async Typemaps for Javascript
 * ------------------------------------------------------------ */

/*
 * Async mode wrappers use three additional typemaps that are
 * unique to Javascript async mode:
 *
 * - async_in
 *   It is applied on the main thread after the check typemap
 *   It is allowed access to V8
 *   Its main use is to create persistent references to prevent GC
 *   With multiple arguments, this typemap is applied in the usual order
 *
 * - async_pre
 *   It is applied in the worker thread immediately before the action
 *   It is not allowed to access V8 and must support concurrent execution
 *   Its main use is to lock objects that need to be locked
 *   With mutliple arguments, this typemap is always applied by order of
 *   of the pointer value - to avoid deadlocks
 *
 * - async_post
 *   It is applied in the worker thread immediately after the action
 *   It is not allowed to access V8 and must support concurrent execution
 *   Its main use is to unlock the locked objects
 *   With mutliple arguments, this typemap is always applied by order of
 *   of the pointer value - to avoid deadlocks
 */

/* 
 * With NAPI, all pointers and references have a
 * SWIG_NAPI_ObjectWrap_inst wrapper
 * By default, all of them are locked during async operations
 * If an object type supports concurrent access - because it
 * is read-only or because it has its own locking - you should
 * replace these typemaps with empty ones
 */

%typemap(async_in)
    SWIGTYPE * (SWIG_NAPI_ObjectWrap_inst *ow),
    SWIGTYPE & (SWIG_NAPI_ObjectWrap_inst *ow) {
  ow = nullptr;
  if ($input.IsObject()) {
    Napi::Object obj;
    NAPI_CHECK_RESULT($input.ToObject(), obj);
    if (SWIG_NAPI_IsWrappedObject(env, obj)) {
      ow = Napi::ObjectWrap<SWIG_NAPI_ObjectWrap_inst>::Unwrap(obj);
    }

    Napi::ObjectReference *ref = new Napi::ObjectReference();
    *ref = Napi::Persistent(obj);
    persistent.push_back(ref);
  }
}

%typemap(async_pre) SWIGTYPE *, SWIGTYPE & {
  if (ow$argnum != nullptr && !objs.count(ow$argnum)) {
    objs.insert(ow$argnum);
    ow$argnum->lock();    
  }
}

%typemap(async_post) SWIGTYPE *, SWIGTYPE & {
  if (ow$argnum != nullptr && objs.count(ow$argnum)) {
    objs.erase(ow$argnum);
    ow$argnum->unlock();    
  }
}

/*
 * Primitives types do not need locking or peristence
 */
%typemap(async_in) bool,
  char, signed char, unsigned char,
  short, signed short, unsigned short,
  int, signed int, unsigned int,
  long, signed long, unsigned long,
  long long, signed long long, unsigned long long,
  float, double ""

%typemap(async_pre) bool,
  char, signed char, unsigned char,
  short, signed short, unsigned short,
  int, signed int, unsigned int,
  long, signed long, unsigned long,
  long long, signed long long, unsigned long long,
  float, double ""

%typemap(async_post) bool,
  char, signed char, unsigned char,
  short, signed short, unsigned short,
  int, signed int, unsigned int,
  long, signed long, unsigned long,
  long long, signed long long, unsigned long long,
  float, double ""

%typemap(async_in) bool *INPUT,
  char *INPUT, signed char *INPUT, unsigned char *INPUT,
  short *INPUT, signed short *INPUT, unsigned short *INPUT,
  int *INPUT, signed int *INPUT, unsigned int *INPUT,
  long *INPUT, signed long *INPUT, unsigned long *INPUT,
  long long *INPUT, signed long long *INPUT, unsigned long long *INPUT,
  float *INPUT, double *INPUT ""

%typemap(async_pre) bool *INPUT,
  char *INPUT, signed char *INPUT, unsigned char *INPUT,
  short *INPUT, signed short *INPUT, unsigned short *INPUT,
  int *INPUT, signed int *INPUT, unsigned int *INPUT,
  long *INPUT, signed long *INPUT, unsigned long *INPUT,
  long long *INPUT, signed long long *INPUT, unsigned long long *INPUT,
  float *INPUT, double *INPUT ""

%typemap(async_post) bool *INPUT,
  char *INPUT, signed char *INPUT, unsigned char *INPUT,
  short *INPUT, signed short *INPUT, unsigned short *INPUT,
  int *INPUT, signed int *INPUT, unsigned int *INPUT,
  long *INPUT, signed long *INPUT, unsigned long *INPUT,
  long long *INPUT, signed long long *INPUT, unsigned long long *INPUT,
  float *INPUT, double *INPUT ""

// std::string does not need locking but needs persistence
%typemap(async_in) std::string, std::string *, std::string & {
  Napi::Object obj;
  NAPI_CHECK_RESULT($input.ToObject(), obj);
  Napi::ObjectReference *ref = new Napi::ObjectReference();
  *ref = Napi::Persistent(obj);
  persistent.push_back(ref);
}

%typemap(async_pre) std::string, std::string *, std::string & ""
%typemap(async_post) std::string, std::string *, std::string & ""