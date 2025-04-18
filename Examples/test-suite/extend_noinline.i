%module extend_noinline
// Test %extend with code splitting
// This test should work w/o multiple definitions in the linker

%extend Object {
  int get() {
    return $self->v;
  }
}

%insert("header") {
  struct Object {
    int v;
    Object(int x);
  };
}

%insert("wrapper") {
  Object::Object(int x) : v(x) {}
}

struct Object {
  int v;
  Object(int x);
};
