/* -----------------------------------------------------------------------------
 * std_shared_ptr.i
 *
 * SWIG library file for handling std::shared_ptr.
 *
 * It implements a JS proxy wrapper around shared pointers, that allows
 * to use them as they were plain objects of the base type:
 * - to call the methods of the base type object (not yet implemented)
 * - to use it in place of a plain object as a function input argument 
 * - to use a plain object where a shared pointer is expected
 *
 * ----------------------------------------------------------------------------- */

#define SWIG_SHARED_PTR_NAMESPACE std
%include <shared_ptr.i>

%define SWIG_SHARED_PTR_TYPEMAPS(CONST, TYPE)

%typemap(in, fragment="SWIG_null_deleter") std::shared_ptr<CONST TYPE> {
  TYPE *plain_ptr;
  int res = SWIG_ConvertPtr($input, reinterpret_cast<void**>(&plain_ptr), $descriptor(TYPE *), %convertptr_flags);
  if (!SWIG_IsOK(res)) {
    %argument_fail(res, "TYPE", $symname, $argnum);
  }
  $1 = std::shared_ptr<CONST TYPE>(plain_ptr, SWIG_null_deleter());
}

%typemap(in, fragment="SWIG_null_deleter") std::shared_ptr<CONST TYPE> *, std::shared_ptr<CONST TYPE> & {
  TYPE *plain_ptr;
  int res = SWIG_ConvertPtr($input, reinterpret_cast<void**>(&plain_ptr), $descriptor(TYPE *), %convertptr_flags);
  if (!SWIG_IsOK(res)) {
    %argument_fail(res, "TYPE", $symname, $argnum);
  }
  $1 = new std::shared_ptr<CONST TYPE>(plain_ptr, SWIG_null_deleter());
}
%typemap(freearg) std::shared_ptr<CONST TYPE> *, std::shared_ptr<CONST TYPE> & {
  delete $1;
}

// When importing a shared_ptr in JS, the underlying value is wrapped as if it was
// a plain pointer and the owning shared_ptr is saved in a finalizer lambda that
// will be called and freed when the JS proxy object is destroyed
// (the *& trick is needed because $1 is a SwigValueWrapper)
%typemap(out) std::shared_ptr<CONST TYPE> {
  %set_output(SWIG_NewPointerObj(const_cast<TYPE *>($1.get()), $descriptor(TYPE *), SWIG_POINTER_OWN | %newpointer_flags));
  auto *owner = new std::shared_ptr<CONST TYPE>(*&$1);
  auto finalizer = new SWIG_NAPI_Finalizer([owner](){
    delete owner;
  });
  SWIG_NAPI_SetFinalizer(env, $result, finalizer);
}

%typemap (out) std::shared_ptr<CONST TYPE> &, std::shared_ptr<CONST TYPE> * {
  %set_output(SWIG_NewPointerObj(const_cast<TYPE *>($1->get()), $descriptor(TYPE *), $owner | %newpointer_flags));
  auto finalizer = new SWIG_NAPI_Finalizer([$1](){
    delete $1;
  });
  SWIG_NAPI_SetFinalizer(env, $result, finalizer);
}

#ifdef SWIGTYPESCRIPT
%typemap(ts) std::shared_ptr<CONST TYPE>, std::shared_ptr<CONST TYPE> *, std::shared_ptr<CONST TYPE> &
    "$typemap(ts, TYPE)"
#endif

%enddef
