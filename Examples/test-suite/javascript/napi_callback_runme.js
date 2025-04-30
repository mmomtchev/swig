const napi_callback = require('napi_callback');

// FIXME: Alas, V8, Node, or someone else with the authority to do so,
// creates an invisible from Node-API Promise when calling
// a JS function that returns a Promise from C++. This Promise
// has no other effects besides the fact that it
// triggers the Node.js unhandledRejection check.
// The Promise does not have a stack trace and it seems to
// be originating somewhere in the C++ code.
// AFAIK, it is almost certainly not an expected behavior.
process.on('unhandledRejection', (e) => {
  console.log('warning, unhandled rejection', e)
});

/**
 * Sync callback
 */
{
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
      throw new Error('Third');
    }));
  } catch (e) {
    if (e.message.match(/Third/))
      third = true;
  }
  if (!third) throw new Error('Third exception not correctly propagated');
}

/**
 * Async callback (only in async mode)
 */
{
  // Nominal
  const r1 = /* await */(napi_callback.GiveMeFive(/* async */(pass, name) => {
    if (pass !== 420) throw new Error('expected 420 as pass');
    if (typeof name !== 'string') throw new Error('expected a string as name');
    return 'sent from JS ' + name;
  }));
  if (r1 !== 'received from JS: sent from JS with cheese')
    throw new Error(`not the expected value, received "${r1}"`);

  const r2 = /* await */(napi_callback.GiveMeFive_C(/* async */(pass, name) => {
    if (pass !== 420) throw new Error('expected 420 as pass');
    if (typeof name !== 'string') throw new Error('expected a string as name');
    return 'sent from JS ' + name;
  }));
  if (r2 !== 'received from JS: sent from JS with extra cheese')
    throw new Error(`not the expected value, received "${r2}"`);

  let called = false;
  /* await */(napi_callback.JustCall(/* async */() => {
    called = true;
  }));
  if (!called)
    throw new Error('did not call');

  // Exception
  let first = false;
  try {
    /* await */(napi_callback.GiveMeFive(/* async */() => {
      throw new Error('First');
    }));
  } catch (e) {
    if (e.message.match(/First/))
      first = true;
  }
  if (!first) throw new Error('First exception not correctly propagated');

  let second = false;
  try {
    /* await */(napi_callback.GiveMeFive_C(/* async */() => {
      throw new Error('Second');
    }));
  } catch (e) {
    if (e.message.match(/Second/))
      second = true;
  }
  if (!second) throw new Error('Second exception not correctly propagated');

  let third = false;
  try {
    /* await */(napi_callback.JustCall(/* async */() => {
      throw new Error('Third');
    }));
  } catch (e) {
    if (e.message.match(/Third/))
      third = true;
  }
  if (!third) throw new Error('Third exception not correctly propagated');
}
