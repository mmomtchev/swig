var cpp_namespace = require("cpp_namespace");

var n = /* await */(cpp_namespace.fact(4));
if (n != 24){
    throw ("Bad return value error!");
}
if (cpp_namespace.Foo != 42){
    throw ("Bad variable value error!");
}

var t = new cpp_namespace.Test();
if (/* await */(t.method()) != "Test::method"){
    throw ("Bad method return value error!");
}
if (/* await */(cpp_namespace.do_method(t)) != "Test::method"){
    throw ("Bad return value error!");
}

if (/* await */(cpp_namespace.do_method2(t)) != "Test::method"){
    throw ("Bad return value error!");
}
/* await */(cpp_namespace.weird("hello", 4));

var t2 = new cpp_namespace.Test2();
var t3 = new cpp_namespace.Test3();
var t4 = new cpp_namespace.Test4();
var t5 = new cpp_namespace.Test5();
if (/* await */(cpp_namespace.foo3(42)) != 42){
    throw ("Bad return value error!");
}

if (/* await */(cpp_namespace.do_method3(t2,40)) != "Test2::method"){
    throw ("Bad return value error!");
}

if (/* await */(cpp_namespace.do_method3(t3,40)) != "Test3::method"){
    throw ("Bad return value error!");
}

if (/* await */(cpp_namespace.do_method3(t4,40)) != "Test4::method"){
    throw ("Bad return value error!");
}

if (/* await */(cpp_namespace.do_method3(t5,40)) != "Test5::method"){
    throw ("Bad return value error!");
}
