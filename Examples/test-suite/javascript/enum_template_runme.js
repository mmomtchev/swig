var enum_template = require("enum_template");

if (/* await */(enum_template.MakeETest()) != 1)
  throw new Error("RuntimeError");

if (/* await */(enum_template.TakeETest(enum_template.eTest0)) != null)
  throw new Error("RuntimeError");

