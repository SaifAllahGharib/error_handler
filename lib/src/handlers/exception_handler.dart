import 'dart:developer';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../exceptions/app_exception.dart';
import '../exceptions/network_exception.dart';
import '../exceptions/network_response_exception.dart';
import '../models/failure.dart';

@lazySingleton
class ExceptionHandler {
  const ExceptionHandler();

  Future<T> mapException<T>(Future<T> Function() fun) async {
    try {
      return await fun();
    } on DioException catch (exception) {
      if (exception.response?.statusCode.toString().startsWith('5') == true) {
        throw AppNetworkException(
          reason: AppNetworkExceptionReason.serverError,
          exception: exception,
        );
      }

      switch (exception.type) {
        case DioExceptionType.cancel:
          throw AppNetworkException(
            reason: AppNetworkExceptionReason.canceled,
            exception: exception,
          );
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.sendTimeout:
          throw AppNetworkException(
            reason: AppNetworkExceptionReason.timedOut,
            exception: exception,
          );
        case DioExceptionType.badResponse:
          final response = exception.response;
          throw AppNetworkResponseException(
            exception: exception,
            statusCode: response?.statusCode,
            data: response?.data,
          );
        case DioExceptionType.unknown:
        default:
          if (exception.error is SocketException) {
            throw AppNetworkException(
              reason: AppNetworkExceptionReason.noInternet,
              exception: exception,
            );
          }
          throw AppException(exception: exception);
      }
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
      throw AppException(
        exception: e is Exception ? e : Exception(e.toString()),
      );
    }
  }

  Future<Either<Failure, T>> handle<T>(Future<T> Function() fun) async {
    try {
      return Right(await fun());
    } on AppNetworkResponseException catch (e, s) {
      log(e.toString(), stackTrace: s);
      return Left(
        Failure(exception: e, message: e.data?['message'] ?? e.reason.name),
      );
    } on AppNetworkException catch (e) {
      return Left(Failure(exception: e, message: e.reason.name));
    } on AppException catch (e) {
      return Left(Failure(exception: e, message: e.toString()));
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
      return Left(
        Failure(exception: AppException(exception: e), message: e.toString()),
      );
    }
  }
}
