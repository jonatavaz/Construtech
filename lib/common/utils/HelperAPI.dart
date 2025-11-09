import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:construtech/controllers/web_result.dart';
import 'package:http/http.dart' as http;
import 'package:construtech/controllers/web_result.dart';


class HelperAPI {
  static const Map<String, String> _headers = {
    'Content-Type': 'application/json',
  };

  static WebResult<T> _handleResponse<T>(
    http.Response response, {
    T? Function(Object? data)? fromJson,
  }) {
    try {
      if (response.statusCode == 204) {
        return WebResult.success(
          null,
          message: "Operação realizada com sucesso (sem conteúdo).",
          statusCode: response.statusCode,
        );
      }

      if (response.body.isEmpty) {
        return WebResult.failure(
          message: "Resposta vazia do servidor.",
          statusCode: response.statusCode,
        );
      }
      
      final jsonResponse = json.decode(response.body) as Map<String, dynamic>;

      if (jsonResponse.containsKey('isSuccess')) {
        return WebResult.fromMap(jsonResponse, fromJson: fromJson);
      } else {
        log("Formato de resposta inesperado: ${response.body}");
        return WebResult.failure(
          message: "Formato de resposta inesperado da API.",
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      log("Erro ao decodificar JSON: $e. Resposta: ${response.body}");
      return WebResult.failure(
        message: "Erro ao processar a resposta do servidor.",
        statusCode: response.statusCode,
      );
    }
  }
  static Future<WebResult<T>> get<T>(
    String url, {
    T? Function(Object? data)? fromJson,
  }) async {
    try {
      final response = await http
          .get(Uri.parse(url), headers: _headers)
          .timeout(const Duration(seconds: 15));

      return _handleResponse<T>(response, fromJson: fromJson);
    } on TimeoutException {
      return WebResult.failure(
          message: "Tempo de requisição esgotado.", statusCode: 408);
    } catch (e) {
      log("Erro de rede em GET: $e");
      return WebResult.failure(message: "Erro de conexão: $e", statusCode: 0);
    }
  }

  static Future<WebResult<T>> post<T>(
    String url,
    Map<String, dynamic> body, {
    T? Function(Object? data)? fromJson,
  }) async {
    try {
      final response = await http
          .post(
            Uri.parse(url),
            headers: _headers,
            body: jsonEncode(body),
          )
          .timeout(const Duration(seconds: 15));

      return _handleResponse<T>(response, fromJson: fromJson);
    } on TimeoutException {
      return WebResult.failure(
          message: "Tempo de requisição esgotado.", statusCode: 408);
    } catch (e) {
      log("Erro de rede em POST: $e");
      return WebResult.failure(message: "Erro de conexão: $e", statusCode: 0);
    }
  }

  static Future<WebResult<T>> delete<T>(
    String url, {
    T? Function(Object? data)? fromJson,
  }) async {
    try {
      final response = await http
          .delete(Uri.parse(url), headers: _headers)
          .timeout(const Duration(seconds: 15));
      return _handleResponse<T>(response, fromJson: fromJson);
    } on TimeoutException {
      return WebResult.failure(
          message: "Tempo de requisição esgotado.", statusCode: 408);
    } catch (e) {
      log("Erro de rede em DELETE: $e");
      return WebResult.failure(message: "Erro de conexão: $e", statusCode: 0);
    }
  }

}