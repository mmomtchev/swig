var funcptr_cpp = require("funcptr_cpp");

if (/* await */(funcptr_cpp.call1(funcptr_cpp.ADD_BY_VALUE, 10, 11)) != 21) {
    throw new Error;
}
if (/* await */(funcptr_cpp.call2(funcptr_cpp.ADD_BY_POINTER, 12, 13)) != 25) {
    throw new Error;
}
if (/* await */(funcptr_cpp.call3(funcptr_cpp.ADD_BY_REFERENCE, 14, 15)) != 29) {
    throw new Error;
}
if (/* await */(funcptr_cpp.call1(funcptr_cpp.ADD_BY_VALUE_C, 2, 3)) != 5) {
    throw new Error;
}
if (/* await */(funcptr_cpp.callconst1(funcptr_cpp.ADD_BY_VALUE_C, 2, 3)) != 5) {
    throw new Error;
}

var holder = new funcptr_cpp.AddByValueHolder();
if (/* await */(holder.byValueMethod(4, 5)) != 9) {
    throw new Error;
}
if (/* await */(holder.byValueConstMethod(5, 6)) != 11) {
    throw new Error;
}
if (/* await */(holder.byValueRef(6, 7)) != 13) {
    throw new Error;
}
if (/* await */(funcptr_cpp.addByValueRef(10, 11)) != 21) {
    throw new Error;
}

if (/* await */(funcptr_cpp.callref1(funcptr_cpp.ADD_BY_VALUE, 1, 2)) != 3) {
    throw new Error;
}
if (/* await */(funcptr_cpp.callref2(funcptr_cpp.ADD_BY_VALUE, 2, 3)) != 5) {
    throw new Error;
}
if (/* await */(funcptr_cpp.callref1(/* await */(funcptr_cpp.getAddByValueRef1()), 3, 4)) != 7) {
    throw new Error;
}
if (/* await */(funcptr_cpp.callref2(/* await */(funcptr_cpp.getAddByValueRef2()), 4, 5)) != 9) {
    throw new Error;
}
var refholder = new funcptr_cpp.AddByValueRefHolder(funcptr_cpp.ADD_BY_VALUE);
if (/* await */(refholder.call(5, 6)) != 11) {
    throw new Error;
}
if (/* await */(refholder.fnRef(6, 7)) != 13) {
    throw new Error;
}
