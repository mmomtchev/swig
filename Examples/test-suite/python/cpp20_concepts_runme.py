from cpp20_concepts import cube_int, cube_double

def check_equal(a, b):
    if a != b:
        raise RuntimeError("{} is not equal to {}".format(a, b))

check_equal(cube_int(3), 27)
check_equal(cube_int(-4), -64)
check_equal(cube_double(2.0), 8.0)
check_equal(cube_double(0.5), 0.125)
