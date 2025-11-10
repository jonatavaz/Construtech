import 'package:flutter/material.dart';
import 'package:construtech/models/pagamento.dart';
import 'package:construtech/common/utils/HelperAPI.dart';
import 'package:construtech/common/constants/app_url.dart';
import 'package:construtech/controllers/web_result.dart';
import 'dart:developer';

abstract class PaymentsState {}

class PaymentsInitialState extends PaymentsState {}

class PaymentsLoadingState extends PaymentsState {}

class PaymentsSuccessState extends PaymentsState {
  final List<Pagamento> pagamentos;
  PaymentsSuccessState(this.pagamentos);
}

class PaymentsErrorState extends PaymentsState {
  final String message;
  PaymentsErrorState(this.message);
}

class PaymentsController extends ChangeNotifier {
  List<Pagamento> _pagamentos = [];
  PaymentsState _state = PaymentsInitialState();

  PaymentsState get state => _state;
  List<Pagamento> get pagamentos => _pagamentos;
  double get totalPagamentos {
    return _pagamentos.fold(0.0, (sum, item) => sum + (item.valorPago ?? 0.0));
  }

  void _changeState(PaymentsState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> GetListPagamentos(BuildContext context) async {
    _changeState(PaymentsLoadingState());
    
    final url =
        '${AppUrl.baseUrl}${AppUrl.construtechApiPath}/Pagamento/getPagamentos';
    log("Buscando pagamentos em: $url");

    try {
      final WebResult<List<dynamic>> result = await HelperAPI.get<List<dynamic>>(url);

      if (result.isSuccess && result.data != null) {
        
        _pagamentos = result.data!
            .map((item) => Pagamento.fromJson(item as Map<String, dynamic>))
            .toList();

        _changeState(PaymentsSuccessState(_pagamentos));
      } else {
        _changeState(PaymentsErrorState(result.message ?? "Não foi possível carregar os pagamentos."));
      }
    } catch (e) {
      log("Exceção no GetListPagamentos: $e");
      _changeState(PaymentsErrorState('Erro de conexão: ${e.toString()}'));
    }
  }
}
