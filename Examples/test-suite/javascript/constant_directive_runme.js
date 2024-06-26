var constant_directive = require("constant_directive");

// TODO
// Include an official method for detecting the generator
// from the target language environment
/* @ts-ignore */
if (typeof print === 'undefined' && typeof constant_directive.Type1.prototype.equals === 'undefined') {
  // instanceof is not fully supported in JSC/V8
  if (!(constant_directive.TYPE1_CONSTANT1 instanceof constant_directive.Type1)) {
    throw new Error("Failure: TYPE1_CONSTANT1 type: " +
      typeof constant_directive.TYPE1_CONSTANT1);
  }
  if (!(/* await */(constant_directive.getType1Instance()) instanceof constant_directive.Type1)) {
    throw new Error("Failure: getType1Instance() type: " +
      typeof constant_directive.getType1Instance());
  }
}

if (constant_directive.TYPE1_CONSTANT1.val != 1) {
  throw new Error("constant_directive.TYPE1_CONSTANT1.val is %r (should be 1) " +
    constant_directive.TYPE1_CONSTANT1.val);
}

if (constant_directive.TYPE1_CONSTANT2.val != 2) {
  throw new Error("constant_directive.TYPE1_CONSTANT2.val is %r (should be 2) " +
    constant_directive.TYPE1_CONSTANT2.val);
}

if (constant_directive.TYPE1_CONSTANT3.val != 3) {
  throw new Error("constant_directive.TYPE1_CONSTANT3.val is %r (should be 3) " +
    constant_directive.TYPE1_CONSTANT3.val);
}

if (constant_directive.TYPE1CONST_CONSTANT1.val != 1) {
  throw new Error("constant_directive.TYPE1CONST_CONSTANT1.val is %r (should be 1) " +
    constant_directive.TYPE1CONST_CONSTANT1.val);
}

if (constant_directive.TYPE1CPTR_CONSTANT1.val != 1) {
  throw new Error("constant_directive.TYPE1CPTR_CONSTANT1.val is %r (should be 1) " +
    constant_directive.TYPE1CPTR_CONSTANT1.val);
}
