class ServerException implements Exception {
  final Object exception;
  ServerException(this.exception);
  @override
  String toString() {
    return "An unexpected error occured";
  }
}
