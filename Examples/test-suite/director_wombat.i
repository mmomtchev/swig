%module(directors="1") director_wombat
#pragma SWIG nowarn=SWIGWARN_TYPEMAP_THREAD_UNSAFE,SWIGWARN_TYPEMAP_DIRECTOROUT_PTR

%feature(director) Bar;
%feature(director) Foo<int>;

%inline %{
template<typename T> class Foo
{
public:
                        Foo()
                        { /* NOP */ }
  virtual              ~Foo()
                        { /* NOP */ }
  virtual int           meth(T param)
                        { return param; }
};

typedef Foo<int>        Foo_int;

class Bar
{
public:
  virtual              ~Bar();
  virtual Foo_int      *meth();
  virtual void          foo_meth_ref(Foo_int &, int);
  virtual void          foo_meth_ptr(Foo_int *, int);
  virtual void          foo_meth_val(Foo_int, int);
  virtual void          foo_meth_cref(const Foo_int &, int);
  virtual void          foo_meth_cptr(const Foo_int *, int);
};

Bar::~Bar()
{ /* NOP */ }

Foo_int *
Bar::meth()
{
  return new Foo_int();
}

void Bar::foo_meth_ref(Foo_int &arg, int param) { }
void Bar::foo_meth_ptr(Foo_int *arg, int param) { }
void Bar::foo_meth_val(Foo_int arg, int param) { }
void Bar::foo_meth_cref(const Foo_int &arg, int param) { }
void Bar::foo_meth_cptr(const Foo_int *arg, int param) { }
%}

// This is impossible to satisfy with TypeScript - all the wrappers were
// generated using Foo_int as name and at the end, the name is changed
// to Foo_integers - TypeScript emits a warning in this case
#ifndef SWIGTYPESCRIPT
%template(Foo_integers) Foo<int>;
#else
%template(Foo_int) Foo<int>;
#endif
