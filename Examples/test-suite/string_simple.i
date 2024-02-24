%module string_simple

%newobject copy_str;

%inline %{
#include <stdlib.h>
#include <string.h>
const char* copy_str(const char* str) {
  size_t len = strlen(str);
#ifdef __cplusplus
  char* newstring = new char[len + 1];
#else
  char* newstring = (char*) malloc(len + 1);
#endif
  strcpy(newstring, str);
  return newstring;
}
%}
