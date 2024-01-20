// Node-API specific implementations
// (with copy-conversion)
%module napi_li_std

%include "std_vector.i"

// Convert all input arguments
%apply(std::vector const &INPUT)      { std::vector const & }
%apply(std::vector INPUT)             { std::vector };

// Convert all return values
%apply(std::vector RETURN)            { std::vector };

%include "li_std_vector.i"
