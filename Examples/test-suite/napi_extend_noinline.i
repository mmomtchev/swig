%module napi_extend_noinline

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
