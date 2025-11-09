import 'dart:developer';
import 'package:construtech/common/constants/app_url.dart';
import 'package:construtech/common/utils/ui_utils.dart';
import 'package:construtech/controllers/web_result.dart';
import 'package:construtech/models/pessoa.dart';
import 'package:construtech/common/utils/HelperAPI.dart';
import 'package:construtech/screens/sign_in_state.dart';
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
    _changeState(SignInLoadingState());

    final url =
    '${AppUrl.baseUrl}${AppUrl.construtechApiPath}/Pessoa/getPessoa?CPF=$CPF&Senha=$Senha';

    try {
      final WebResult<Pessoa> result = await HelperAPI.get<Pessoa>(
        url,
        fromJson: (data) => Pessoa.fromJson(data as Map<String, dynamic>),
      );

      if (result.isSuccess && result.data != null) {
        
        final pessoa = result.data!;

        _changeState(SignInSuccessState());

        showAlerts(context, 'Bem vindo ao APP ${pessoa.Nome}!');

      } else {
        final errorMessage = result.message ?? "CPF ou senha inválidos.";
        _changeState(SignInErrorState(errorMessage));
        
        showAlerts(context, errorMessage);
      }
    } catch (e) {
      log('Erro inesperado no SignInController: $e');
      final errorMessage = "Ocorreu um erro inesperado. Tente novamente.";
      _changeState(SignInErrorState(errorMessage));
      showAlerts(context, errorMessage);
    }
  }
}
