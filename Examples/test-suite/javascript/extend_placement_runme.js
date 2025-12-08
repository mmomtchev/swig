var extend_placement = require("extend_placement");

var foo = new extend_placement.Foo();
foo = new extend_placement.Foo(1);
foo = new extend_placement.Foo(1, 1);
/* await */(foo.spam());
/* await */(foo.spam("hello"));
/* await */(foo.spam(1));
/* await */(foo.spam(1, 1));
/* await */(foo.spam(1, 1, 1));
/* await */(foo.spam(new extend_placement.Foo()));
/* await */(foo.spam(new extend_placement.Foo(), 1.0));


var bar = new extend_placement.Bar();
bar = new extend_placement.Bar(1);
/* await */(bar.spam());
/* await */(bar.spam("hello"));
/* await */(bar.spam(1));
/* await */(bar.spam(1, 1));
/* await */(bar.spam(1, 1, 1));
/* await */(bar.spam(new extend_placement.Bar()));
/* await */(bar.spam(new extend_placement.Bar(), 1.0));


var footi = new extend_placement.FooTi();
footi = new extend_placement.FooTi(1);
footi = new extend_placement.FooTi(1, 1);
/* await */(footi.spam());
/* await */(footi.spam("hello"));
/* await */(footi.spam(1));
/* await */(footi.spam(1, 1));
/* await */(footi.spam(1, 1, 1));
/* await */(footi.spam(new extend_placement.Foo()));
/* await */(footi.spam(new extend_placement.Foo(), 1.0));


var barti = new extend_placement.BarTi();
barti = new extend_placement.BarTi(1);
/* await */(barti.spam());
/* await */(barti.spam("hello"));
/* await */(barti.spam(1));
/* await */(barti.spam(1, 1));
/* await */(barti.spam(1, 1, 1));
/* await */(barti.spam(new extend_placement.Bar()));
/* await */(barti.spam(new extend_placement.Bar(), 1.0));
