import 'network_exception.dart';

class AppNetworkResponseException<OriginalException extends Exception, T>
    extends AppNetworkException<OriginalException> {
  final int? statusCode;
  final T? data;

  AppNetworkResponseException({
    required super.exception,
    super.reason = AppNetworkExceptionReason.responseError,
    this.statusCode,
    this.data,
  });

  bool get hasData => data != null;
}
