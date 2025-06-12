import 'dart:convert';
import 'package:construtech/common/utils/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HelperAPI {
  static Future<void> postData(
    BuildContext context,
    String url,
    Map<String, dynamic> body,
  ) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      print('Status Code: ${response.statusCode}');
      print(
        'Response Body: ${response.body}',
      ); // Veja o que a API está retornando

      // --- CORREÇÃO AQUI ---
      dynamic decodedResponse;
      try {
        // Tenta decodificar o corpo como JSON
        if (response.body.isNotEmpty) {
          decodedResponse = json.decode(response.body);
        }
      } catch (e) {
        // Se a decodificação JSON falhar, significa que o corpo não é JSON.
        // Neste caso, tratamos o corpo como uma string simples.
        decodedResponse = response.body;
      }

      if (response.statusCode >= 200 && response.statusCode < 300) {
        // Sucesso (2xx)
        if (decodedResponse is Map<String, dynamic> &&
            decodedResponse.containsKey('message')) {
          // Se a resposta é um mapa JSON e tem a chave 'message'
          showAlerts(context, decodedResponse['message']);
        } else if (decodedResponse is String && decodedResponse.isNotEmpty) {
          // Se a resposta é uma string simples de sucesso
          showAlerts(context, decodedResponse);
        } else {
          // Sucesso, mas sem mensagem explícita ou corpo vazio
          showAlerts(context, 'Operação realizada com sucesso!');
        }
      } else {
        // Erro (4xx, 5xx)
        if (decodedResponse is Map<String, dynamic> &&
            decodedResponse.containsKey('message')) {
          // Se a resposta de erro é um mapa JSON e tem a chave 'message'
          showAlerts(context, decodedResponse['message']);
        } else if (decodedResponse is String && decodedResponse.isNotEmpty) {
          // Se a resposta de erro é uma string simples
          showAlerts(context, decodedResponse);
        } else {
          // Erro, mas sem mensagem explícita ou corpo vazio
          showAlerts(
            context,
            'Erro na requisição. Status: ${response.statusCode}',
          );
        }
      }
    } catch (e) {
      // Este catch lida com erros de rede (sem internet, URL inválida, etc.)
      showAlerts(context, ('Erro de comunicação: $e'));
    }
  }

  static Future<Map<String, dynamic>?> getData(
    BuildContext context,
    String url,
  ) async {
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: <String, String>{'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        return responseData;
      } else if (response.statusCode == 404) {
        showAlerts(
          context,
          'Recurso não encontrado. Código: ${response.statusCode}',
        );
        return null;
      } else {
        final Map<String, dynamic> responseData = json.decode(response.body);
        showAlerts(
          context,
          responseData['message'] ??
              'Erro ao buscar dados. Código: ${response.statusCode}',
        );
        return null;
      }
    } catch (e) {
      showAlerts(context, ('Erro de comunicação: $e'));
      return null;
    }
  }

  static Future<bool> deleteData(BuildContext context, String url) async {
    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: <String, String>{'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        showAlerts(context, 'Registro excluído com sucesso!');
        return true;
      } else if (response.statusCode == 404) {
        showAlerts(
          context,
          'Recurso para exclusão não encontrado. Código: ${response.statusCode}',
        );
        return false;
      } else {
        final Map<String, dynamic> responseData = json.decode(response.body);
        showAlerts(
          context,
          responseData['message'] ??
              'Erro ao excluir registro. Código: ${response.statusCode}',
        );
        return false;
      }
    } catch (e) {
      showAlerts(context, ('Erro de comunicação: $e'));
      return false;
    }
  }
}
