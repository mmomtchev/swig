/* -----------------------------------------------------------------------------
 * std_shared_ptr.i
 *
 * SWIG library file for handling std::shared_ptr.
 *
 * It implements a JS proxy wrapper around shared pointers, that allows
 * to use them as they were plain objects of the base type:
 * - to call the methods of the base type object
 * - to use it in place of a plain object as a function input argument 
 * - to use a plain object where a shared pointer is expected
 *
 * ----------------------------------------------------------------------------- */

#define SWIG_SHARED_PTR_NAMESPACE std
%include <shared_ptr.i>

%define SWIG_SHARED_PTR_TYPEMAPS(CONST, TYPE)
// C++ expects a plain object or a reference, JS can have shared_ptr or a plain object
%typemap(in) CONST TYPE, CONST TYPE & (int res, std::shared_ptr<CONST TYPE> *ptr) {
  res = SWIG_ConvertPtr($input, reinterpret_cast<void**>(&ptr), $descriptor(std::shared_ptr<TYPE>), %convertptr_flags | SWIG_POINTER_NO_NULL);
  if (!SWIG_IsOK(res)) {
    res = SWIG_ConvertPtr($input, reinterpret_cast<void**>(&$1), $descriptor(TYPE *), %convertptr_flags);
    if (!SWIG_IsOK(res)) {
      %argument_fail(res, "TYPE", $symname, $argnum);
    }
  } else {
    $1 = *ptr->get();
  }
}

// C++ expects a pointer, JS can have shared_ptr or a plain object
%typemap(in) CONST TYPE * (int res, std::shared_ptr<CONST TYPE> *ptr) {
  res = SWIG_ConvertPtr($input, reinterpret_cast<void**>(&ptr), $descriptor(std::shared_ptr<TYPE>), %convertptr_flags | SWIG_POINTER_NO_NULL);
  if (!SWIG_IsOK(res)) {
    res = SWIG_ConvertPtr($input, reinterpret_cast<void**>(&$1), $descriptor(TYPE *), %convertptr_flags);
    if (!SWIG_IsOK(res)) {
      %argument_fail(res, "TYPE", $symname, $argnum);
    }
  } else {
    $1 = ptr->get();
  }
}

// C++ expects a shared pointer, JS can have shared_ptr or a plain object
%typemap(in, fragment="SWIG_null_deleter") std::shared_ptr<CONST TYPE> (int res, std::shared_ptr<TYPE> ptr) {
  res = SWIG_ConvertPtr($input, reinterpret_cast<void**>(&$1), $descriptor, %convertptr_flags | SWIG_POINTER_NO_NULL);
  if (!SWIG_IsOK(res)) {
    TYPE *plain_ptr;
    res = SWIG_ConvertPtr($input, reinterpret_cast<void**>(&plain_ptr), $descriptor(TYPE *), %convertptr_flags);
    if (!SWIG_IsOK(res)) {
      %argument_fail(res, "TYPE", $symname, $argnum);
    }
    $1 = std::shared_ptr<TYPE>(plain_ptr, SWIG_null_deleter());
  }
}
%enddef
