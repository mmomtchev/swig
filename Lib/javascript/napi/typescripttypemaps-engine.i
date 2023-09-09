// Node-API specific TypeScript typemaps

%typemap(ts)    (const void *buffer_data, const size_t buffer_len)  "Buffer";
%typemap(tsout) (void **buffer_data, size_t *buffer_len)            "Buffer";
