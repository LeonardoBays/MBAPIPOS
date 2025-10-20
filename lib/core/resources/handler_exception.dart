import 'package:dio/dio.dart';

import '../../data/datasources/remote/http_client.dart';


abstract class HandlerException implements Exception {
  final String message;
  final String? optionalMessage;
  final Exception? exception;
  final double? errorCode;

  HandlerException(
    this.message,
    this.optionalMessage,
    this.exception, {
    this.errorCode,
  });

  String? get aditionalMessage {
    String? message = optionalMessage;

    if (exception != null) {
      if (message != null) {
        message += '\n\n${exception.toString()}';
      } else {
        message = exception.toString();
      }
    }

    return message;
  }

  @override
  String toString() {
    return '$runtimeType{'
        'message: $message, '
        'optionalMessage: $optionalMessage, '
        'errorCode: $errorCode, '
        'exception: $exception'
        '}';
  }
}

class SimpleException extends HandlerException {
  SimpleException(
    String message, {
    String? optionalMessage,
    Exception? exception,
    super.errorCode,
  }) : super(message, optionalMessage, exception);
}

class UnauthenticatedException {
  UnauthenticatedException({this.response});

  final Response? response;

  static UnauthenticatedException fromHttpException(HttpRequestException e) {
    return UnauthenticatedException(response: e.response);
  }
}
