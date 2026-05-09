import cpp20_concepts_lambda.*;

public class cpp20_concepts_lambda_runme {

  static {
    try {
      System.loadLibrary("cpp20_concepts_lambda");
    } catch (UnsatisfiedLinkError e) {
      System.err.println("Native code library failed to load. See the chapter on Dynamic Linking Problems in the SWIG Java documentation for help.\n" + e);
      System.exit(1);
    }
  }

  public static void main(String argv[]) {
    // Trailing requires-clause - bare concept.
    if (cpp20_concepts_lambda.run_trailing(5) != 10)
      throw new RuntimeException("run_trailing(5)");

    // Trailing requires-clause - compound '&&'.
    if (cpp20_concepts_lambda.run_compound(7) != 14)
      throw new RuntimeException("run_compound(7)");

    // Trailing requires-clause - inline 'requires requires'.
    if (cpp20_concepts_lambda.run_inline_req(2, 3) != 5)
      throw new RuntimeException("run_inline_req(2, 3)");

    // 'mutable' followed by trailing requires-clause.
    if (cpp20_concepts_lambda.run_with_mut(4) != 8)
      throw new RuntimeException("run_with_mut(4)");
  }
}
