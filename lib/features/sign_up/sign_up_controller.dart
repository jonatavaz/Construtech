import 'dart:developer';

import 'package:construtech/common/constants/app_url.dart';
import 'package:construtech/common/utils/HelperAPI.dart';
import 'package:construtech/features/sign_up/sign_up_state.dart';
import 'package:construtech/services/auth_services.dart';
import 'package:construtech/services/secure_storage.dart';
import 'package:flutter/material.dart';

class SignUpController extends ChangeNotifier {
  //final AuthServices _services;
  SignUpController();

  SignUpState _state = SignUpInitialState();

  SignUpState get state => _state;

  void _changeState(SignUpState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> SignUp({
    required BuildContext context,
    required String Nome,
    required String CPF,
    required String Nascimento,
    required String Telefone,
    required String Email,
    required String Senha,
  }) async {
    
    final url = '${AppUrl.baseUrl}${AppUrl.construtechApiPath}/InsertPessoa';
    print('URL final da API: $url');

    final Map<String, dynamic> body = {
      "Nome": Nome,
      "CPF": CPF,
      "Nascimento": Nascimento,
      "Usuario": {"Senha": Senha},
      "Contato": {"Telefone1": Telefone, "Email": Email},
    };
    print('body: $body');

    try {
      await HelperAPI.postData(context, url, body);
      _changeState(SignInSuccessState());
    } catch (e) {
      _changeState(SignInErrorState(e.toString()));
    }
  }
}
