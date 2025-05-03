import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';

@freezed
abstract class Failure with _$Failure {
  const factory Failure({
    required Exception exception,
    required String message,
    StackTrace? stackTrace,
    @Default(false) bool isCritical,
    @Default(0) int retryAttempts,
  }) = _Failure;

  factory Failure.fromException(
    Exception exception, {
    String? message,
    StackTrace? stackTrace,
    bool isCritical = false,
  }) {
    return Failure(
      exception: exception,
      message: message ?? exception.toString(),
      stackTrace: stackTrace,
      isCritical: isCritical,
    );
  }
}
