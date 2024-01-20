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

{
  const r = /* await */(napi_li_std.vec1([new napi_li_std.Holder(1), new napi_li_std.Holder(2), new napi_li_std.Holder(3)]));
  if (r.length !== 3 || !(r[2] instanceof napi_li_std.Holder) || r[2].number !== 3) throw new Error('vec1<Holder> failed');
}

{
  const r = /* await */(napi_li_std.RevStringVec(['string1', 'string2', 'string3']));
  if (r.length !== 3 || r[2] !== 'string1') throw new Error('RevStringVec failed');
}

{
  const r = /* await */(napi_li_std.vecreal([1, 2, 3]));
  if (r.length !== 3 || r[2] !== 3) throw new Error('vecreal');
}

{
  const r = /* await */(napi_li_std.vecintptr([1, 2, 3]));
  if (r.length !== 3 || r[2] !== 3) throw new Error('vecintptr');
}

{
  const r = /* await */(napi_li_std.vecstruct([new napi_li_std.Struct(1), new napi_li_std.Struct(2), new napi_li_std.Struct(3)]));
  if (r.length !== 3 || !(r[2] instanceof napi_li_std.Struct) || r[2].num !== 3) throw new Error('vecstruct failed');
}

{
  const r = /* await */(napi_li_std.vecstructptr([new napi_li_std.Struct(1), new napi_li_std.Struct(2), new napi_li_std.Struct(3)]));
  if (r.length !== 3 || !(r[2] instanceof napi_li_std.Struct) || r[2].num !== 3) throw new Error('vecstruct failed');
}

{
  const r = /* await */(napi_li_std.vecstructconstptr([new napi_li_std.Struct(1), new napi_li_std.Struct(2), new napi_li_std.Struct(3)]));
  if (r.length !== 3 || !(r[2] instanceof napi_li_std.Struct) || r[2].num !== 3) throw new Error('vecstruct failed');
}

{
  if ((/* await */(napi_li_std.sum([1, 2, 3]))) !== 6) throw new Error('sum failed');
}

{
  const r = /* await */(napi_li_std.return_vector_in_arg_ref());
  if (r.length !== 3 || r[2] !== 8) throw new Error('return_vector_in_arg_ref failed');
}

{
  const r = /* await */(napi_li_std.return_vector_in_arg_ptr());
  if (r.length !== 3 || r[2] !== 8) throw new Error('return_vector_in_arg_ptr failed');
}
