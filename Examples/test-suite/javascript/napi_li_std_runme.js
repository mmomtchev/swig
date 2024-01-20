var napi_li_std = require('napi_li_std');

// This tests the generic STL conversion typemaps that work only with Node-API

{
  const r = /* await */(napi_li_std.half([1, 2, 3]));
  if (r.length !== 3 || r[2] !== 1.5) throw new Error('half failed');
}

{
  const r = /* await */(napi_li_std.average([1, 2, 3]));
  if (r !== 2) throw new Error('average failed');
}


if ((/* await */(napi_li_std.sum([1, 2, 3]))) !== 6) throw new Error('sum failed');

