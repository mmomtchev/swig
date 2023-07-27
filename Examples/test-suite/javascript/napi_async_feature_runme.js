
// This test works only with NAPI in async mode
const napi_async_feature = require('napi_async_feature');

if (/* await */(napi_async_feature.GlobalAsync(2)) !== 4)
  throw new Error;
if (napi_async_feature.GlobalSync(2) !== 4)
  throw new Error;


const obj = new napi_async_feature.Klass;

if (/* await */(obj.Method(2)) !== 6)
  throw new Error;
if (obj.MethodSync !== undefined || obj.MethodAsync !== undefined)
  throw new Error;


const objT = new napi_async_feature.TemplateInt;

if (/* await */(objT.Method(2)) !== 8)
  throw new Error;
if (objT.MethodSync !== undefined || objT.MethodAsync !== undefined)
  throw new Error;

if (objT.MethodAlwaysSync(2) !== 10)
  throw new Error;
if (objT.MethodAlwaysSyncSync !== undefined || objT.MethodAlwaysSyncAsync !== undefined)
  throw new Error;
