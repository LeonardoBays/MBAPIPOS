import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../models/api_error_model.dart';

abstract class HttpClient {
  final SupabaseClient client;

  const HttpClient(this.client);
}

class HttpRequestException implements Exception {
  /// [infoMessage] Mensagem com informações adicionais sobre o erro
  /// [titleMessage] Titulo do erro, intuitivo para o usuário
  /// [Response] Erros que aconteceram na api e retornaram pelo cliente
  HttpRequestException({
    this.response,
    required String titleMessage,
    required String infoMessage,
  }) {
    _infoMessage = infoMessage;
    _titleMessage = titleMessage;
  }

  late final String _infoMessage;
  late final String _titleMessage;
  late final Response? response;

  String? get _apiErrorMessage {
    if (response != null && response?.data != null && response is String) {
      try {
        return ApiErrorModel.fromJson(response?.data).serverError;
      } catch (e) {
        if (kDebugMode) {
          print(
            '=====/=====/=====/=====/=====/=====/=====/=====/=====/=====/====='
            'Falha ao converter mensagem de erro para model: TITLE'
            '\n$e\n'
            '=====/=====/=====/=====/=====/=====/=====/=====/=====/=====/=====',
          );
          return 'Falha na serialização do objeto retornado pelo servidor.\n$e';
        }
      }
    }
    return null;
  }

  String? get _apiErrorTitle {
    if (response != null && response?.data != null) {
      try {
        return ApiErrorModel.fromJson(response?.data).msgErro;
      } catch (e) {
        if (kDebugMode) {
          print(
            '=====/=====/=====/=====/=====/=====/=====/=====/=====/=====/====='
            'Falha ao converter mensagem de erro para model: MESSAGE'
            '\n$e\n'
            '=====/=====/=====/=====/=====/=====/=====/=====/=====/=====/=====',
          );
        }
      }
    }
    return null;
  }

  String get message {
    if (_apiErrorMessage != null) {
      return _apiErrorMessage!;
    }

    return _infoMessage;
  }

  String get title {
    if (_apiErrorTitle != null) {
      return _apiErrorTitle!;
    }

    return _titleMessage;
  }

  @override
  String toString() {
    return 'HttpRequestException{'
        '_infoMessage: $_infoMessage, '
        '_titleMessage: $_titleMessage, '
        'response: $response'
        '}';
  }
}
