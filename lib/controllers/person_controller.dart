import 'package:construtech/controllers/web_result.dart';
import 'package:flutter/material.dart';
import 'package:construtech/models/fornecedor.dart';
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
        '${AppUrl.baseUrl}${AppUrl.construtechApiPath}/Fornecedor/getFornecedores';
    log('PersonController.fetchFornecedores: Chamando URL: $url');

    try {
      final WebResult<List<dynamic>> result = await HelperAPI.get<List<dynamic>>(url);

      if (result.isSuccess && result.data != null) {
        
        _fornecedores = result.data!
            .map((item) => Fornecedor.fromJson(item as Map<String, dynamic>))
            .toList();

        _changeState(PersonSuccessState(_fornecedores));
      } else {
        _changeState(PersonErrorState(result.message ?? "Não foi possível carregar os fornecedores."));
      }
    } catch (e) {
      log("Exceção no fetchFornecedores: $e");
      _changeState(PersonErrorState('Erro de conexão: ${e.toString()}'));
    }
  }
}
