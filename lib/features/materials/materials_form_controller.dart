import 'dart:math';

import 'package:construtech/common/constants/app_url.dart';
import 'package:construtech/common/utils/HelperAPI.dart';
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

  Future<void> InsertMaterias({
    required BuildContext context,
    required int Quantidade,
    required String Nome,
    required String NomeObra
  }) async {
    final url = '${AppUrl.baseUrl}${AppUrl.construtechApiPath}/UpInsertPedidoMateriais';
    print('URL final da API: $url');

    final Map<String, dynamic> body = {
      "Quantidade": Quantidade,
      "Material": {"Nome": Nome},
      "Obra": {"NomeObra": NomeObra},
    };
    print('body: $body');

    try {
      await HelperAPI.postData(context, url, body);
      _changeState(MaterialsFormSuccessState());
    } catch (e) {
      _changeState(MaterialsFormErrorState(e.toString()));
    }
  }
}
