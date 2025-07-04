
import 'package:flutter/material.dart';
import 'package:construtech/common/models/pagamento.dart';
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

  void _changeState(PaymentsState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> fetchPagamentos(BuildContext context) async {
    _changeState(PaymentsLoadingState());
    final url = '${AppUrl.baseUrl}${AppUrl.construtechApiPath}/GetListPagamentos';
    log('PaymentsController.fetchPagamentos: Chamando URL: $url');

    try {
      final dynamic apiResponse = await HelperAPI.getListData(context, url);
      
      if (apiResponse != null && apiResponse is List<dynamic>) {
        _pagamentos = apiResponse.map((item) {
          if (item is Map<String, dynamic>) {
            return Pagamento.fromJson(item);
          } else {
            throw Exception('Item da lista de pagamentos não é um mapa válido.');
          }
        }).toList();
        
        _changeState(PaymentsSuccessState(_pagamentos));
        
      } else {
        
        throw Exception('Formato de resposta inesperado ao buscar pagamentos $apiResponse');
      }
    } catch (e) {
      _changeState(PaymentsErrorState('Erro desconhecido ao buscar pagamentos: ${e.toString()}'));
    }
  }
}