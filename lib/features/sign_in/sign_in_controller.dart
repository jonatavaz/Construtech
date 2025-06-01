import 'dart:developer';
import 'package:construtech/features/sign_in/sign_in_state.dart';
import 'package:construtech/features/sign_up/sign_up_state.dart' hide SignInLoadingState, SignInSuccessState, SignInErrorState;
import 'package:construtech/services/auth_services.dart';
import 'package:flutter/material.dart';

class SignInController extends ChangeNotifier{
  final AuthServices _services;
  SignInController(this._services);

  SignInState _state = SignInInitialState();


  SignInState get state => _state;

  void _changeState(SignInState newState){
    _state = newState;
    notifyListeners();
  }

  Future<void> SignIn({
    required String Email,
    required String Senha,
  }) async {
    _changeState(SignInLoadingState());
    await _services.signIn(Email: Email, Senha: Senha);
    try {
      _changeState(SignInSuccessState());
    } catch (e) {
      _changeState(SignInErrorState(e.toString()));
    }
  }

}