%module napi_li_typemaps

// Test the (partially implemented) support for retuning arguments as named fields in an object

// INPUT
%typemap(in) SWIGTYPE *INPUT ($*1_ltype val), SWIGTYPE &INPUT ($*1_ltype val) {
  $typemap(in, $*1_ltype, 1=val);
  $1 = &val;
}

// OUTPUT_FIELD
%typemap(in, numinputs=0) SWIGTYPE *OUTPUT_FIELD ($*1_ltype val), SWIGTYPE &OUTPUT_FIELD ($*1_ltype val) {
  $1 = &val;
}
%typemap(argout) SWIGTYPE *OUTPUT_FIELD, SWIGTYPE &OUTPUT_FIELD {
  Napi::Value js_out;
  $typemap(out, $*1_ltype, 1=*$1, result=js_out)
  $result = SWIG_NAPI_AppendOutputField(env, $result, "$1_name", js_out);
}
%typemap(tsout, merge="object") SWIGTYPE *OUTPUT_FIELD, SWIGTYPE &OUTPUT_FIELD "$typemap(ts, $*1_ltype)";

// INOUT_FIELD
%typemap(in) SWIGTYPE *INOUT_FIELD = SWIGTYPE *INPUT;
%typemap(in) SWIGTYPE &INOUT_FIELD = SWIGTYPE &INPUT;
%typemap(argout) SWIGTYPE *INOUT_FIELD = SWIGTYPE *OUTPUT_FIELD;
%typemap(argout) SWIGTYPE &INOUT_FIELD = SWIGTYPE &OUTPUT_FIELD;
%typemap(tsout) SWIGTYPE *INOUT_FIELD = SWIGTYPE *OUTPUT_FIELD;
%typemap(tsout) SWIGTYPE &INOUT_FIELD = SWIGTYPE &OUTPUT_FIELD;

// Alternate names
%apply SWIGTYPE *OUTPUT_FIELD { int *OUTPUT_FIELD2 };
%apply SWIGTYPE &INOUT_FIELD { int &INOUT_FIELD2 };

// Renaming of a field (the stop-gap solution)
%typemap(argout) int &INOUT_FIELD2 {
  Napi::Value js_out;
  $typemap(out, $*1_ltype, 1=*$1, result=js_out)
  %append_output_field("inout2", js_out);
}
%typemap(tsout) int &INOUT_FIELD2 "inout2: number";

// Test renaming result
%typemap(out) Foo *out_foo_status {
  Napi::Value js_out;
  $typemap(out, Foo*, result=js_out)
  %append_output_field("status", js_out);
}
%typemap(ts) Foo *out_foo_status "status: $typemap(ts, Foo *)";

// Test removing result
%typemap(out) Foo *out_foo_void { 
  $result = env.Undefined();
}
%typemap(ts) Foo *out_foo_void "void";
%typemap(ret) Foo *out_foo_void {
  delete $1;
}

