import cpp20_abbreviated_template_mixed.*;

public class cpp20_abbreviated_template_mixed_runme {

  static {
    try {
      System.loadLibrary("cpp20_abbreviated_template_mixed");
    } catch (UnsatisfiedLinkError e) {
      System.err.println("Native code library failed to load. See the chapter on Dynamic Linking Problems in the SWIG Java documentation for help.\n" + e);
      System.exit(1);
    }
  }

  public static void main(String argv[]) {
    // Each non-decorated case pairs std::string with a numeric type so an argument order swap is a
    // Java compile error rather than a silent numeric conversion.

    // a. Explicit typename + auto.  T=std::string, auto=int.
    if (!cpp20_abbreviated_template_mixed.a_mix_si("hello", 5).equals("hello:5"))
      throw new RuntimeException("a_mix_si");

    // b. Auto + explicit typename.  Template <U=std::string, auto=int> -> wrapped (int, std::string).
    if (!cpp20_abbreviated_template_mixed.b_mix_is(3, "hi").equals("3:hi"))
      throw new RuntimeException("b_mix_is");

    // c. Two explicit parms surrounding an auto.  Template <T=int, V=int, auto=std::string> ->
    // wrapped (int, string, int) per the function parm order.
    if (!cpp20_abbreviated_template_mixed.c_mix_isi(1, "x", 2).equals("1/x/2"))
      throw new RuntimeException("c_mix_isi");

    // d. Constrained explicit + constrained auto.  T=int, auto=short.
    // Return = x*1000 + y*10 + sizeof(T) - sizeof(auto) = 3*1000 + 4*10 + (4 - 2) = 3042.
    if (cpp20_abbreviated_template_mixed.d_mix_is(3, (short)4) != 3042)
      throw new RuntimeException("d_mix_is");

    // e. Two autos surrounding an explicit typename.  auto=string, T=int, auto=string.
    if (!cpp20_abbreviated_template_mixed.e_mix_iss("a", 7, "b").equals("a/7/b"))
      throw new RuntimeException("e_mix_iss");
  }
}
