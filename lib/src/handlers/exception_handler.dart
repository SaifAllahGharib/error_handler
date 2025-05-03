import 'dart:developer';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:error_handler/src/models/retry_config.dart';
import 'package:injectable/injectable.dart';
import '../exceptions/exceptions.dart';
import '../models/failure.dart';

@LazySingleton(as: ExceptionHandler)
class ExceptionHandlerImpl implements ExceptionHandler {
  const ExceptionHandlerImpl();

  @override
  Future<T> mapException<T>(
    Future<T> Function() fun, {
    RetryConfig? retryConfig,
  }) async {
    final config = retryConfig ?? const RetryConfig();
    int attempt = 0;
    Exception? lastException;

    while (true) {
      try {
        return await fun();
      } on DioException catch (exception, stackTrace) {
        lastException = _handleDioException(exception, stackTrace);
      } catch (e, s) {
        lastException = AppException(
          exception: e is Exception ? e : Exception(e.toString()),
          stackTrace: s,
        );
      }

      attempt++;
      if (!config.canRetry(lastException!, attempt)) {
        throw lastException!;
      }

      log('Retrying... Attempt $attempt/${config.maxRetries}');

      if (config.retryInterval > Duration.zero) {
        await Future.delayed(config.retryInterval);
      }
    }
  }

  @override
  Future<Either<Failure, T>> handle<T>(Future<T> Function() fun) async {
    try {
      return Right(await fun());
    } on AppNetworkResponseException catch (e, s) {
      return Left(_handleNetworkResponseException(e, s));
    } on AppNetworkException catch (e, s) {
      return Left(_handleNetworkException(e, s));
    } on AppException catch (e, s) {
      return Left(_handleAppException(e, s));
    } catch (e, s) {
      return Left(_handleUnknownException(e, s));
    }
  }

  @override
  Future<Either<Failure, T>> handleWithRetry<T>(
    Future<T> Function() fun, {
    RetryConfig? retryConfig,
  }) async {
    final config = retryConfig ?? const RetryConfig();
    int attempt = 0;

    while (true) {
      final result = await handle(fun);

      if (result.isRight()) {
        return result;
      }

      final failure = result.fold((f) => f, (_) => throw AssertionError());
      attempt++;

      if (!config.canRetry(failure.exception, attempt)) {
        return Left(failure.copyWith(retryAttempts: attempt));
      }

      log('Retrying... Attempt $attempt/${config.maxRetries}');

      if (config.retryInterval > Duration.zero) {
        await Future.delayed(config.retryInterval);
      }
    }
  }

  AppNetworkException _handleDioException(
    DioException exception,
    StackTrace stackTrace,
  ) {
    if (exception.response?.statusCode.toString().startsWith('5') == true) {
      return AppNetworkException(
        reason: AppNetworkExceptionReason.serverError,
        exception: exception,
        stackTrace: stackTrace,
      );
    }

    switch (exception.type) {
      case DioExceptionType.cancel:
        return AppNetworkException(
          reason: AppNetworkExceptionReason.canceled,
          exception: exception,
          stackTrace: stackTrace,
        );
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return AppNetworkException(
          reason: AppNetworkExceptionReason.timedOut,
          exception: exception,
          stackTrace: stackTrace,
        );
      case DioExceptionType.badResponse:
        final response = exception.response;
        return AppNetworkResponseException(
          exception: exception,
          statusCode: response?.statusCode,
          data: response?.data,
          stackTrace: stackTrace,
        );
      case DioExceptionType.unknown:
      default:
        if (exception.error is SocketException) {
          return AppNetworkException(
            reason: AppNetworkExceptionReason.noInternet,
            exception: exception,
            stackTrace: stackTrace,
          );
        }
        return AppNetworkException(
          reason: AppNetworkExceptionReason.unknown,
          exception: exception,
          stackTrace: stackTrace,
        );
    }
  }

  Failure _handleNetworkResponseException(
    AppNetworkResponseException e,
    StackTrace s,
  ) {
    log('Network Response Exception', error: e, stackTrace: s);
    return Failure.fromException(
      e,
      message: e.data?['message'] ?? e.reason.name,
      stackTrace: s,
      isCritical: e.statusCode?.toString().startsWith('5') ?? false,
    );
  }

  Failure _handleNetworkException(AppNetworkException e, StackTrace s) {
    log('Network Exception', error: e, stackTrace: s);
    return Failure.fromException(
      e,
      message: e.reason.name,
      stackTrace: s,
      isCritical: e.reason == AppNetworkExceptionReason.serverError,
    );
  }

  Failure _handleAppException(AppException e, StackTrace s) {
    log('Application Exception', error: e, stackTrace: s);
    return Failure.fromException(e, stackTrace: s);
  }

  Failure _handleUnknownException(Object e, StackTrace s) {
    log('Unknown Exception', error: e, stackTrace: s);
    return Failure.fromException(
      AppException(exception: Exception(e.toString()), stackTrace: s),
      stackTrace: s,
      isCritical: true,
    );
  }
}

abstract class ExceptionHandler {
  Future<T> mapException<T>(Future<T> Function() fun);
  Future<Either<Failure, T>> handle<T>(Future<T> Function() fun);
  Future<Either<Failure, T>> handleWithRetry<T>(
    Future<T> Function() fun, {
    RetryConfig? retryConfig,
  });
}
