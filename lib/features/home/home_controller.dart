import 'package:construtech/common/constants/app_url.dart';
import 'package:flutter/material.dart';
import 'package:construtech/common/models/obra.dart';
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
    final url = '${AppUrl.baseUrl}${AppUrl.construtechApiPath}/GetObras';
    
    try {
      final dynamic apiResponse = await HelperAPI.getListData(context, url);

      if (apiResponse != null && apiResponse is List<dynamic>) {
        _obras = apiResponse.map((item) {
          if (item is Map<String, dynamic>) {
            return Obra.fromJson(item);
          } else {
            throw Exception('Erro no map');
          }
        }).toList();

        _changeState(HomeSuccessState(_obras));
      } else {
        throw Exception('Erro no formato da $apiResponse');
      }
    } catch (e) {
      _changeState(HomeErrorState('Erro ao obras: ${e.toString()}'));
    }
  }
}
