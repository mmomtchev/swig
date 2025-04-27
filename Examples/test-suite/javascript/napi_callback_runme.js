const napi_callback = require('napi_callback');

// Nominal
const r1 = /* await */(napi_callback.GiveMeFive((pass, name) => {
  if (pass !== 420) throw new Error('expected 420 as pass');
  if (typeof name !== 'string') throw new Error('expected a string as name');
  return 'sent from JS ' + name;
}));
if (r1 !== 'received from JS: sent from JS with cheese')
  throw new Error(`not the expected value, received "${r1}"`);

const r2 = /* await */(napi_callback.GiveMeFive_C((pass, name) => {
  if (pass !== 420) throw new Error('expected 420 as pass');
  if (typeof name !== 'string') throw new Error('expected a string as name');
  return 'sent from JS ' + name;
}));
if (r2 !== 'received from JS: sent from JS with extra cheese')
  throw new Error(`not the expected value, received "${r2}"`);

let called = false;
/* await */(napi_callback.JustCall(() => {
  called = true;
}));
if (!called)
  throw new Error('did not call');

// Exception
let first = false;
try {
  /* await */(napi_callback.GiveMeFive(() => {
  throw new Error('First');
}));
} catch (e) {
  if (e.message.match(/First/))
    first = true;
}
if (!first) throw new Error('First exception not correctly propagated');

let second = false;
try {
  /* await */(napi_callback.GiveMeFive_C(() => {
  throw new Error('Second');
}));
} catch (e) {
  if (e.message.match(/Second/))
    second = true;
}
if (!second) throw new Error('Second exception not correctly propagated');

let third = false;
try {
  /* await */(napi_callback.JustCall(() => {
  called = true;
}));
} catch (e) {
  if (!third) throw new Error('Third exception not correctly propagated');
}
