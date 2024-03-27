// Node-API specific implementations
// (with copy-conversion)
%module napi_li_std_vector

%include "std_vector.i"

// Convert all input arguments
%apply(std::vector const &INPUT)      { std::vector const & }
%apply(std::vector INPUT)             { std::vector };

// Convert all return values
%apply(std::vector RETURN)            { std::vector };
%apply(std::vector &RETURN)           { std::vector *, std::vector & };

// Convert "*output" and "&output" to return values
%apply(std::vector &OUTPUT)           { std::vector &output, std::vector *output };

%include "li_std_vector.i"

// Additional case, return vector in an argument
void return_vector_in_arg_ref(std::vector<int> &output);
void return_vector_in_arg_ptr(std::vector<int> *output);

%{
void return_vector_in_arg_ref(std::vector<int> &output) {
  output = { 3, 5, 8 };
}
void return_vector_in_arg_ptr(std::vector<int> *output) {
  *output = { 3, 5, 8 };
}
%}


// Special case of a unique_ptr (non-copyable object)
%include <std_unique_ptr.i>
%unique_ptr(Integer);

%inline %{
struct Integer {
  int value;
  Integer(int v): value(v) {};
};
void return_vector_unique_ptr(std::vector<std::unique_ptr<Integer>> &output) {
  output.emplace_back(new Integer(3));
  output.emplace_back(new Integer(5));
  output.emplace_back(new Integer(8));
}
int receive_vector_unique_ptr(const std::vector<std::unique_ptr<Integer>> &input) {
  return input[2]->value;
}
const std::vector<std::unique_ptr<Integer>> &return_const_vector_unique() {
  static std::vector<std::unique_ptr<Integer>> const_vector;
  if (const_vector.size() == 0) {
    const_vector.emplace_back(new Integer(3));
    const_vector.emplace_back(new Integer(5));
    const_vector.emplace_back(new Integer(8));
  }
  return const_vector;
}
%}
