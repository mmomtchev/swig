/* ------------------------------------------------------------
 *  Async Typemaps for Javascript
 * ------------------------------------------------------------ */

/*
 * Async mode wrappers use three additional typemaps that are
 * unique to Javascript async mode:
 *
 * - lock
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
 * is read-only or because it has its own locking - these
 * typemaps should be overriden
 */

%typemap(lock) SWIGTYPE *, SWIGTYPE &  {
  SWIG_NAPI_ObjectWrap_inst *ow = nullptr;
  if ($input.IsObject()) {
    Napi::Object obj;
    NAPI_CHECK_RESULT($input.ToObject(), obj);
    if (SWIG_NAPI_IsWrappedObject(env, obj)) {
      ow = Napi::ObjectWrap<SWIG_NAPI_ObjectWrap_inst>::Unwrap(obj);
      if (ow != nullptr && SWIG_locks.count(ow) == 0) {
          SWIG_locks.insert({reinterpret_cast<void*>(ow), {
            [ow](){ow->lock();}, [ow](){ow->unlock();}
          }});
      }
    }
  }
}

/*
 * Primitives types do not need locking
 * (this is mostly a performance optimization since only
 * lockable types are locked)
 */
%define EMPTY_ASYNC_TM(TM, ARG)
%typemap(TM)
  bool ARG,
  char ARG, signed char ARG, unsigned char ARG,
  short ARG, signed short ARG, unsigned short ARG,
  int ARG, signed int ARG, unsigned int ARG,
  long ARG, signed long ARG, unsigned long ARG,
  long long ARG, signed long long ARG, unsigned long long ARG,
  float ARG, double ARG,
  // strings do not need locking - they are immutable and cannot be accessed w/o V8
  std::string ""
%enddef

EMPTY_ASYNC_TM(lock, )

// These are needed becase INPUT/INOUT/OUTPUT can be used with %apply
// in which case they override the empty typemap
EMPTY_ASYNC_TM(lock, *INPUT)

EMPTY_ASYNC_TM(lock, &INPUT)

EMPTY_ASYNC_TM(lock, *INOUT)

EMPTY_ASYNC_TM(lock, &INOUT)

EMPTY_ASYNC_TM(lock, *OUTPUT)

EMPTY_ASYNC_TM(lock, &OUTPUT)