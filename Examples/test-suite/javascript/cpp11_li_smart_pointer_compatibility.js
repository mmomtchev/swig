
var cpp11_li_smart_pointer_compatibility = require('cpp11_li_smart_pointer_compatibility');

var { Integer } = cpp11_li_smart_pointer_compatibility;

/* async */ function check(actual, expected) {
  if (/* await */(actual) !== expected)
    throw new Error(`expected ${expected}, got ${actual}`);
}

var i17 = new Integer(17);
var sp42 = /* await */(cpp11_li_smart_pointer_compatibility.ProduceSharedPointer(42));
var spp77 = /* await */(cpp11_li_smart_pointer_compatibility.ProduceSharedPointerRef(77));
var ar51 = /* await */(cpp11_li_smart_pointer_compatibility.ProduceUniquePointer(51));

check(i17.get(), 17);

check(cpp11_li_smart_pointer_compatibility.ConsumePlainObject(i17), 17);
check(cpp11_li_smart_pointer_compatibility.ConsumePlainObject(sp42), 42);
check(cpp11_li_smart_pointer_compatibility.ConsumePlainObject(spp77), 77);
check(cpp11_li_smart_pointer_compatibility.ConsumePlainObject(ar51), 51);

check(cpp11_li_smart_pointer_compatibility.ConsumeConstReference(i17), 17);
check(cpp11_li_smart_pointer_compatibility.ConsumeConstReference(sp42), 42);
check(cpp11_li_smart_pointer_compatibility.ConsumeConstReference(spp77), 77);
check(cpp11_li_smart_pointer_compatibility.ConsumeConstReference(ar51), 51);

check(cpp11_li_smart_pointer_compatibility.ConsumePointer(i17), 17);
check(cpp11_li_smart_pointer_compatibility.ConsumePointer(sp42), 42);
check(cpp11_li_smart_pointer_compatibility.ConsumePointer(spp77), 77);
check(cpp11_li_smart_pointer_compatibility.ConsumePointer(ar51), 51);

check(cpp11_li_smart_pointer_compatibility.ConsumeSharedPointer(i17), 17);
check(cpp11_li_smart_pointer_compatibility.ConsumeSharedPointer(sp42), 42);
check(cpp11_li_smart_pointer_compatibility.ConsumeSharedPointer(spp77), 77);
check(cpp11_li_smart_pointer_compatibility.ConsumeSharedPointer(ar51), 51);

check(cpp11_li_smart_pointer_compatibility.ConsumeSharedPointerReference(i17), 17);
check(cpp11_li_smart_pointer_compatibility.ConsumeSharedPointerReference(sp42), 42);
check(cpp11_li_smart_pointer_compatibility.ConsumeSharedPointerReference(spp77), 77);
check(cpp11_li_smart_pointer_compatibility.ConsumeSharedPointerReference(ar51), 51);

check(cpp11_li_smart_pointer_compatibility.ConsumeUniquePtr(i17), 17);
check(cpp11_li_smart_pointer_compatibility.ConsumeUniquePtr(sp42), 42);
check(cpp11_li_smart_pointer_compatibility.ConsumeUniquePtr(spp77), 77);
check(cpp11_li_smart_pointer_compatibility.ConsumeUniquePtr(ar51), 51);
