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

// Class template with a constrained constructor (the class is otherwise unconstrained, but only Numeric T values can construct from a value).
template<typename T>
class CheckedBox {
  T value;
public:
  CheckedBox() : value(T()) {}
  CheckedBox(T v) requires Numeric<T> : value(v) {}
  T get() const { return value; }
};
%}

%template(NumericBoxInt)    NumericBox<int>;
%template(NumericBoxDouble) NumericBox<double>;

%template(HolderInt)        Holder<int>;
%template(HolderDouble)     Holder<double>;

%template(SmallBoxInt)      SmallBox<int>;

%template(CheckedBoxInt)    CheckedBox<int>;
