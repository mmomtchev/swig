
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
    if (cpp20_concepts.cube_int(3) != 27)
      throw new RuntimeException("cube_int(3)");
    if (cpp20_concepts.cube_int(-4) != -64)
      throw new RuntimeException("cube_int(-4)");
    if (cpp20_concepts.cube_double(2.0) != 8.0)
      throw new RuntimeException("cube_double(2.0)");
    if (cpp20_concepts.cube_double(0.5) != 0.125)
      throw new RuntimeException("cube_double(0.5)");
  }
}
