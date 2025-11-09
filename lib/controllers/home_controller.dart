import 'package:construtech/common/constants/app_url.dart';
import 'package:construtech/controllers/web_result.dart';
import 'package:flutter/material.dart';
import 'package:construtech/models/obra.dart';
import 'package:construtech/common/utils/HelperAPI.dart';
import 'package:construtech/common/exceptions/app_exceptions.dart';
import 'dart:developer';

abstract class HomeState {}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeSuccessState extends HomeState {
  final List<Obra> obras;
  HomeSuccessState(this.obras);
}

class HomeErrorState extends HomeState {
  final String message;
  HomeErrorState(this.message);
}

class HomeController extends ChangeNotifier {
  List<Obra> _obras = [];
  HomeState _state = HomeInitialState();

  HomeState get state => _state;
  List<Obra> get obras => _obras;

  void _changeState(HomeState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> GetObras(BuildContext context) async {
    _changeState(HomeLoadingState());
    final url = '${AppUrl.baseUrl}${AppUrl.construtechApiPath}/Obra/getObras';

    try {
      final WebResult<List<dynamic>> result = await HelperAPI.get<List<dynamic>>(url);

      if (result.isSuccess && result.data != null) {
        
        _obras = result.data!
            .map((item) => Obra.fromJson(item as Map<String, dynamic>))
            .toList();

        _changeState(HomeSuccessState(_obras));
      } else {
        _changeState(HomeErrorState(result.message ?? "Não foi possível carregar as obras."));
      }
    } catch (e) {
      log("Exceção no GetObras: $e");
      _changeState(HomeErrorState('Erro de conexão: ${e.toString()}'));
    }
  }
}
