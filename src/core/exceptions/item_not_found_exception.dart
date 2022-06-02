class ItemNotFoundException implements Exception {
  ItemNotFoundException(this.message);
  final String message;

  @override
  String toString() {
    return "item not found \n $message";
  }
}
