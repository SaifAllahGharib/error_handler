class AppException<OriginalException> implements Exception {
  final OriginalException exception;

  AppException({required this.exception});

  @override
  String toString() => exception.toString();
}
