%module assign_const

%{
#if defined(_MSC_VER)
  #pragma warning(disable : 4351) // warning C4351: new behavior: elements of array 'AssignArray::ArrayMember' will be default initialized
#endif
%}

// Similar to assign_reference.i testcase but reference member variables replaced by const members

%rename(Assign) *::operator=;

// (1) Test directly non-assignable member variables
%inline %{
struct AssignValue {
  AssignValue() : ValueMember() {}
  const int ValueMember;
};

struct AssignArray {
  AssignArray() : ArrayMember() {}
  const int ArrayMember[1];
};

struct AssignPtr {
  AssignPtr() : PtrMember() {}
  int *const PtrMember;
};

struct AssignMatrix {
  AssignMatrix() : MatrixMember() {}
  const int MatrixMember[2][2];
};

struct MemberVars {
  // These will only have getters
  AssignValue MemberValue;
  AssignArray MemberArray;
  AssignPtr MemberPtr;
  AssignMatrix MemberMatrix;
};

// (2) Test indirectly non-assignable member variables via inheritance
struct AssignValueDerived : AssignValue {};
struct AssignArrayDerived : AssignArray {};
struct AssignPtrDerived : AssignPtr {};
struct AssignMatrixDerived : AssignMatrix {};
struct AssignValueDerivedSettable : AssignValue {
  AssignValueDerivedSettable& operator=(const AssignValueDerivedSettable &) { return *this; }
};
struct AssignArrayDerivedSettable : AssignArray {
  AssignArrayDerivedSettable& operator=(const AssignArrayDerivedSettable &) { return *this; }
};
struct AssignPtrDerivedSettable : AssignPtr {
  AssignPtrDerivedSettable& operator=(const AssignPtrDerivedSettable &) { return *this; }
};
struct AssignMatrixDerivedSettable : AssignMatrix {
  AssignMatrixDerivedSettable& operator=(const AssignMatrixDerivedSettable &) { return *this; }
};

struct InheritedMemberVars {
  // These will only have getters
  AssignValueDerived MemberValueDerived;
  AssignArrayDerived MemberArrayDerived;
  AssignPtrDerived MemberPtrDerived;
  AssignMatrixDerived MemberMatrixDerived;

  static AssignValueDerived StaticMemberValueDerived;
  static AssignArrayDerived StaticMemberArrayDerived;
  static AssignPtrDerived StaticMemberPtrDerived;
  static AssignMatrixDerived StaticMemberMatrixDerived;

  // These will have getters and setters
  AssignValueDerivedSettable MemberValueDerivedSettable;
  AssignArrayDerivedSettable MemberArrayDerivedSettable;
  AssignPtrDerivedSettable MemberPtrDerivedSettable;
  AssignMatrixDerivedSettable MemberMatrixDerivedSettable;

  static AssignValueDerivedSettable StaticMemberValueDerivedSettable;
  static AssignArrayDerivedSettable StaticMemberArrayDerivedSettable;
  static AssignPtrDerivedSettable StaticMemberPtrDerivedSettable;
  static AssignMatrixDerivedSettable StaticMemberMatrixDerivedSettable;
};
%}

// As these actually define variables, they must be explicitly included
// in the wrapper section for compatibility with JavaScript code splitting
// The linkage must be set explicitly because there is a number of interpreters
// that force C linkage for their wrappers (Python and Lua are two examples)
// (or -alternatively- you can use a bigger hammer and specify -Wl,-z muldefs)
%wrapper %{
SWIGCPPLINKAGE AssignValueDerived InheritedMemberVars::StaticMemberValueDerived;
SWIGCPPLINKAGE AssignArrayDerived InheritedMemberVars::StaticMemberArrayDerived;
SWIGCPPLINKAGE AssignPtrDerived InheritedMemberVars::StaticMemberPtrDerived;
SWIGCPPLINKAGE AssignMatrixDerived InheritedMemberVars::StaticMemberMatrixDerived;

SWIGCPPLINKAGE AssignValueDerivedSettable InheritedMemberVars::StaticMemberValueDerivedSettable;
SWIGCPPLINKAGE AssignArrayDerivedSettable InheritedMemberVars::StaticMemberArrayDerivedSettable;
SWIGCPPLINKAGE AssignPtrDerivedSettable InheritedMemberVars::StaticMemberPtrDerivedSettable;
SWIGCPPLINKAGE AssignMatrixDerivedSettable InheritedMemberVars::StaticMemberMatrixDerivedSettable;

// These will only have getters
SWIGCPPLINKAGE AssignValueDerived GlobalValueDerived;
SWIGCPPLINKAGE AssignArrayDerived GlobalArrayDerived;
SWIGCPPLINKAGE AssignPtrDerived GlobalPtrDerived;
SWIGCPPLINKAGE AssignMatrixDerived GlobalMatrixDerived;

// These will have getters and setters
SWIGCPPLINKAGE AssignValueDerivedSettable GlobalValueDerivedSettable;
SWIGCPPLINKAGE AssignArrayDerivedSettable GlobalArrayDerivedSettable;
SWIGCPPLINKAGE AssignPtrDerivedSettable GlobalPtrDerivedSettable;
SWIGCPPLINKAGE AssignMatrixDerivedSettable GlobalMatrixDerivedSettable;
%}

// (3) Test indirectly non-assignable member variables via classes that themselves have non-assignable member variables
%inline %{
struct MemberValueVar {
  AssignValue MemberValue;
};

struct MemberArrayVar {
  AssignArray MemberArray;
};

struct MemberPtrVar {
  AssignPtr MemberPtr;
};

struct MemberMatrixVar {
  AssignMatrix MemberMatrix;
};

struct MembersMemberVars {
  // These will only have getters
  MemberValueVar MemberValue;
  MemberArrayVar MemberArray;
  MemberPtrVar MemberPtr;
  MemberMatrixVar MemberMatrix;
};

struct StaticMembersMemberVars {
  static MemberValueVar StaticMemberValue;
  static MemberArrayVar StaticMemberArray;
  static MemberPtrVar StaticMemberPtr;
  static MemberMatrixVar StaticMemberMatrix;
};

// Setters and getters available
struct StaticMembersMemberVarsHolder {
    StaticMembersMemberVars Member;
};
%}

// Actual definitions
%wrapper %{
SWIGCPPLINKAGE MemberValueVar StaticMembersMemberVars::StaticMemberValue;
SWIGCPPLINKAGE MemberArrayVar StaticMembersMemberVars::StaticMemberArray;
SWIGCPPLINKAGE MemberPtrVar StaticMembersMemberVars::StaticMemberPtr;
SWIGCPPLINKAGE MemberMatrixVar StaticMembersMemberVars::StaticMemberMatrix;

SWIGCPPLINKAGE MemberValueVar GlobalMemberValue;
SWIGCPPLINKAGE MemberArrayVar GlobalMemberArray;
SWIGCPPLINKAGE MemberPtrVar GlobalMemberPtr;
SWIGCPPLINKAGE MemberMatrixVar GlobalMemberMatrix;

SWIGCPPLINKAGE StaticMembersMemberVars GlobalStaticMembersMemberVars;
%}
