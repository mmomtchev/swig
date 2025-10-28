/// <reference types="./resolve.d.ts" />

export default function resolve(val) {
  if (!(val instanceof Promise)) throw new Error(`Returned value ${val} is not a Promise`);
  return val;
}