%newobject out_foo;
%newobject out_foo_status;
%inline %{

struct Foo { int a; };

bool in_bool(bool *INPUT) { return *INPUT; }
int in_int(int *INPUT) { return *INPUT; }
long in_long(long *INPUT) { return *INPUT; }
short in_short(short *INPUT) { return *INPUT; }
unsigned int in_uint(unsigned int *INPUT) { return *INPUT; }
unsigned short in_ushort(unsigned short *INPUT) { return *INPUT; }
unsigned long in_ulong(unsigned long *INPUT) { return *INPUT; }
unsigned char in_uchar(unsigned char *INPUT) { return *INPUT; }
signed char in_schar(signed char *INPUT) { return *INPUT; }
float in_float(float *INPUT) { return *INPUT; }
double in_double(double *INPUT) { return *INPUT; }
long long in_longlong(long long *INPUT) { return *INPUT; }
unsigned long long in_ulonglong(unsigned long long *INPUT) { return *INPUT; }

bool inr_bool(bool &INPUT) { return INPUT; }
int inr_int(int &INPUT) { return INPUT; }
long inr_long(long &INPUT) { return INPUT; }
short inr_short(short &INPUT) { return INPUT; }
unsigned int inr_uint(unsigned int &INPUT) { return INPUT; }
unsigned short inr_ushort(unsigned short &INPUT) { return INPUT; }
unsigned long inr_ulong(unsigned long &INPUT) { return INPUT; }
unsigned char inr_uchar(unsigned char &INPUT) { return INPUT; }
signed char inr_schar(signed char &INPUT) { return INPUT; }
float inr_float(float &INPUT) { return INPUT; }
double inr_double(double &INPUT) { return INPUT; }
long long inr_longlong(long long &INPUT) { return INPUT; }
unsigned long long inr_ulonglong(unsigned long long &INPUT) { return INPUT; }

void out_bool(bool x, bool *OUTPUT_FIELD) {  *OUTPUT_FIELD = x; }
void out_int(int x, int *OUTPUT_FIELD) {  *OUTPUT_FIELD = x; }
void out_short(short x, short *OUTPUT_FIELD) {  *OUTPUT_FIELD = x; }
void out_long(long x, long *OUTPUT_FIELD) {  *OUTPUT_FIELD = x; }
void out_uint(unsigned int x, unsigned int *OUTPUT_FIELD) {  *OUTPUT_FIELD = x; }
void out_ushort(unsigned short x, unsigned short *OUTPUT_FIELD) {  *OUTPUT_FIELD = x; }
void out_ulong(unsigned long x, unsigned long *OUTPUT_FIELD) {  *OUTPUT_FIELD = x; }
void out_uchar(unsigned char x, unsigned char *OUTPUT_FIELD) {  *OUTPUT_FIELD = x; }
void out_schar(signed char x, signed char *OUTPUT_FIELD) {  *OUTPUT_FIELD = x; }
void out_float(float x, float *OUTPUT_FIELD) {  *OUTPUT_FIELD = x; }
void out_double(double x, double *OUTPUT_FIELD) {  *OUTPUT_FIELD = x; }
void out_longlong(long long x, long long *OUTPUT_FIELD) {  *OUTPUT_FIELD = x; }
void out_ulonglong(unsigned long long x, unsigned long long *OUTPUT_FIELD) {  *OUTPUT_FIELD = x; }

/* Tests a returning a wrapped pointer and an OUTPUT_FIELD argument */
struct Foo *out_foo(int a, int *OUTPUT_FIELD, int *OUTPUT_FIELD2) {
  struct Foo *f = new struct Foo();
  f->a = a;
  *OUTPUT_FIELD = a * 2;
  *OUTPUT_FIELD2 = a * 3;
  return f;
}

struct Foo *out_foo_status(int a, int *OUTPUT_FIELD, int *OUTPUT_FIELD2) {
  struct Foo *f = new struct Foo();
  f->a = a;
  *OUTPUT_FIELD = a * 2;
  *OUTPUT_FIELD2 = a * 3;
  return f;
}

struct Foo *out_foo_void(int a, int *OUTPUT_FIELD, int *OUTPUT_FIELD2) {
  struct Foo *f = new struct Foo();
  f->a = a;
  *OUTPUT_FIELD = a * 2;
  *OUTPUT_FIELD2 = a * 3;
  return f;
}


void outr_bool(bool x, bool &OUTPUT_FIELD) {  OUTPUT_FIELD = x; }
void outr_int(int x, int &OUTPUT_FIELD) {  OUTPUT_FIELD = x; }
void outr_short(short x, short &OUTPUT_FIELD) {  OUTPUT_FIELD = x; }
void outr_long(long x, long &OUTPUT_FIELD) {  OUTPUT_FIELD = x; }
void outr_uint(unsigned int x, unsigned int &OUTPUT_FIELD) {  OUTPUT_FIELD = x; }
void outr_ushort(unsigned short x, unsigned short &OUTPUT_FIELD) {  OUTPUT_FIELD = x; }
void outr_ulong(unsigned long x, unsigned long &OUTPUT_FIELD) {  OUTPUT_FIELD = x; }
void outr_uchar(unsigned char x, unsigned char &OUTPUT_FIELD) {  OUTPUT_FIELD = x; }
void outr_schar(signed char x, signed char &OUTPUT_FIELD) {  OUTPUT_FIELD = x; }
void outr_float(float x, float &OUTPUT_FIELD) {  OUTPUT_FIELD = x; }
void outr_double(double x, double &OUTPUT_FIELD) {  OUTPUT_FIELD = x; }
void outr_longlong(long long x, long long &OUTPUT_FIELD) {  OUTPUT_FIELD = x; }
void outr_ulonglong(unsigned long long x, unsigned long long &OUTPUT_FIELD) {  OUTPUT_FIELD = x; }


void inout_bool(bool *INOUT_FIELD) {  *INOUT_FIELD = *INOUT_FIELD; }
void inout_int(int *INOUT_FIELD) {  *INOUT_FIELD = *INOUT_FIELD; }
void inout_short(short *INOUT_FIELD) {  *INOUT_FIELD = *INOUT_FIELD; }
void inout_long(long *INOUT_FIELD) {  *INOUT_FIELD = *INOUT_FIELD; }
void inout_uint(unsigned int *INOUT_FIELD) {  *INOUT_FIELD = *INOUT_FIELD; }
void inout_ushort(unsigned short *INOUT_FIELD) {  *INOUT_FIELD = *INOUT_FIELD; }
void inout_ulong(unsigned long *INOUT_FIELD) {  *INOUT_FIELD = *INOUT_FIELD; }
void inout_uchar(unsigned char *INOUT_FIELD) {  *INOUT_FIELD = *INOUT_FIELD; }
void inout_schar(signed char *INOUT_FIELD) {  *INOUT_FIELD = *INOUT_FIELD; }
void inout_float(float *INOUT_FIELD) {  *INOUT_FIELD = *INOUT_FIELD; }
void inout_double(double *INOUT_FIELD) {  *INOUT_FIELD = *INOUT_FIELD; }
void inout_longlong(long long *INOUT_FIELD) {  *INOUT_FIELD = *INOUT_FIELD; }
void inout_ulonglong(unsigned long long *INOUT_FIELD) {  *INOUT_FIELD = *INOUT_FIELD; }

void inoutr_bool(bool &INOUT_FIELD) {  INOUT_FIELD = INOUT_FIELD; }
void inoutr_int(int &INOUT_FIELD) {  INOUT_FIELD = INOUT_FIELD; }
void inoutr_short(short &INOUT_FIELD) {  INOUT_FIELD = INOUT_FIELD; }
void inoutr_long(long &INOUT_FIELD) {  INOUT_FIELD = INOUT_FIELD; }
void inoutr_uint(unsigned int &INOUT_FIELD) {  INOUT_FIELD = INOUT_FIELD; }
void inoutr_ushort(unsigned short &INOUT_FIELD) {  INOUT_FIELD = INOUT_FIELD; }
void inoutr_ulong(unsigned long &INOUT_FIELD) {  INOUT_FIELD = INOUT_FIELD; }
void inoutr_uchar(unsigned char &INOUT_FIELD) {  INOUT_FIELD = INOUT_FIELD; }
void inoutr_schar(signed char &INOUT_FIELD) {  INOUT_FIELD = INOUT_FIELD; }
void inoutr_float(float &INOUT_FIELD) {  INOUT_FIELD = INOUT_FIELD; }
void inoutr_double(double &INOUT_FIELD) {  INOUT_FIELD = INOUT_FIELD; }
void inoutr_longlong(long long &INOUT_FIELD) {  INOUT_FIELD = INOUT_FIELD; }
void inoutr_ulonglong(unsigned long long &INOUT_FIELD) {  INOUT_FIELD = INOUT_FIELD; }

void inoutr_int2(int &INOUT_FIELD, int &INOUT_FIELD2) {  INOUT_FIELD = INOUT_FIELD; INOUT_FIELD2 = INOUT_FIELD2;}
%}

