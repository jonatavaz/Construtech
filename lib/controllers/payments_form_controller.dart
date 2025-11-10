import 'dart:math';

import 'package:construtech/common/constants/app_url.dart';
import 'package:construtech/common/utils/HelperAPI.dart';
import 'package:construtech/controllers/web_result.dart';
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
    required int CodFormaPagamento,
    required int CodObra,
  }) async {
    _changeState(PaymentsFormLoadingState());

    final url = '${AppUrl.baseUrl}${AppUrl.construtechApiPath}/Pagamento/inserirPagamento';


    final Map<String, dynamic> body = {
      "ValorPago": ValorPago.toDouble(),
      "CodFormaPagamento": CodFormaPagamento,
      "CodObra": CodObra
    };

    try {
      final WebResult<int> result = await HelperAPI.post<int>(url, body);

      if (result.isSuccess) {
        _changeState(PaymentsFormSuccessState());
      } else {
        _changeState(PaymentsFormErrorState(result.message ?? "Erro ao salvar o pagamento."));
      }
    } catch (e) {
      _changeState(PaymentsFormErrorState("Ocorreu um erro inesperado: $e"));
    }
  }
}