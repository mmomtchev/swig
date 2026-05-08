import cpp20_concepts_classes.*;

public class cpp20_concepts_classes_runme {

  static {
    try {
      System.loadLibrary("cpp20_concepts_classes");
    } catch (UnsatisfiedLinkError e) {
      System.err.println("Native code library failed to load. See the chapter on Dynamic Linking Problems in the SWIG Java documentation for help.\n" + e);
      System.exit(1);
    }
  }

  public static void main(String argv[]) {
    // Class template with a prefix requires-clause on the template head.
    NumericBoxInt nb = new NumericBoxInt(7);
    if (nb.get() != 7)
      throw new RuntimeException("NumericBoxInt.get");
    nb.set(9);
    if (nb.get() != 9)
      throw new RuntimeException("NumericBoxInt.set/get");
    if (nb.cube() != 729)
      throw new RuntimeException("NumericBoxInt.cube");

    NumericBoxDouble ndb = new NumericBoxDouble(2.0);
    if (ndb.get() != 2.0)
      throw new RuntimeException("NumericBoxDouble.get");
    if (ndb.cube() != 8.0)
      throw new RuntimeException("NumericBoxDouble.cube");

    // Class template whose ordinary methods carry their own trailing requires-clauses.
    HolderInt hi = new HolderInt(5);
    if (hi.get() != 5)
      throw new RuntimeException("HolderInt.get");
    if (hi.doubled() != 10)
      throw new RuntimeException("HolderInt.doubled");
    hi.set(-3);
    if (hi.doubled() != -6)
      throw new RuntimeException("HolderInt.doubled after set");

    HolderDouble hd = new HolderDouble(1.5);
    if (hd.doubled() != 3.0)
      throw new RuntimeException("HolderDouble.doubled");

    // Class template with a compound prefix requires-clause joined by '&&'.
    SmallBoxInt sb = new SmallBoxInt(42);
    if (sb.get() != 42)
      throw new RuntimeException("SmallBoxInt.get");

    // Class template with a constrained constructor.  'int' and 'double' both satisfy Numeric.
    CheckedBoxInt cb = new CheckedBoxInt(11);
    if (cb.get() != 11)
      throw new RuntimeException("CheckedBoxInt.get");
    CheckedBoxDouble cbd = new CheckedBoxDouble(2.5);
    if (cbd.get() != 2.5)
      throw new RuntimeException("CheckedBoxDouble.get");

    // Class template whose member function template is defined out of line with a prefix requires-clause.
    OutOfLineBoxInt ob = new OutOfLineBoxInt(3);
    if (ob.get() != 3)
      throw new RuntimeException("OutOfLineBoxInt.get");
  }
}
