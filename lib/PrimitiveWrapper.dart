class PrimitiveWrapper {
  var value;
  PrimitiveWrapper(this.value);

  setValue(var newValue){
    this.value = newValue;
  }

  @override
  String toString() {
    return this.value.toString();
  }
}