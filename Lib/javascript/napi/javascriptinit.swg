%insert(header) %{
#include <assert.h>
%}

%insert(init) %{

void noopFinalizer(Napi::Env, swig_module_info *) {}

SWIGRUNTIME void
SWIG_NAPI_SetModule(Napi::Env env, swig_module_info *swig_module) {
  // If we don't pass a finalizer, napi will take the liberty
  // to free the structure
  env.SetInstanceData<swig_module_info, noopFinalizer>(swig_module);
}

SWIGRUNTIME swig_module_info *
SWIG_NAPI_GetModule(Napi::Env env) {
  return env.GetInstanceData<swig_module_info>();
}

#define SWIG_GetModule(clientdata)                SWIG_NAPI_GetModule(clientdata)
#define SWIG_SetModule(clientdata, pointer)       SWIG_NAPI_SetModule(clientdata, pointer)
#define SWIG_INIT_CLIENT_DATA_TYPE                Napi::Env

%}

%insert(init) "swiginit.swg"

// Open the initializer function definition here

%fragment ("js_initializer_define", "templates") %{
#define SWIGNAPI_INIT $jsname_initialize
%}

%insert(init) %{
%}


/* -----------------------------------------------------------------------------
 * js_initializer:  template for the module initializer function
 *   - $jsname:                   module name
 *   - $jsnapinspaces:              part with code creating namespace objects
 *   - $jsnapiclasstemplates:       part with code creating class templates
 *   - $jsnapiwrappers:             part with code that registers wrapper functions
 *   - $jsnapiinheritance:          part with inherit statements
 *   - $jsnapiclassinstances:       part with code creating class objects
 *   - $jsnapistaticwrappers:       part with code adding static functions to class objects
 *   - $jsnapiregisterclasses:      part with code that registers class objects in namespaces
 *   - $jsnapiregisternspaces:      part with code that registers namespaces in parent namespaces
 * ----------------------------------------------------------------------------- */
%fragment("js_initializer", "templates")
%{
Napi::Object Init(Napi::Env env, Napi::Object exports) {
  SWIG_InitializeModule(env);

  /* create objects for namespaces */
  $jsnapinspaces

  /* create class templates */
  $jsnapiclasstemplates

  /* setup inheritances */
  $jsnapiinheritance

  /* class instances */
  $jsnapiclassinstances

  /* register classes */
  $jsnapiregisterclasses

  /* create and register namespace objects */
  $jsnapiregisternspaces

  return exports;
}

NODE_API_MODULE($jsname, Init)
%}