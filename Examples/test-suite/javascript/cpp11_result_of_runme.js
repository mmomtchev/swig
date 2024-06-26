var cpp11_result_of = require("cpp11_result_of");

var result = /* await */(cpp11_result_of.test_result(cpp11_result_of.SQUARE, 3.0));
if (result != 9.0) {
    throw new Error(`test_result(square, 3.0) is not 9.0. Got: ${result}`);
}

result = /* await */(cpp11_result_of.test_result_alternative1(cpp11_result_of.SQUARE, 3.0));
if (result != 9.0) {
    throw new Error(`test_result_alternative1(square, 3.0) is not 9.0. Got: ${result}`);
}
