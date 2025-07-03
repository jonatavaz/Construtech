import 'package:construtech/common/constants/app_url.dart';
import 'package:construtech/common/models/material.dart';
import 'package:flutter/material.dart';
import 'package:construtech/common/models/obra.dart';
import 'package:construtech/common/utils/HelperAPI.dart';
import 'package:construtech/common/exceptions/app_exceptions.dart';
import 'dart:developer';

abstract class MaterialsState {}

class MaterialsInitialState extends MaterialsState {}

class MaterialsLoadingState extends MaterialsState {}

class MaterialsSuccessState extends MaterialsState {
  final List<Materials> material;
  MaterialsSuccessState(this.material);
}

class MaterialsErrorState extends MaterialsState {
  final String message;
  MaterialsErrorState(this.message);
}

class MaterialsController extends ChangeNotifier {
  List<Materials> _materials = [];
  MaterialsState _state = MaterialsInitialState();

  MaterialsState get state => _state;
  List<Materials> get materials => _materials;

  void _changeState(MaterialsState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> GetMateriais(BuildContext context) async {
    _changeState(MaterialsLoadingState());
    final url = '${AppUrl.baseUrl}${AppUrl.construtechApiPath}/GetListMateriais';
    
    try {
      final dynamic apiResponse = await HelperAPI.getListData(context, url);
      print('Oi 1: $apiResponse' );


      if (apiResponse != null && apiResponse is List<dynamic>) {
        _materials = apiResponse.map((item) {
          print('Oi 2: $_materials' );
          if (item is Map<String, dynamic>) {
            return Materials.fromJson(item);
          } else {
            throw Exception('Erro no map');
          }
        }).toList();

        _changeState(MaterialsSuccessState(_materials));
      } else {
        throw Exception('Erro no formato da $apiResponse');
      }
    } catch (e) {
      _changeState(MaterialsErrorState('Erro ao obras: ${e.toString()}'));
    }
  }
}
