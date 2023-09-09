%module napi_buffer_argout

// This test is specific to Node-API 
%include <nodejs_buffer.i>

%inline %{
// This triggers a Node-API argout typemap
void return_buffer(void **buffer_data, size_t *buffer_len) {
  *buffer_data = malloc(32 / 8);
  *buffer_len = 32 / 8;
  *(reinterpret_cast<uint32_t*>(*buffer_data)) = 17;
}
%}
