/*
char_strings.i with support for code-splitting for
testing the strings.swg typemaps
*/

%module char_strings_split

%warnfilter(SWIGWARN_TYPEMAP_VARIN_UNDEF) global_char_array1;  // Unable to set variable of type char[]

%insert(header) %{
#include <stdio.h>
#include <string.h>

#define OTHERLAND_MSG "Little message from the safe world."
#define CPLUSPLUS_MSG "A message from the deep dark world of C++, where anything is possible."
extern char *global_str;
extern const int UINT_DIGITS; // max unsigned int is 4294967295
bool check(const char *const str, unsigned int number);
%}

%insert(wrapper) %{
char *global_str = NULL;
const int UINT_DIGITS = 10; // max unsigned int is 4294967295

bool check(const char *const str, unsigned int number) {
  static char expected[256];
  sprintf(expected, "%s%d", OTHERLAND_MSG, number);
  bool matches = (strcmp(str, expected) == 0);
  if (!matches) printf("Failed: [%s][%s]\n", str, expected);
  return matches;
}

%}

%immutable global_const_char;

%inline %{
// get functions
char *GetCharHeapString();
const char *GetConstCharProgramCodeString();
void DeleteCharHeapString();
char *GetCharStaticString();
char *GetCharStaticStringFixed();
const char *GetConstCharStaticStringFixed();

// set functions
bool SetCharHeapString(char *str, unsigned int number);
bool SetCharStaticString(char *str, unsigned int number);
bool SetCharArrayStaticString(char str[], unsigned int number);
bool SetConstCharHeapString(const char *str, unsigned int number);
bool SetConstCharStaticString(const char *str, unsigned int number);
bool SetConstCharArrayStaticString(const char str[], unsigned int number);
bool SetCharConstStaticString(char *const str, unsigned int number);
bool SetConstCharConstStaticString(const char *const str, unsigned int number);

// get set function
char *CharPingPong(char *str);
char *CharArrayPingPong(char abcstr[]);
char *CharArrayDimsPingPong(char abcstr[16]);

// variables
extern char *global_char;
extern char global_char_array1[];
extern char global_char_array2[sizeof(CPLUSPLUS_MSG)+1];

extern const char *global_const_char;
extern const char global_const_char_array1[];
extern const char global_const_char_array2[sizeof(CPLUSPLUS_MSG)+1];
%}

%insert(wrapper) %{
// get functions
char *GetCharHeapString() {
  global_str = new char[sizeof(CPLUSPLUS_MSG)+1];
  strcpy(global_str, CPLUSPLUS_MSG);
  return global_str;
}

const char *GetConstCharProgramCodeString() {
  return CPLUSPLUS_MSG;
}

void DeleteCharHeapString() {
  delete[] global_str;
  global_str = NULL;
}

char *GetCharStaticString() {
  static char str[sizeof(CPLUSPLUS_MSG)+1];
  strcpy(str, CPLUSPLUS_MSG);
  return str;
}

char *GetCharStaticStringFixed() {
  static char str[] = CPLUSPLUS_MSG;
  return str;
}

const char *GetConstCharStaticStringFixed() {
  static const char str[] = CPLUSPLUS_MSG;
  return str;
}

// set functions
bool SetCharHeapString(char *str, unsigned int number) {
  delete[] global_str;
  global_str = new char[strlen(str)+UINT_DIGITS+1];
  strcpy(global_str, str);
  return check(global_str, number);
}

bool SetCharStaticString(char *str, unsigned int number) {
  static char static_str[] = CPLUSPLUS_MSG;
  strcpy(static_str, str);
  return check(static_str, number);
}

bool SetCharArrayStaticString(char str[], unsigned int number) {
  static char static_str[] = CPLUSPLUS_MSG;
  strcpy(static_str, str);
  return check(static_str, number);
}

bool SetConstCharHeapString(const char *str, unsigned int number) {
  delete[] global_str;
  global_str = new char[strlen(str)+UINT_DIGITS+1];
  strcpy(global_str, str);
  return check(global_str, number);
}

bool SetConstCharStaticString(const char *str, unsigned int number) {
  static char static_str[] = CPLUSPLUS_MSG;
  strcpy(static_str, str);
  return check(static_str, number);
}

bool SetConstCharArrayStaticString(const char str[], unsigned int number) {
  static char static_str[] = CPLUSPLUS_MSG;
  strcpy(static_str, str);
  return check(static_str, number);
}

bool SetCharConstStaticString(char *const str, unsigned int number) {
  static char static_str[] = CPLUSPLUS_MSG;
  strcpy(static_str, str);
  return check(static_str, number);
}

bool SetConstCharConstStaticString(const char *const str, unsigned int number) {
  static char static_str[] = CPLUSPLUS_MSG;
  strcpy(static_str, str);
  return check(static_str, number);
}

// get set function
char *CharPingPong(char *str) {
  return str;
}
char *CharArrayPingPong(char abcstr[]) {
  return abcstr;
}
char *CharArrayDimsPingPong(char abcstr[16]) {
  return abcstr;
}

// variables
char *global_char = NULL;
char global_char_array1[] = CPLUSPLUS_MSG;
char global_char_array2[sizeof(CPLUSPLUS_MSG)+1] = CPLUSPLUS_MSG;

const char *global_const_char = CPLUSPLUS_MSG;
const char global_const_char_array1[] = CPLUSPLUS_MSG;
const char global_const_char_array2[sizeof(CPLUSPLUS_MSG)+1] = CPLUSPLUS_MSG;
%}


%typemap(newfree) char *GetNewCharString() { /* hello */ delete[] $1; }
%newobject GetNewCharString();

%inline {
  char *GetNewCharString();
}

%insert(wrapper) %{
  char *GetNewCharString() {
    char *nstr = new char[sizeof(CPLUSPLUS_MSG)+1];
    strcpy(nstr, CPLUSPLUS_MSG);
    return nstr;
  }
%}

%inline {
  struct Formatpos;
  struct OBFormat;

  int GetNextFormat(Formatpos& itr, const  char*& str,OBFormat*& pFormat);
}

%insert(wrapper) %{
  int GetNextFormat(Formatpos& itr, const  char*& str,OBFormat*& pFormat) {
    return 0;
  }
%}


%inline %{
// char *& tests
char *&GetCharPointerRef();
bool SetCharPointerRef(char *&str, unsigned int number);
const char *&GetConstCharPointerRef();
bool SetConstCharPointerRef(const char *&str, unsigned int number);
%}

%insert(wrapper) %{
// char *& tests
char *&GetCharPointerRef() {
  static char str[] = CPLUSPLUS_MSG;
  static char *ptr = str;
  return ptr;
}

bool SetCharPointerRef(char *&str, unsigned int number) {
  static char static_str[] = CPLUSPLUS_MSG;
  strcpy(static_str, str);
  return check(static_str, number);
}

const char *&GetConstCharPointerRef() {
  static const char str[] = CPLUSPLUS_MSG;
  static const char *ptr = str;
  return ptr;
}

bool SetConstCharPointerRef(const char *&str, unsigned int number) {
  static char static_str[] = CPLUSPLUS_MSG;
  strcpy(static_str, str);
  return check(static_str, number);
}
%}

