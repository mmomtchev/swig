#include <cassert>
#include <chrono>
#include <napi.h>
#include <thread>

using namespace Napi;

using Context = Reference<Value>;
using DataType = void;
void CallJs(Napi::Env env, Function callback, Context *context, DataType *data);
using TSFN = TypedThreadSafeFunction<Context, DataType, CallJs>;
using FinalizerDataType = void;

std::thread nativeThread;
TSFN tsfn;

Value Start(const CallbackInfo &info) {
  Napi::Env env = info.Env();

  if (info.Length() < 1) {
    throw TypeError::New(env, "Expected an argument");
  } else if (!info[0].IsFunction()) {
    throw TypeError::New(env, "Expected first arg to be function");
  }

  // Create a new context set to the receiver (ie, `this`) of the function call
  Context *context = new Reference<Value>(Persistent(info.This()));

  // Create a ThreadSafeFunction
  tsfn = TSFN::New(
      env,
      info[0].As<Function>(), // JavaScript function called asynchronously
      "Resource Name",        // Name
      0,                      // Unlimited queue
      1,                      // Only one thread will use this initially
      context,
      [](Napi::Env, FinalizerDataType *,
         Context *ctx) { // Finalizer used to clean threads up
        nativeThread.join();
        delete ctx;
      });

  // Create a native thread
  nativeThread = std::thread([] {
    // Perform a blocking call
    napi_status status = tsfn.BlockingCall();
    if (status != napi_ok) {
      // Handle error
      printf("Failed\n");
    }

    std::this_thread::sleep_for(std::chrono::seconds(1));

    // Release the thread-safe function
    tsfn.Release();
  });

  return env.Undefined();
}

// Transform native data into JS data, passing it to the provided
// `callback` -- the TSFN's JavaScript function.
void CallJs(Napi::Env env, Function callback, Context *context,
            DataType *data) {
  Napi::Value r;
  // Is the JavaScript environment still available to call into, eg. the TSFN is
  // not aborted
  if (env != nullptr) {
    // On Node-API 5+, the `callback` parameter is optional; however, this
    // example does ensure a callback is provided.
    if (callback != nullptr) {
      r = callback.Call(context->Value(), 0, nullptr);
    }
  }
  if (r.IsPromise()) {
    printf("Resolving Promise from C++\n");
    napi_value js_catch = Function::New(env, [](const CallbackInfo &info) {
      printf("Caught!");
      return String::New(info.Env(), "caught");
    });
    napi_value js_then = Function::New(env, [](const CallbackInfo &info) {
      printf("Resolved!");
      return String::New(info.Env(), "resolved");
    });
    assert(r.IsObject());
    assert(r.ToObject().Get("catch").IsFunction());
    r.ToObject().Get("catch").As<Function>().Call(r, 1, &js_catch);
    r.ToObject().Get("then").As<Function>().Call(r, 1, &js_then);
    printf("Done\n");
  } else {
    printf("Didn't get a Promise\n");
  }
}

Napi::Object Init(Napi::Env env, Object exports) {
  exports.Set("start", Function::New(env, Start));
  return exports;
}

NODE_API_MODULE(clock, Init)
