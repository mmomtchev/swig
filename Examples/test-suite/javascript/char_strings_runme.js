var char_strings = require("char_strings");

var assertIsEqual = function(expected, actual) {
  if (expected !== actual) {
    throw new Error("Expected "+expected+", was "+actual);
  }
};

var assertThrows = function(fn) {
  var pass = false;

  try {
    fn();
  } catch {
    pass = true;
  }

  if (!pass) throw new Error('did not throw');
}

assertIsEqual("hi there", /* await */(char_strings.CharPingPong("hi there")));
assertIsEqual("hi there", /* await */(char_strings.CharArrayPingPong("hi there")));
assertIsEqual("hi there", /* await */(char_strings.CharArrayDimsPingPong("hi there")));

// @ts-expect-error
assertThrows(() => (/* await */(char_strings.CharPingPong(42))));
// @ts-expect-error
assertThrows(() => (/* await */(char_strings.CharArrayPingPong(42))));
// @ts-expect-error
assertThrows(() => (/* await */(char_strings.CharArrayDimsPingPong(42))));
