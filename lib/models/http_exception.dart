class HttpException implements Exception {
  late String message;

  HttpException(this.message);

  @override
  String toString() {
 
    return message;
  }
}