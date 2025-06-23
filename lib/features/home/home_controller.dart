import 'package:construtech/features/home/home_state.dart';
import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  //£final AuthServices _services;
  HomeController();

  HomeState _state = HomeInitialState();

  HomeState get state => _state;

  void _changeState(HomeState newState) {
    _state = newState;
    notifyListeners();
  }

  // Future<void> SignIn({
  //   required BuildContext context,
  //   required String CPF,
  //   required String Senha,
  // }) async {
  //   final url =
  //       '${AppUrl.baseUrl}${AppUrl.construtechApiPath}/GetPessoa/{CPF, Senha}?CPF=$CPF&Senha=$Senha';

  //   try {
  //     await HelperAPI.getData(context, url);

  //     _changeState(SignInSuccessState());
  //   } catch (e) {
  //     _changeState(SignInErrorState(e.toString()));
  //   }
  // }
}