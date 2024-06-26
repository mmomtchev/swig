/* File : example.i */
%module example

// placeholder() used to help SWIG generate "SWIG_From_int" call
%{
    int placeholder();
%}
int placeholder() { return 0; }

// actual demo code
%wrapper
%{
#if defined(SWIG_V8_VERSION) /* Engine: Node || V8 */
    
    SwigV8ReturnValue JavaScript_do_work(const SwigV8Arguments &args) {
        SWIGV8_HANDLESCOPE();
        const int MY_MAGIC_NUMBER = 5;
        SWIGV8_VALUE jsresult =
            SWIG_From_int(static_cast< int >(MY_MAGIC_NUMBER));
        if (args.Length() != 0)
            SWIG_exception_fail(SWIG_ERROR, "Illegal number of arguments.");
        SWIGV8_RETURN(jsresult);
    fail:
        SWIGV8_RETURN(SWIGV8_UNDEFINED());
    }

#elif defined(NAPI_VERSION) /* Engine: NAPI */

    Napi::Value JavaScript_do_work(const Napi::CallbackInfo &args) {
        Napi::Env env = args.Env();
        Napi::EscapableHandleScope scope(env);
        const int MY_MAGIC_NUMBER = 5;
        Napi::Value jsresult =
            SWIG_From_int(env, static_cast< int >(MY_MAGIC_NUMBER));
        if (args.Length() != 0)
            SWIG_exception_fail(SWIG_ERROR, "Illegal number of arguments.");
        return scope.Escape(jsresult);
    fail:
        return Napi::Value();
    }

#else /* Engine: JavaScriptCore */

    JSValueRef JavaScript_do_work(JSContextRef context,
        JSObjectRef function, JSObjectRef thisObject, size_t argc,
        const JSValueRef argv[], JSValueRef* exception) {
        const int MY_MAGIC_NUMBER = 5;
        JSValueRef jsresult =
            SWIG_From_int SWIG_JSC_FROM_CALL_ARGS(
                static_cast< int >(MY_MAGIC_NUMBER));
        if (argc != 0)
            SWIG_exception_fail(SWIG_ERROR, "Illegal number of arguments.");
        return jsresult;
    fail:
        return JSValueMakeUndefined(context);
    }

#endif
%}


%native(magicNumber) void JavaScript_do_work();
