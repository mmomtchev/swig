%module enum_nspace

%nspace;

%inline %{

namespace outer {
  namespace inner {
    typedef enum _choice {
      NO = 0,
      YES
    } Choice;
  }
}

bool select1(enum outer::inner::_choice arg) {
  return arg == outer::inner::YES;
}

bool select2(outer::inner::Choice arg) {
  return arg == outer::inner::YES;
}

%}
