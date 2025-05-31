import 'dart:developer';

import 'package:construtech/features/sign_up/sign_up_state.dart';
import 'package:flutter/material.dart';

class SignUpController extends ChangeNotifier {
  SignUpState _state = SignUpInitialState();

  SignUpState get state => _state;

  void _changeState(SignUpState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<bool> doSignUp() async{
    _changeState(SignUpLoadingState());
    await Future.delayed(Duration(seconds: 2));
    log("Usuário Logado");
    _changeState(SignUpSuccessState());
    return true;
  }
}
