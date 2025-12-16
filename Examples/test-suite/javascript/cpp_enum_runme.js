var cpp_enum = require("cpp_enum");

var f = new cpp_enum.Foo()

/* @ts-expect-error These enums are really distinct */
if(f.hola != cpp_enum.Hello){
  console.error(f.hola);
  throw "Error";
}

f.hola = cpp_enum.Foo.Hi
if(f.hola != cpp_enum.Foo.Hi){
  console.error(f.hola);
  throw "Error";
}

f.hola = cpp_enum.Hello

if(f.hola != cpp_enum.Hello){
  console.error(f.hola);
  throw "Error";
}

/* @ts-expect-error : setting an invalid property is OK in JS but not in TS */
cpp_enum.Foo.hi = cpp_enum.Hello;
/* @ts-expect-error */
if (cpp_enum.Foo.hi != cpp_enum.Hello) {
  /* @ts-expect-error */
  console.error(cpp_enum.Foo.hi);
  throw "Error";
}

/* await */(cpp_enum.accept_td_enum_ptr(cpp_enum.ON));
