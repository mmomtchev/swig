/* -----------------------------------------------------------------------------
 * javascript.swg
 *
 * Javascript typemaps
 * ----------------------------------------------------------------------------- */

#define %append_output_field(name, obj)               $result = SWIG_AppendOutputField($result, name, obj) 

%include <typemaps/swigmacros.swg>

%include <javascripttypemaps.swg>

%include <javascriptruntime.swg>

%include <javascript/javascriptkw.swg>

%include <javascriptcode.swg>

%include <javascriptinit.swg>

%include <javascript/typescripttypemaps.swg>

%include <javascript/typescriptcode.swg>
