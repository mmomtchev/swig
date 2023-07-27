%module napi_async_overloading

// This test is specific to Node-API
%feature("async", "Async");
%feature("sync", "Sync");
%feature("async", "1") Klass;
%feature("sync", "0") Klass;

%inline %{

int Global(int a) {
  return a + 2;
}

struct Klass {
  int Method(int a) {
    return a + 4;
  }
};

%}
