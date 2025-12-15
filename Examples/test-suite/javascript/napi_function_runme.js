var napi_function = require('napi_function')

// C++
var fn = /* await */(napi_function.return_function(420));

var r = /* await */(fn(420, 'Petka'));
if (r !== 'Petka passed the C++ test')
  throw new Error('failed function call');

var pass = false;
try {
  /* await */(fn(419, 'Chapai'));
} catch {
  pass = true;
}
if (!pass) throw new Error('call did not throw');

// C
var fn2 = /* await */(napi_function.return_function_ptr());

var r2 = /* await */(fn2(42, 'Chapai'));
if (r2 !== 'Chapai passed the C test')
  throw new Error('failed function pointer call');

r2 = /* await */(fn2(41, 'Chapai'));
if (r2 !== null) throw new Error('pointer call did not fail');
