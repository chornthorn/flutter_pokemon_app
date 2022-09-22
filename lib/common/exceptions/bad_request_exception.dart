class BadRequestException implements Exception {
  BadRequestException([this.message = 'Bad Request']);

  final String message;
}
