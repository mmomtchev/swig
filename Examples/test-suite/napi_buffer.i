%module napi_buffer

// This test is specific to Node-API 
%include <nodejs_buffer.i>
%include <arraybuffer.i>

%typemap(freearg, noblock=1) (void **buffer_data, size_t *buffer_len) "free(*$1);";
%typemap(freearg, noblock=1) (void **arraybuffer_data, size_t *arraybuffer_len) "free(*$1);";

%inline %{
// This triggers a Node-API argout typemap
void return_buffer(void **buffer_data, size_t *buffer_len) {
  *buffer_data = malloc(32 / 8);
  *buffer_len = 32 / 8;
  *(reinterpret_cast<uint32_t*>(*buffer_data)) = 17;
}

void return_zerolen_buffer(void **buffer_data, size_t *buffer_len) {
  *buffer_data = malloc(0);
  *buffer_len = 0;
}

void return_null_buffer(void **buffer_data, size_t *buffer_len) {
  *buffer_data = nullptr;
  *buffer_len = 0;
}

void consume_buffer(const void *buffer_data, const size_t buffer_len) {
  if (*(reinterpret_cast<const uint32_t*>(buffer_data)) != 42) {
    printf("Expected Buffer data 42, got %u\n",
      (unsigned)*(reinterpret_cast<const uint32_t*>(buffer_data)));
    abort();
  }
  if (buffer_len != 4) {
    printf("Expected Buffer len 4, got %u\n", (unsigned)buffer_len);
    abort();
  }
}

void return_arraybuffer(void **arraybuffer_data, size_t *arraybuffer_len) {
  *arraybuffer_data = malloc(32 / 8);
  *arraybuffer_len = 32 / 8;
  *(reinterpret_cast<uint32_t*>(*arraybuffer_data)) = 17;
}

void return_zerolen_arraybuffer(void **arraybuffer_data, size_t *arraybuffer_len) {
  *arraybuffer_data = malloc(0);
  *arraybuffer_len = 0;
}

void return_null_arraybuffer(void **arraybuffer_data, size_t *arraybuffer_len) {
  *arraybuffer_data = nullptr;
  *arraybuffer_len = 0;
}

void consume_arraybuffer(const void *arraybuffer_data, const size_t arraybuffer_len) {
  if (*(reinterpret_cast<const uint32_t*>(arraybuffer_data)) != 42) {
    printf("Expected ArrayBuffer data 42, got %u\n",
      (unsigned)*(reinterpret_cast<const uint32_t*>(arraybuffer_data)));
    abort();
  }
  if (arraybuffer_len != 4) {
    printf("Expected ArrayBuffer len 4, got %u\n", (unsigned)arraybuffer_len);
    abort();
  }
}

// This triggers the memory sync problem in WASM
void fill_arraybuffer(void *arraybuffer_data, size_t arraybuffer_len) {
  memset(arraybuffer_data, 0x17, arraybuffer_len);
}

%}
