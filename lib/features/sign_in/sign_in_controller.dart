import 'dart:developer';
import 'package:construtech/common/constants/app_url.dart';
import 'package:construtech/common/models/pessoa.dart';
import 'package:construtech/common/utils/HelperAPI.dart';
import 'package:construtech/features/sign_in/sign_in_state.dart';
import 'package:construtech/features/sign_up/sign_up_state.dart'
    hide SignInLoadingState, SignInSuccessState, SignInErrorState;
import 'package:construtech/services/auth_services.dart';
import 'package:construtech/services/secure_storage.dart';
import 'package:flutter/material.dart';

class SignInController extends ChangeNotifier {
  SignInController();

  SignInState _state = SignInInitialState();

  SignInState get state => _state;

  void _changeState(SignInState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> SignIn({
    required BuildContext context,
    required String CPF,
    required String Senha,
  }) async {
    

    final url =
        '${AppUrl.baseUrl}${AppUrl.construtechApiPath}/GetPessoa/{CPF, Senha}?CPF=$CPF&Senha=$Senha';

    
    try {
      await HelperAPI.getData(context, url);

      _changeState(SignInSuccessState());
    } catch (e) {
      _changeState(SignInErrorState(e.toString()));
    }
  }
}