// special handling
// return { value1: number, value2: number | boolean, value3: number }
//

// Generic handling for those arguments
%apply SWIGTYPE *INOUT_FIELD { int *value1 };
%apply SWIGTYPE *OUTPUT_FIELD { int *value3 };

// Specific handling for the value2 pair
%typemap(in) bool *value2b = SWIGTYPE *OUTPUT_FIELD;
%typemap(in) int *value2i = SWIGTYPE *OUTPUT_FIELD;
%typemap(argout) (bool *value2b, int *value2i) {
  Napi::Value js_out;
  if (*$1) {
    $typemap(out, bool, 1=*$1, result=js_out)
  } else {
    $typemap(out, int, 1=*$2, result=js_out)
  }
  %append_output_field("value2", js_out);
}
%typemap(tsout, merge="object") (bool *value2b, int *value2i) "value2: number | boolean";
%typemap(out) int return_multiple_values {
  if ($1 < 0)
    SWIG_Raise("Zero");
}
%typemap(ts, marge="object") int return_multiple_values "void";
%inline %{
int return_multiple_values(int *value1, bool *value2b, int *value2i, int *value3) {
  if (*value1 > 0) {
    *value2b = true;
    *value2i = 2;
  } else if (*value1 < 0) {
    *value2b = false;
    *value2i = -2;
  } else {
    return -1;
  }
  *value3 = *value1;
  *value1 = -*value1;
  return 0;
}
%}
