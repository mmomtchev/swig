%module cpp20_concepts_classes

// C++20 concepts applied to class templates: prefix requires-clause, trailing requires on ordinary methods, compound '&&', constrained constructor.

%inline %{
#include <concepts>

template<typename T>
concept Numeric = std::integral<T> || std::floating_point<T>;

template<typename T>
concept SmallNumeric = Numeric<T> && (sizeof(T) <= 4);

// Class template with a prefix requires-clause on the template head.
template<typename T>
requires Numeric<T>
class NumericBox {
  T value;
public:
  NumericBox() : value(T()) {}
  NumericBox(T v) : value(v) {}
  T get() const { return value; }
  void set(T v) { value = v; }
  T cube() const { return value * value * value; }
};

// Unconstrained class template whose ordinary methods carry their own trailing requires-clauses referencing the class's template parameter.
template<typename T>
class Holder {
  T value;
public:
  Holder() : value(T()) {}
  Holder(T v) : value(v) {}
  T get() const { return value; }
  void set(T v) { value = v; }

  // Trailing requires-clause on an ordinary method.
  T doubled() const requires Numeric<T> { return value + value; }
};

// Class template with a compound prefix requires-clause joined by '&&'.
template<typename T>
requires Numeric<T> && SmallNumeric<T>
class SmallBox {
  T value;
public:
  SmallBox() : value(T()) {}
  SmallBox(T v) : value(v) {}
  T get() const { return value; }
};

// Class template with a constrained constructor (the class is otherwise unconstrained, but only
// Numeric T values can construct from a value).  The constructor's trailing requires-clause is held
// on the constructor node's "constraint" attribute and is substituted when the class template is
// instantiated; both 'int' and 'double' satisfy 'Numeric<T>' so both instantiations succeed.
template<typename T>
class CheckedBox {
  T value;
public:
  CheckedBox() : value(T()) {}
  CheckedBox(T v) requires Numeric<T> : value(v) {}
  T get() const { return value; }
};

// Out of line definition of a member function template of a class template,
// with a prefix requires-clause on its own template head.  Exercises the
// requires_clause_opt path on a doubly templated declaration.
template<typename T>
class OutOfLineBox {
  T value;
public:
  OutOfLineBox(T v) : value(v) {}
  T get() const { return value; }
  template<typename U> requires Numeric<U>
  T scaled(U factor) const;
};

template<typename T>
template<typename U> requires Numeric<U>
T OutOfLineBox<T>::scaled(U factor) const { return value * (T)factor; }
%}

%template(NumericBoxInt)    NumericBox<int>;
%template(NumericBoxDouble) NumericBox<double>;

%template(HolderInt)        Holder<int>;
%template(HolderDouble)     Holder<double>;

%template(SmallBoxInt)      SmallBox<int>;

%template(CheckedBoxInt)    CheckedBox<int>;
%template(CheckedBoxDouble) CheckedBox<double>;

%template(OutOfLineBoxInt)  OutOfLineBox<int>;
