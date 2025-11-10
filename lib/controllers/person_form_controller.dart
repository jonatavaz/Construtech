import 'dart:developer';

import 'package:construtech/common/constants/app_url.dart';
import 'package:construtech/common/utils/HelperAPI.dart';
import 'package:construtech/controllers/web_result.dart';
import 'package:construtech/features/person/forms/person_form_state.dart';
import 'package:construtech/features/sign_up/sign_up_state.dart';
import 'package:construtech/services/auth_services.dart';
import 'package:construtech/services/secure_storage.dart';
import 'package:flutter/material.dart';

class PersonFormController extends ChangeNotifier {
  PersonFormController();

  PersonFormState _state = PersonFormInitialState();

  PersonFormState get state => _state;

  void _changeState(PersonFormState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> CadastroFornecedor({
    required BuildContext context, // Mantido, pois sua página o envia
    required String Historico,
    required String Avaliacao,
    required String Nome,
    required String CPF,
    required String Nascimento,
    required String Telefone,
    required String Email,
    required String Senha,
  }) async {
    _changeState(PersonFormLoadingState());

    final url = '${AppUrl.baseUrl}${AppUrl.construtechApiPath}/Fornecedor/inserirFornecedor';
    log('URL final da API: $url');

    final Map<String, dynamic> body = {
      "historico": Historico,
      "avaliacao": Avaliacao,
      "nome": Nome,
      "cpf": CPF,
      "nascimento": Nascimento,
      "senha": Senha,
      "telefone": Telefone,
      "email": Email,
    };
    log('Enviando body: $body');

    try {
      final WebResult<int> result = await HelperAPI.post<int>(url, body);

      if (result.isSuccess) {
        _changeState(PersonFormSuccessState());
      } else {
        _changeState(PersonFormErrorState(result.message ?? "Erro ao salvar o fornecedor."));
      }
    } catch (e) {
      log("Erro inesperado no CadastroFornecedor: $e");
      _changeState(PersonFormErrorState("Ocorreu um erro inesperado: $e"));
    }
  }
}