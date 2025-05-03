class AppException<OriginalException extends Exception> implements Exception {
  final OriginalException exception;
  final StackTrace? stackTrace;

  AppException({required this.exception, this.stackTrace});

  @override
  String toString() => 'AppException: ${exception.toString()}';
}
