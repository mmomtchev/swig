var cpp11_variadic_function_templates = require("cpp11_variadic_function_templates");

const {A, B, C, D, variadicmix1} = cpp11_variadic_function_templates;

var ec = new cpp11_variadic_function_templates.EmplaceContainer();
/* await */(ec.emplace(new A()));
/* await */(ec.emplace(new A(), new B()));
/* await */(ec.emplace(new A(), new B(), new C()));
/* await */(ec.emplace(new A(), new B(), new C(), new D()));

function check(expected, got) {
    if (expected != got) {
        throw new Error(`failed: ${expected} != ${got}`);
    }
}
var a = new A();
var b = new B();
var c = new C();
check(/* await */(variadicmix1()), 20);
check(/* await */(variadicmix1(a)), 20);
check(/* await */(variadicmix1(a, b)), 10);
check(/* await */(variadicmix1(a, b, c)), 20);
check(/* await */(variadicmix1(11, 22)), 10);
