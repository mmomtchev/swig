const typescript_argout = require('napi_buffer');

const buf = /* await */(typescript_argout.return_buffer());
if (!(buf instanceof Buffer)) throw new Error(`Expected a Buffer, got ${buf}`);

const uint32 = new Uint32Array(buf.buffer, buf.byteOffset);
if (uint32[0] !== 17) throw new Error(`Expected 17, got ${uint32[0]}`);
