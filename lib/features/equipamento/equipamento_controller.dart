import 'package:flutter/material.dart';
import 'package:construtech/common/models/equipamento.dart';
import 'package:construtech/common/utils/HelperAPI.dart';
import 'package:construtech/common/constants/app_url.dart';
import 'package:construtech/common/exceptions/app_exceptions.dart';
import 'dart:developer';

abstract class EquipamentoState {}
class EquipamentoInitialState extends EquipamentoState {}
class EquipamentoLoadingState extends EquipamentoState {}
class EquipamentoSuccessState extends EquipamentoState {
  final List<Equipamento> equipamentos;
  EquipamentoSuccessState(this.equipamentos);
}
class EquipamentoErrorState extends EquipamentoState {
  final String message;
  EquipamentoErrorState(this.message);
}

class EquipamentoController extends ChangeNotifier {
  List<Equipamento> _equipamentos = [];
  EquipamentoState _state = EquipamentoInitialState();

  EquipamentoState get state => _state;
  List<Equipamento> get equipamentos => _equipamentos;

  void _changeState(EquipamentoState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> fetchEquipamentos(BuildContext context, int codObra) async {
    _changeState(EquipamentoLoadingState());

    final url = '${AppUrl.baseUrl}${AppUrl.construtechApiPath}/GetObraEquipamentos/$codObra';

    try {
      final dynamic apiResponse = await HelperAPI.getListData(context, url);

      if (apiResponse != null && apiResponse is List<dynamic>) {
      
        _equipamentos = apiResponse.map((item) {
          if (item is Map<String, dynamic>) {
            return Equipamento.fromJson(item);
          } else {
            throw Exception('Mapa inválido.');
          }
        }).toList();
      }
      _changeState(EquipamentoSuccessState(_equipamentos));
    } catch (e) {
      _changeState(EquipamentoErrorState('Erro ao buscar equipamentos: ${e.toString()}'));
    }
  }
}