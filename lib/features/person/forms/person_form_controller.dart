import 'dart:developer';

import 'package:construtech/common/constants/app_url.dart';
import 'package:construtech/common/utils/HelperAPI.dart';
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
    required BuildContext context,
    required String Historico,
    required String Avaliacao,
    required String Nome,
    required String CPF,
    required String Nascimento,
    required String Telefone,
    required String Email,
    required String Senha,
  }) async {
    
    final url = '${AppUrl.baseUrl}${AppUrl.construtechApiPath}/InsertFornecedor';
    print('URL final da API: $url');

    final Map<String, dynamic> body = {
      "Historico": Historico,
      "Avaliacao": Avaliacao,
      "Nome": Nome, "CPF": CPF, "Nascimento": Nascimento,
      "Senha": Senha,
      "Telefone": Telefone, "Email": Email,
    };
    print('body: $body');

    try {
      await HelperAPI.postData(context, url, body);
      _changeState(PersonFormSuccessState());
    } catch (e) {
      _changeState(PersonFormErrorState(e.toString()));
    }
  }
}