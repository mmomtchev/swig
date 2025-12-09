var napi_function = require('napi_function');

var fn = /* await */(napi_function.ReturnCPPFunction());
var result = fn(420, "Chapai");
if (result !== 'Chapai passed the test')
    throw new Error('ReturnCPPFunction failed');
