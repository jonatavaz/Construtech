import 'package:flutter/material.dart';
import 'package:construtech/common/models/fornecedor.dart';
import 'package:construtech/common/utils/HelperAPI.dart';
import 'package:construtech/common/constants/app_url.dart';
import 'package:construtech/common/exceptions/app_exceptions.dart';
import 'dart:developer';

abstract class PersonState {}

class PersonInitialState extends PersonState {}

class PersonLoadingState extends PersonState {}

class PersonSuccessState extends PersonState {
  final List<Fornecedor> fornecedores;
  PersonSuccessState(this.fornecedores);
}

class PersonErrorState extends PersonState {
  final String message;
  PersonErrorState(this.message);
}

class PersonController extends ChangeNotifier {
  List<Fornecedor> _fornecedores = [];
  PersonState _state = PersonInitialState();

  PersonState get state => _state;
  List<Fornecedor> get fornecedores => _fornecedores;

  void _changeState(PersonState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> fetchFornecedores(BuildContext context) async {
    _changeState(PersonLoadingState());

    final url =
        '${AppUrl.baseUrl}${AppUrl.construtechApiPath}/GetListFornecedores';
    log('PersonController.fetchFornecedores: Chamando URL: $url');

    try {
      final dynamic apiResponse = await HelperAPI.getListData(context, url);

      if (apiResponse != null && apiResponse is List<dynamic>) {
        _fornecedores = apiResponse.map((item) {
          if (item is Map<String, dynamic>) {
            return Fornecedor.fromJson(item);
          } else {
            throw Exception(
              'Item da lista de fornecedores não é um mapa válido.',
            );
          }
        }).toList();

        _changeState(PersonSuccessState(_fornecedores));
      }
    } catch (e) {
      _changeState(
        PersonErrorState(
          'Erro desconhecido ao buscar fornecedores: ${e.toString()}',
        ),
      );
    }
  }
}
