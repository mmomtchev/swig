%module xxx

%inline %{
template<typename T>
concept Numeric = true;
%}

// Concepts are not types and cannot be %template instantiated.
%template(NumericInt) Numeric<int>;
