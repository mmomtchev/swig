var not_c_keywords = require("not_c_keywords");

var cs = new not_c_keywords.ComplexStruct();
/* await */(cs.init());
if (cs.complex != 123) {
    throw new Error("complex not correct");
}
cs.complex = 456;

// 'this' is wrapped only for the jsc engine, the v8 and napi wrappers are compiled as C++
// @ts-expect-error TypeScript is tested only with napi at the moment
if (not_c_keywords.this_function !== undefined) {
    // @ts-expect-error TypeScript is tested only with napi at the moment
    if (not_c_keywords.this_function(1) != 2) {
        throw new Error("this_function not correct");
    }
}
