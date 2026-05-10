var cpp11_shared_ptr_nullptr_in_containers = require('cpp11_shared_ptr_nullptr_in_containers');

// This test compiles in JSC and SWIG V8 but does not work
// since there is no smart pointer support
if (!(cpp11_shared_ptr_nullptr_in_containers.SWIG_NODE_API in [0, 1]))
  throw new Error('SWIG Node-API marker not defined');
if (cpp11_shared_ptr_nullptr_in_containers.SWIG_NODE_API === 1) {
const a = /* await */(cpp11_shared_ptr_nullptr_in_containers.ret_vec_c_shared_ptr());
if (!(a instanceof cpp11_shared_ptr_nullptr_in_containers.c_array))
  throw new Error('Did not receive an array');

if (/* await */(a.size()) !== 3)
  throw new Error('Expected 3 elements');


const values = [0, null, 2];
for (const i in values) {
  const el = /* await */(a.get(+i));
  if (values[i] === null) {
    if (el !== null)
      throw new Error(`${i} element is not null`);
  } else {
    if (/* await */(el.get_m()) !== values[i])
      throw new Error(`${i} element is not ${values[i]}`);
  }
}
}
else console.log('test skipped');
