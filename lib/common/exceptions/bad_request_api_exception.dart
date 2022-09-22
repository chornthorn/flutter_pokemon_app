class BadRequestApiException implements Exception {
  BadRequestApiException(this.message);
  final String message;
}
