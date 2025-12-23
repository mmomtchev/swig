%module napi_li_typemaps

// Test the (partially implemented) support for retuning arguments as named fields in an object

// INPUT
%typemap(in) SWIGTYPE *INPUT, SWIGTYPE &INPUT {
  $*1_ltype val;
  $typemap(in, $*1_type, 1=val);
  $1 = &val;
}

// OUTPUT_FIELD
%typemap(in, numinputs=0) SWIGTYPE *OUTPUT_FIELD ($*1_ltype val), SWIGTYPE &OUTPUT_FIELD ($*1_ltype val) {
  $1 = &val;
}
%typemap(argout) SWIGTYPE *OUTPUT_FIELD, SWIGTYPE &OUTPUT_FIELD {
  Napi::Value js_out;
  $typemap(out, $*1_ltype, 1=val$argnum, result=js_out)
  $result = SWIG_NAPI_AppendOutputField(env, $result, "$1_name", js_out);
}
%typemap(tsout, merge="object") SWIGTYPE *OUTPUT_FIELD, SWIGTYPE &OUTPUT_FIELD "$1_name: $typemap(ts, $*1_ltype)";

%apply SWIGTYPE *OUTPUT_FIELD { int *OUTPUT_FIELD2 };
%apply int &INOUT { int &INOUT2 };

%newobject out_foo;
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
  struct Foo *f2 = new struct Foo();
  f2->a = a;
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

/*
void inout_bool(bool *INOUT) {  *INOUT = *INOUT; }
void inout_int(int *INOUT) {  *INOUT = *INOUT; }
void inout_short(short *INOUT) {  *INOUT = *INOUT; }
void inout_long(long *INOUT) {  *INOUT = *INOUT; }
void inout_uint(unsigned int *INOUT) {  *INOUT = *INOUT; }
void inout_ushort(unsigned short *INOUT) {  *INOUT = *INOUT; }
void inout_ulong(unsigned long *INOUT) {  *INOUT = *INOUT; }
void inout_uchar(unsigned char *INOUT) {  *INOUT = *INOUT; }
void inout_schar(signed char *INOUT) {  *INOUT = *INOUT; }
void inout_float(float *INOUT) {  *INOUT = *INOUT; }
void inout_double(double *INOUT) {  *INOUT = *INOUT; }
void inout_longlong(long long *INOUT) {  *INOUT = *INOUT; }
void inout_ulonglong(unsigned long long *INOUT) {  *INOUT = *INOUT; }

void inoutr_bool(bool &INOUT) {  INOUT = INOUT; }
void inoutr_int(int &INOUT) {  INOUT = INOUT; }
void inoutr_short(short &INOUT) {  INOUT = INOUT; }
void inoutr_long(long &INOUT) {  INOUT = INOUT; }
void inoutr_uint(unsigned int &INOUT) {  INOUT = INOUT; }
void inoutr_ushort(unsigned short &INOUT) {  INOUT = INOUT; }
void inoutr_ulong(unsigned long &INOUT) {  INOUT = INOUT; }
void inoutr_uchar(unsigned char &INOUT) {  INOUT = INOUT; }
void inoutr_schar(signed char &INOUT) {  INOUT = INOUT; }
void inoutr_float(float &INOUT) {  INOUT = INOUT; }
void inoutr_double(double &INOUT) {  INOUT = INOUT; }
void inoutr_longlong(long long &INOUT) {  INOUT = INOUT; }
void inoutr_ulonglong(unsigned long long &INOUT) {  INOUT = INOUT; }

void inoutr_int2(int &INOUT, int &INOUT2) {  INOUT = INOUT; INOUT2 = INOUT2;}
*/
%}




