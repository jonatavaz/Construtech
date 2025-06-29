import 'dart:math';

import 'package:construtech/common/constants/app_url.dart';
import 'package:construtech/common/utils/HelperAPI.dart';
import 'package:construtech/features/home/home_form_state.dart';
import 'package:construtech/services/secure_storage.dart';
import 'package:flutter/material.dart';

class MaterialsFormController extends ChangeNotifier {
  MaterialsFormController();

  HomeFormState _state = HomeFormInitialState();

  HomeFormState get state => _state;

  void _changeState(HomeFormState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> InsertObra({
    required BuildContext context,
    required String NomeCliente,
    required String NomeObra,
    required String Endereco,
    required String TipoObra,
    required String PrazoExecucao,
    required String EstagioAtual,
    required String? Detalhes,
  }) async {
    final url = '${AppUrl.baseUrl}${AppUrl.construtechApiPath}/InsertObra';
    print('URL final da API: $url');

    final Map<String, dynamic> body = {
      "NomeCliente": NomeCliente,
      "NomeObra": NomeObra,
      "Endereco": Endereco,
      "Tipo": TipoObra,
      "PrazoExecucao": PrazoExecucao,
      "EstagioAtual": EstagioAtual,
      "Detalhes": Detalhes,
    };
    print('body: $body');

    try {
      await HelperAPI.postData(context, url, body);
      _changeState(HomeFormSuccessState());
    } catch (e) {
      _changeState(HomeFormErrorState(e.toString()));
    }
  }
}
