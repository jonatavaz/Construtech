import 'package:flutter/material.dart';
import 'package:construtech/models/pagamento.dart';
import 'package:construtech/common/utils/HelperAPI.dart';
import 'package:construtech/common/constants/app_url.dart';
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
        '${AppUrl.baseUrl}${AppUrl.construtechApiPath}/GetListPagamentos';

    try {
      //await HelperAPI.getListData(context, url)
      final dynamic apiResponse = false;

      if (apiResponse != null && apiResponse is List<dynamic>) {
        _pagamentos = apiResponse.map((item) {
          if (item is Map<String, dynamic>) {
            return Pagamento.fromJson(item);
          } else {
            throw Exception(
              'Item da lista de pagamentos não é um mapa válido.',
            );
          }
        }).toList();

        _changeState(PaymentsSuccessState(_pagamentos));
      } else {
        throw Exception(
          'Formato de resposta inesperado ao buscar pagamentos $apiResponse',
        );
      }
    } catch (e) {
      _changeState(
        PaymentsErrorState(
          'Erro desconhecido ao buscar pagamentos: ${e.toString()}',
        ),
      );
    }
  }
}
