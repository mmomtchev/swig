var cpp11_attribute_specifiers = require('cpp11_attribute_specifiers');

const s = new cpp11_attribute_specifiers.S;
/* @ts-expect-error */
if (typeof s.hidden !== 'undefined') {
  throw new Error('S.hidden not ignored');
}

/* @ts-expect-error */
if (typeof s.hiddenWithString !== 'undefined') {
  throw new Error('S.hiddenWithString not ignored');
}
