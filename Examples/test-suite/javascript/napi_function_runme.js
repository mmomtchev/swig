var napi_function = require('napi_function');

var fnCPP = /* await */(napi_function.ReturnCPPFunction());
var result = fnCPP(420, 'Chapai');
if (result !== 'Chapai passed the test')
  throw new Error('ReturnCPPFunction failed');

var fnC = /* await */(napi_function.ReturnCFunction());
var result = fnC(420, 'Petka');
if (result !== 'Petka passed the C test')
  throw new Error('ReturnCFunction failed');
