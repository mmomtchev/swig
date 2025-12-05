%module template_opaque
%include "std_vector.i"

%{
  namespace A 
  {
    struct OpaqueStruct 
    {
      int x;
    };
  }

  enum Hello { hi, hello };
      
%}


%inline {
namespace A {
  struct OpaqueStruct;
  typedef struct OpaqueStruct OpaqueType;
  typedef enum Hello Hi;
  typedef std::vector<OpaqueType> OpaqueVectorType;
  typedef std::vector<Hi> OpaqueVectorEnum;
  
  void FillVector(OpaqueVectorType& v) 
  {
    for (size_t i = 0; i < v.size(); ++i) {
      v[i] = OpaqueStruct();
    }
  }

  void FillVector(const OpaqueVectorEnum& v) 
  {
  }
}
}

// Alas, this is indeed a double declaration for an already
// existing type that SWIG cannot identify in its current state
// (it results two distinct r_mangled entries)
#ifndef SWIGTYPESCRIPT
%template(OpaqueVectorType) std::vector<A::OpaqueType>;
#else
%template(OpaqueVectorType) std::vector<A::OpaqueStruct>;
#endif
