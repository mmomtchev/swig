// Node-API specific TypeScript typemaps

%typemap(tsout) (void **buffer_data, size_t *buffer_len) "Buffer";

