
import cpp20_concepts.*;

public class cpp20_concepts_runme {

  static {
    try {
      System.loadLibrary("cpp20_concepts");
    } catch (UnsatisfiedLinkError e) {
      System.err.println("Native code library failed to load. See the chapter on Dynamic Linking Problems in the SWIG Java documentation for help.\n" + e);
      System.exit(1);
    }
  }

  public static void main(String argv[]) {
    // Trailing requires-clause.
    if (cpp20_concepts.cube_int(3) != 27)
      throw new RuntimeException("cube_int(3)");
    if (cpp20_concepts.cube_int(-4) != -64)
      throw new RuntimeException("cube_int(-4)");
    if (cpp20_concepts.cube_double(2.0) != 8.0)
      throw new RuntimeException("cube_double(2.0)");
    if (cpp20_concepts.cube_double(0.5) != 0.125)
      throw new RuntimeException("cube_double(0.5)");

    // Prefix requires-clause - bare concept.
    if (cpp20_concepts.quad_int(2) != 16)
      throw new RuntimeException("quad_int(2)");
    if (cpp20_concepts.quad_int(-3) != 81)
      throw new RuntimeException("quad_int(-3)");
    if (cpp20_concepts.quad_double(1.5) != 5.0625)
      throw new RuntimeException("quad_double(1.5)");

    // Prefix requires-clause - compound constraint joined by '&&'.
    if (cpp20_concepts.half_int(8) != 4)
      throw new RuntimeException("half_int(8)");
    if (cpp20_concepts.half_int(-9) != -4)
      throw new RuntimeException("half_int(-9)");

    // Prefix requires-clause - parenthesised constraint subexpression.
    if (cpp20_concepts.identity_int(42) != 42)
      throw new RuntimeException("identity_int(42)");
    if (cpp20_concepts.identity_int(-1) != -1)
      throw new RuntimeException("identity_int(-1)");

    // Trailing requires-clause whose constraint contains a requires-expression
    // as a primary.
    if (cpp20_concepts.add_int(2, 3) != 5)
      throw new RuntimeException("add_int(2, 3)");
    if (cpp20_concepts.add_int(-7, 4) != -3)
      throw new RuntimeException("add_int(-7, 4)");
  }
}
