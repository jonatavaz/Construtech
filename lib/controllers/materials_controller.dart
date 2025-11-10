import 'package:construtech/common/constants/app_url.dart';
import 'package:construtech/models/material.dart';
import 'package:flutter/material.dart' hide Material;
import 'package:construtech/models/obra.dart';
import 'package:construtech/common/utils/HelperAPI.dart';
import 'package:construtech/common/exceptions/app_exceptions.dart';
import 'package:construtech/controllers/web_result.dart';
import 'dart:developer';

abstract class MaterialsState {}

class MaterialsInitialState extends MaterialsState {}

class MaterialsLoadingState extends MaterialsState {}

class MaterialsSuccessState extends MaterialsState {
  final List<Material> material;
  MaterialsSuccessState(this.material);
}

class MaterialsErrorState extends MaterialsState {
  final String message;
  MaterialsErrorState(this.message);
}

class MaterialsController extends ChangeNotifier {
  List<Material> _materials = [];
  MaterialsState _state = MaterialsInitialState();

  MaterialsState get state => _state;
  List<Material> get materials => _materials;

  void _changeState(MaterialsState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> GetMateriais(BuildContext context) async {
    _changeState(MaterialsLoadingState());
    
    final url =
        '${AppUrl.baseUrl}${AppUrl.construtechApiPath}/Material/getMateriais';
    log("Buscando materiais em: $url");

    try {
      final WebResult<List<dynamic>> result = await HelperAPI.get<List<dynamic>>(url);

      if (result.isSuccess && result.data != null) {
        
        _materials = result.data!
            .map((item) => Material.fromJson(item as Map<String, dynamic>))
            .toList();

        _changeState(MaterialsSuccessState(_materials));
      } else {
        _changeState(MaterialsErrorState(result.message ?? "Não foi possível carregar os materiais."));
      }
    } catch (e) {
      log("Exceção no GetMateriais: $e");
      _changeState(MaterialsErrorState('Erro de conexão: ${e.toString()}'));
    }
  }
}

