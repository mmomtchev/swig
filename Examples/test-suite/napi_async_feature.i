%module napi_async_overloading

// This test is specific to Node-API
%feature("async", "Async");
%feature("sync", "Sync");

%feature("async", "1") Klass;
%feature("sync", "0") Klass;

%feature("async", "1") Template;
%feature("sync", "0") Template;

%feature("async", "0") Template::MethodAlwaysSync;
%feature("sync", "1") Template::MethodAlwaysSync;

%inline %{

int Global(int a) {
  return a + 2;
}

struct Klass {
  int Method(int a) {
    return a + 4;
  }
};

template <typename T>
struct Template {
  T Method(T a) {
    return a + 6;
  }

  T MethodAlwaysSync(T a) {
    return a + 8;
  }
};

%}

%template(TemplateInt) Template<int>;
