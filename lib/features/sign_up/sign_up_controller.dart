import 'dart:developer';

import 'package:construtech/features/sign_up/sign_up_state.dart';
import 'package:construtech/services/auth_services.dart';
import 'package:flutter/material.dart';

class SignUpController extends ChangeNotifier {
  final AuthServices _services;
  SignUpController(this._services);

  SignUpState _state = SignUpInitialState();

  SignUpState get state => _state;

  void _changeState(SignUpState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> SignUp({
    required String Nome,
    required String Email,
    required String Senha,
  }) async {
    _changeState(SignInLoadingState());
    await _services.signUp(Nome: Nome, Email: Email, Senha: Senha);
    try {
      _changeState(SignInSuccessState());
    } catch (e) {
      _changeState(SignInErrorState(e.toString()));
    }
  }
}
