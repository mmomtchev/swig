// Check that TypeScript type restrictions
// work correctly for types that appear compatible
// with duck typing

%module typescript_type_restrictions

%inline %{
  class A {
    public:
      virtual const char* method() const {
        return "A";
      }
      virtual ~A() {}
  };

  class B {
    public:
      virtual const char* method() const {
        return "B";
      }
      virtual ~B() {}
  };

  class C: public A {
    public:
      virtual const char* method() const {
        return "C";
      }
      virtual ~C() {}
  };

  const char *takeA(const A &v) {
    return v.method();
  }
%}
