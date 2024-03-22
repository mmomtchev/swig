%module napi_li_std_shared_ptr

// This test is specific to shared pointers in Node-API
// In Node-API, an std::shared_ptr behaves an identical way as 
// its base object

%include <std_shared_ptr.i>
%shared_ptr(Integer);

%inline %{
class Integer {
  int value;
public:
  Integer(): value() {}
  Integer(int v): value(v) {}
  int get() const { return value; }
  void set(int v) { value = v; }
};

int ConsumePlainObject(Integer v) {
  return v.get();
}
int ConsumeConstReference(const Integer &v) {
  return v.get();
}
int ConsumePointer(Integer *v) {
  return v->get();
}
std::shared_ptr<Integer> ProduceSharedPointer(int v) {
  return std::shared_ptr<Integer>(new Integer(v));
}
int ConsumeSharedPointer(std::shared_ptr<Integer> v) {
  return v->get();
}
int ConsumeSharedPointerReference(std::shared_ptr<Integer> &v) {
  return v->get();
}

%}
