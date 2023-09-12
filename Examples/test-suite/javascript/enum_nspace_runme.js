var enum_nspace = require('enum_nspace');

if (enum_nspace.select1(enum_nspace.outer.inner.YES) !== true) throw new Error;
if (enum_nspace.select1(enum_nspace.outer.inner.NO) !== false) throw new Error;
if (enum_nspace.select2(enum_nspace.outer.inner.YES) !== true) throw new Error;
if (enum_nspace.select2(enum_nspace.outer.inner.NO) !== false) throw new Error;
