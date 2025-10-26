import 'dart:math';

import 'package:construtech/common/constants/app_url.dart';
import 'package:construtech/common/utils/HelperAPI.dart';
import 'package:construtech/features/payments/forms/payments_form_state.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';

class PaymentsFormController extends ChangeNotifier {
  PaymentsFormController();

  PaymentsFormState _state = PaymentsFormInitialState();

  PaymentsFormState get state => _state;

  void _changeState(PaymentsFormState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> InsertPagamento({
    required BuildContext context,
    required Decimal ValorPago,
    required String Nome,
    required String NomeObra,
  }) async {
    final url = '${AppUrl.baseUrl}${AppUrl.construtechApiPath}/InsertPagamento';
    print('URL final da API: $url');

    final Map<String, dynamic> body = {
      "ValorPago": ValorPago,
      "FormaPagamento": {"Nome": Nome},
      "Obra": {"NomeObra": NomeObra},
    };
    print('body: $body');

    try {
      await HelperAPI.postData(context, url, body);
      _changeState(PaymentsFormSuccessState());
    } catch (e) {
      _changeState(PaymentsFormErrorState(e.toString()));
    }
  }
}
