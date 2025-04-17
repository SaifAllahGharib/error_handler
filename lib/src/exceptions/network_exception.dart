import 'app_exception.dart';

enum AppNetworkExceptionReason {
  canceled,
  timedOut,
  responseError,
  serverError,
  noInternet,
}

class AppNetworkException<OriginalException extends Exception>
    extends AppException<OriginalException> {
  final AppNetworkExceptionReason reason;

  AppNetworkException({required this.reason, required super.exception});
}
