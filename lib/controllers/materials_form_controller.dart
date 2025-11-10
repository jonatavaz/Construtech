import 'dart:math';

import 'package:construtech/common/constants/app_url.dart';
import 'package:construtech/common/utils/HelperAPI.dart';
import 'package:construtech/controllers/materials_controller.dart';
import 'package:construtech/controllers/web_result.dart';
import 'package:construtech/features/home/home_form_state.dart';
import 'package:construtech/features/materials/materials_form_state.dart';
import 'package:construtech/services/secure_storage.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';

class MaterialsFormController extends ChangeNotifier {
  MaterialsFormController();

  MaterialsFormState _state = MaterialsFormInitialState();

  MaterialsFormState get state => _state;

  void _changeState(MaterialsFormState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> InsertPedidoMaterial({
    required BuildContext context,
    required int Quantidade,
    required int CodObra,
    required int CodMaterial,
  }) async {
    _changeState(MaterialsFormLoadingState());

    final url = '${AppUrl.baseUrl}${AppUrl.construtechApiPath}/PedidoMaterial/inserirPedidoMaterial'; 


    final Map<String, dynamic> body = {
      "Quantidade": Quantidade,
      "CodObra": CodObra,
      "CodMaterial": CodMaterial,
    };


    try {

      final WebResult<int> result = await HelperAPI.post<int>(url, body);

      if (result.isSuccess) {
        _changeState(MaterialsFormSuccessState());
      } else {
        _changeState(MaterialsFormErrorState(result.message ?? "Erro ao salvar."));
      }
    } catch (e) {
       _changeState(MaterialsFormErrorState(e.toString()));
    }
  }
}
