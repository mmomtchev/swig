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
%template(shared_ptr_##CONST##_##TYPE##) std::shared_ptr<CONST TYPE>;

// C++ expects a plain object, JS can have shared_ptr or a plain object
%typemap(in) CONST TYPE (int res, std::shared_ptr<CONST TYPE> *ptr) {
  res = SWIG_ConvertPtr($input, reinterpret_cast<void**>(&ptr), $descriptor(std::shared_ptr<TYPE> *), %convertptr_flags | SWIG_POINTER_NO_NULL);
  if (!SWIG_IsOK(res)) {
    $ltype *plain_ptr;
    res = SWIG_ConvertPtr($input, reinterpret_cast<void**>(&plain_ptr), $descriptor(TYPE *), %convertptr_flags);
    $1 = *plain_ptr;
    if (!SWIG_IsOK(res)) {
      %argument_fail(res, "TYPE", $symname, $argnum);
    }
  } else {
    $1 = *ptr->get();
  }
}

// C++ expects a pointer or a reference, JS can have shared_ptr or a plain object
%typemap(in)
    CONST TYPE * (int res, std::shared_ptr<CONST TYPE> *ptr),
    CONST TYPE & (int res, std::shared_ptr<CONST TYPE> *ptr) {
  res = SWIG_ConvertPtr($input, reinterpret_cast<void**>(&ptr), $descriptor(std::shared_ptr<TYPE> *), %convertptr_flags | SWIG_POINTER_NO_NULL);
  if (!SWIG_IsOK(res)) {
    res = SWIG_ConvertPtr($input, reinterpret_cast<void**>(&$1), $descriptor(TYPE *), %convertptr_flags);
    if (!SWIG_IsOK(res)) {
      %argument_fail(res, "TYPE", $symname, $argnum);
    }
  } else {
    $1 = %const_cast(ptr->get(), $ltype);
  }
}

// C++ expects a shared pointer, JS can have shared_ptr or a plain object
%typemap(in, fragment="SWIG_null_deleter") std::shared_ptr<CONST TYPE> (int res, std::shared_ptr<CONST TYPE> ptr) {
  std::shared_ptr<TYPE> *smart_ptr;
  res = SWIG_ConvertPtr($input, reinterpret_cast<void**>(&smart_ptr), $descriptor(std::shared_ptr<TYPE> *), %convertptr_flags | SWIG_POINTER_NO_NULL);
  if (!SWIG_IsOK(res)) {
    TYPE *plain_ptr;
    res = SWIG_ConvertPtr($input, reinterpret_cast<void**>(&plain_ptr), $descriptor(TYPE *), %convertptr_flags);
    if (!SWIG_IsOK(res)) {
      %argument_fail(res, "TYPE", $symname, $argnum);
    }
    $1 = std::shared_ptr<CONST TYPE>(plain_ptr, SWIG_null_deleter());
  } else {
    $1 = *smart_ptr;
  }
}

// C++ expects a plain pointer or a reference to a shared pointer, JS can have shared_ptr or a plain object
%typemap(in, fragment="SWIG_null_deleter")
    std::shared_ptr<CONST TYPE> * (int res, std::shared_ptr<CONST TYPE> ptr, bool must_free),
    std::shared_ptr<CONST TYPE> & (int res, std::shared_ptr<CONST TYPE> ptr, bool must_free) {
  res = SWIG_ConvertPtr($input, reinterpret_cast<void**>(&$1), $descriptor, %convertptr_flags | SWIG_POINTER_NO_NULL);
  must_free = false;
  if (!SWIG_IsOK(res)) {
    TYPE *plain_ptr;
    res = SWIG_ConvertPtr($input, reinterpret_cast<void**>(&plain_ptr), $descriptor(TYPE *), %convertptr_flags);
    if (!SWIG_IsOK(res)) {
      %argument_fail(res, "TYPE", $symname, $argnum);
    }
    $1 = new std::shared_ptr<CONST TYPE>(plain_ptr, SWIG_null_deleter());
    must_free = true;
  }
}
%typemap(freearg) std::shared_ptr<CONST TYPE> *, std::shared_ptr<CONST TYPE> & {
  if (must_free$argnum) delete $1;
}

#ifdef SWIGTYPESCRIPT
%typemap(ts) CONST TYPE, CONST TYPE *, CONST TYPE &
    "$jstype | shared_ptr_" #CONST "_" #TYPE

%typemap(ts) std::shared_ptr<CONST TYPE>, std::shared_ptr<CONST TYPE> *
    "$typemap(ts, TYPE)"
#endif

%enddef
