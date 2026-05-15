var cpp11_template_pack_specialization = require('cpp11_template_pack_specialization');

/* async */ function check(actual, expected, label) {
  if (/* await */(actual) !== expected)
    throw new Error(label + ' expected ' + expected + ' got ' + actual);
}

var spi = new cpp11_template_pack_specialization.SomeParmsInt;
/* await */(spi.primary_method());

var spp = new cpp11_template_pack_specialization.SomeParmsNoParms;
/* await */(spp.partial_method());

var sps = new cpp11_template_pack_specialization.SomeParmsString;
/* await */(sps.partial_method('hello'));

var spid = new cpp11_template_pack_specialization.SomeParmsIntDouble;
/* await */(spid.partial_method(10, 11.1));

var sp2i = new cpp11_template_pack_specialization.SomeParms2PackInt;
/* await */(sp2i.partial2_methodC(20));

var sp2id = new cpp11_template_pack_specialization.SomeParms2PackIntDouble;
/* await */(sp2id.partial2_methodA(11.1));
/* await */(sp2id.partial2_methodB(55, 11.1));
/* await */(sp2id.partial2_methodC(55));

var sp2idf = new cpp11_template_pack_specialization.SomeParms2PackIntDoubleFloat;
/* await */(sp2idf.partial2_methodA(11.1, 22.2));
/* await */(sp2idf.partial2_methodB(55, 11.1, 22.2));
/* await */(sp2idf.partial2_methodC(55));

var f_int = new cpp11_template_pack_specialization.StdFunctionIntInt;
/* await */(check(f_int.call(10, 20), 30, "f_int.call(10, 20)"));
/* await */(check(f_int.call_operator(20, 30), 50, "f_int.call_operator(20, 30)"));

var f_int0 = new cpp11_template_pack_specialization.StdFunctionVoid;
/* await */(check(f_int0.call(), 0, "f_int0.call()"));
/* await */(check(f_int0.call_operator(), 0, "f_int0.call_operator()"));

var f_int1 = new cpp11_template_pack_specialization.StdFunctionInt;
/* await */(check(f_int1.call(7), 7, "f_int1.call(7)"));
/* await */(check(f_int1.call_operator(7), 7, "f_int1.call_operator(7)"));

var f_double = new cpp11_template_pack_specialization.StdFunctionDoubleDouble;
/* await */(check(f_double.call(1.5, 2.25), 3.75, "f_double.call(1.5, 2.25)"));
/* await */(check(f_double.call_operator(1.5, 2.25), 3.75, "f_double.call_operator(1.5, 2.25)"));

var f_string = new cpp11_template_pack_specialization.StdFunctionStringString;
/* await */(check(f_string.call("ab", "cd"), "abcd", "f_string.call(\"ab\", \"cd\")"));
/* await */(check(f_string.call_operator("ab", "cd"), "abcd", "f_string.call_operator(\"ab\", \"cd\")"));

var f_mixed = new cpp11_template_pack_specialization.StdFunctionMixed;
/* await */(check(f_mixed.call(1, 2.0, 3), 6, "f_mixed.call(1, 2.0, 3)"));
/* await */(check(f_mixed.call_operator(1, 2.0, 3), 6, "f_mixed.call_operator(1, 2.0, 3)"));
