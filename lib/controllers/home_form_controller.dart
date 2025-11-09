import 'dart:developer';
import 'package:construtech/common/constants/app_url.dart';
import 'package:construtech/common/utils/HelperAPI.dart';
import 'package:construtech/controllers/web_result.dart';
import 'package:construtech/features/home/home_form_state.dart';
import 'package:construtech/common/utils/ui_utils.dart'; 
import 'package:flutter/material.dart';

class HomeFormController extends ChangeNotifier {
  HomeFormController();

  HomeFormState _state = HomeFormInitialState();

  HomeFormState get state => _state;

  void _changeState(HomeFormState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> InsertObra({
    required BuildContext context,
    required int CodCliente, 
    required String NomeObra,
    required String Endereco,
    required String TipoObra,
    required String PrazoExecucao,
    required String EstagioAtual,
    required String? Detalhes,
  }) async {
    _changeState(HomeFormLoadingState());

    final url = '${AppUrl.baseUrl}${AppUrl.construtechApiPath}/Obra/inserirObra';
    log('URL final da API: $url');

    final Map<String, dynamic> body = {
      "codCliente": CodCliente,
      "Nome": NomeObra,
      "Endereco": Endereco,
      "Tipo": TipoObra, 
      "PrazoExecucao": PrazoExecucao,
      "EstagioAtual": EstagioAtual,
      "Detalhes": Detalhes,
    };
    log('Enviando body: $body');

    try {
      final WebResult<int> result = await HelperAPI.post<int>(
        url,
        body,
      );

      if (result.isSuccess) {
        _changeState(HomeFormSuccessState());
        
      } else {
        _changeState(HomeFormErrorState(result.message ?? "Erro ao salvar a obra."));
      }
    } catch (e) {
      log("Erro inesperado no InsertObra: $e");
      _changeState(HomeFormErrorState("Ocorreu um erro inesperado: $e"));
    }
  }
}