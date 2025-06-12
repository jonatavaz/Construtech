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
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

       print('Status Code: ${response.statusCode}');
       print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['success'] == true) {
          showAlerts(context, responseData['message']);
        } else {
          showAlerts(context, responseData['message']);
        }
      } else {
        final Map<String, dynamic> responseData = json.decode(response.body);
        showAlerts(context, responseData['message']);
      }
    } catch (e) {
      showAlerts(context, ('Erro: $e'));
    }
  }

  static Future<Map<String, dynamic>?> getData(
    BuildContext context,
    String url,
  ) async {
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json', 
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
     
        return responseData;
      } else if (response.statusCode == 404) {
        showAlerts(context, 'Recurso não encontrado. Código: ${response.statusCode}');
        return null; 
      } else {
        
        final Map<String, dynamic> responseData = json.decode(response.body);
        showAlerts(context, responseData['message'] ?? 'Erro ao buscar dados. Código: ${response.statusCode}');
        return null; 
      }
    } catch (e) {

      showAlerts(context, ('Erro de comunicação: $e'));
      return null; 
    }
  }


  static Future<bool> deleteData(
    BuildContext context,
    String url,
  ) async {
    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json', 
        },
      );

      if (response.statusCode == 200 || response.statusCode == 204) { 
        showAlerts(context, 'Registro excluído com sucesso!');
        return true;
      } else if (response.statusCode == 404) {
        showAlerts(context, 'Recurso para exclusão não encontrado. Código: ${response.statusCode}');
        return false;
      } else {
        final Map<String, dynamic> responseData = json.decode(response.body);
        showAlerts(context, responseData['message'] ?? 'Erro ao excluir registro. Código: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      showAlerts(context, ('Erro de comunicação: $e'));
      return false;
    }
  }
}