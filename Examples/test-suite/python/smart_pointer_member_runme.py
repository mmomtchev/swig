from smart_pointer_member import *


f = Foo()
f.y = 1

if f.y != 1:
    raise RuntimeError

b = Bar(f)
b.y = 2

if f.y != 2:
    raise RuntimeError("Failed {} {}".format(f.y, b.y))

if b.x != f.x:
    raise RuntimeError

if b.ZZ != f.ZZ:
    raise RuntimeError

if b.z != f.z:
    raise RuntimeError

if Foo.z == Bar.z:
    raise RuntimeError
