/* -----------------------------------------------------------------------------
 * std_vector.i
 * ----------------------------------------------------------------------------- */

%include <std_common.i>

%insert(header) %{
#include <vector>
#include <stdexcept>
%}

namespace std {
    
    template<class T> class vector {
      public:
        typedef size_t size_type;
        typedef ptrdiff_t difference_type;
        typedef T value_type;
        typedef value_type* pointer;
        typedef const value_type* const_pointer;
        typedef value_type& reference;
        typedef const value_type& const_reference;

        vector();
        vector(size_type n);
        vector(const vector& other);

        size_type size() const;
        size_type capacity() const;
        void reserve(size_type n);
        %rename(isEmpty) empty;
        bool empty() const;
        void clear();
        %rename(add) push_back;
        void push_back(const value_type& x);
        %extend {
            const_reference get(int i) throw (std::out_of_range) {
                int size = int(self->size());
                if (i>=0 && i<size)
                    return (*self)[i];
                else
                    throw std::out_of_range("vector index out of range");
            }
            void set(int i, const value_type& val) throw (std::out_of_range) {
                int size = int(self->size());
                if (i>=0 && i<size)
                    (*self)[i] = val;
                else
                    throw std::out_of_range("vector index out of range");
            }
        }
    };

    // bool specialization
    template<> class vector<bool> {
      public:
        typedef size_t size_type;
        typedef ptrdiff_t difference_type;
        typedef bool value_type;
        typedef value_type* pointer;
        typedef const value_type* const_pointer;
        typedef value_type& reference;
        typedef bool const_reference;

        vector();
        vector(size_type n);
        vector(const vector& other);

        size_type size() const;
        size_type capacity() const;
        void reserve(size_type n);
        %rename(isEmpty) empty;
        bool empty() const;
        void clear();
        %rename(add) push_back;
        void push_back(const value_type& x);
        %extend {
            bool get(int i) throw (std::out_of_range) {
                int size = int(self->size());
                if (i>=0 && i<size)
                    return (*self)[i];
                else
                    throw std::out_of_range("vector index out of range");
            }
            void set(int i, const value_type& val) throw (std::out_of_range) {
                int size = int(self->size());
                if (i>=0 && i<size)
                    (*self)[i] = val;
                else
                    throw std::out_of_range("vector index out of range");
            }
        }
    };
}

%define specialize_std_vector(T)
#warning "specialize_std_vector - specialization for type T no longer needed"
%enddef

/* -----------------------*/
/* const std::vector (in) */
/* -----------------------*/

// reference to const vector, C++ receives:
//  * for values -> copies (objects must be copyable)
//  * for references -> references
//  * for pointers -> pointers
// (all input arguments are protected from the GC for the duration of the operation
// and this includes the JS array that contains the references)
// Don't try this at home, it uses an undocumented feature of $typemap
%typemap(in)        std::vector const & {
  if ($input.IsArray()) {
    $1 = new $*ltype;
    Napi::Array array = $input.As<Napi::Array>();
    for (size_t i = 0; i < array.Length(); i++) {
      $Ttype c_val;
      Napi::Value js_val = array.Get(i);
      $typemap(in, $Ttype, input=js_val, 1=c_val);
      $1->emplace_back(c_val);
    }
  } else {
    SWIG_exception_fail(SWIG_TypeError, "in method '$symname', argument $argnum is not an array");
  }
}
%typemap(freearg)   std::vector const & {
  delete $1;
}
// reference the base typemap
%typemap(ts)        std::vector const &   "$typemap(ts, $Ttype)[]";
