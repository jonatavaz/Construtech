import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
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
      print('Response Body: ${response.body}');
      dynamic decodedResponse;
      try {
        if (response.body.isNotEmpty) {
          decodedResponse = json.decode(response.body);
        }
      } catch (e) {
        decodedResponse = response.body;
      }

      if (response.statusCode >= 200 && response.statusCode < 300) {
        if (decodedResponse is Map<String, dynamic> &&
            decodedResponse.containsKey('message')) {
          showAlerts(context, decodedResponse['message']);
        } else if (decodedResponse is String && decodedResponse.isNotEmpty) {
          showAlerts(context, decodedResponse);
        } else {
          showAlerts(context, 'Operação realizada com sucesso!');
        }
      } else {
        if (decodedResponse is Map<String, dynamic> &&
            decodedResponse.containsKey('message')) {
          showAlerts(context, decodedResponse['message']);
        } else if (decodedResponse is String && decodedResponse.isNotEmpty) {
          showAlerts(context, decodedResponse);
        } else {
          showAlerts(
            context,
            'Erro na requisição. Status: ${response.statusCode}',
          );
        }
      }
    } catch (e) {
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
        if (responseData['nascimento'] != null) {
          showAlerts(context, 'Bem vindo ao APP ${responseData['nome']}!');
        }
        print(responseData);
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

  static Future<List<dynamic>?> getListData(
    BuildContext context,
    String url,
  ) async {
    try {
      final response = await http
          .get(
            Uri.parse(url),
            headers: <String, String>{'Content-Type': 'application/json'},
          )
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () {
              throw TimeoutException(
                'A requisição demorou demais para responder.',
              );
            },
          );
      if (response.statusCode == 200) {
        if (response.body.isEmpty) {
          showAlerts(context, 'Nenhum dado retornado pela API.');
          return [];
        }

        try {
          final List<dynamic> responseData = json.decode(response.body);
          print(responseData);
          return responseData;
        } catch (e) {
          showAlerts(context, 'Erro ao processar dados recebidos');
          return null;
        }
      } else {
        String errorMessage =
            'Erro ao buscar dados. Código: ${response.statusCode}';
        try {
          final Map<String, dynamic> responseData = json.decode(response.body);
          errorMessage = responseData['message'] ?? errorMessage;
        } catch (_) {
          log('Erro no corpo do código ${response.statusCode}.');
        }
        showAlerts(context, errorMessage);
        return null;
      }
    } catch (e) {
      showAlerts(context, 'Ocorreu um erro inesperado: $e');
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
