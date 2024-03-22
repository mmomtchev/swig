
var napi_li_std_shared_ptr = require('napi_li_std_shared_ptr');

var { Integer } = napi_li_std_shared_ptr;

/* async */ function check(actual, expected) {
  if (/* await */(actual) !== expected)
    throw new Error(`expected ${expected}, got ${actual}`);
}

var i17 = new Integer(17);
var p42 = /* await */(napi_li_std_shared_ptr.ProduceSharedPointer(42));

check(i17.get(), 17);

check(napi_li_std_shared_ptr.ConsumePlainObject(i17), 17);
check(napi_li_std_shared_ptr.ConsumePlainObject(p42), 42);

check(napi_li_std_shared_ptr.ConsumeConstReference(i17), 17);
check(napi_li_std_shared_ptr.ConsumeConstReference(p42), 42);

check(napi_li_std_shared_ptr.ConsumePointer(i17), 17);
check(napi_li_std_shared_ptr.ConsumePointer(p42), 42);

check(napi_li_std_shared_ptr.ConsumeSharedPointer(i17), 17);
check(napi_li_std_shared_ptr.ConsumeSharedPointer(p42), 42);

check(napi_li_std_shared_ptr.ConsumeSharedPointerReference(i17), 17);
check(napi_li_std_shared_ptr.ConsumeSharedPointerReference(p42), 42);
