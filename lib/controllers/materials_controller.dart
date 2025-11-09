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

  // ----- MÉTODO CORRIGIDO -----
  Future<void> GetMateriais(BuildContext context) async { // 1. Removido o BuildContext
    _changeState(MaterialsLoadingState());
    
    final url =
        '${AppUrl.baseUrl}${AppUrl.construtechApiPath}/Material/getMateriais';
    log("Buscando materiais em: $url");

    try {
      // 2. Chame o HelperAPI.get<T> esperando uma Lista
      final WebResult<List<dynamic>> result = await HelperAPI.get<List<dynamic>>(url);

      // 3. Verifique se o WebResult foi um sucesso e se os dados não são nulos
      if (result.isSuccess && result.data != null) {
        
        // 4. Converta o List<dynamic> (lista de Maps) para List<Materials>
        _materials = result.data!
            .map((item) => Material.fromJson(item as Map<String, dynamic>))
            .toList();

        // 5. Mude o estado para Sucesso, passando a lista
        //    (conforme a definição do seu MaterialsSuccessState)
        _changeState(MaterialsSuccessState(_materials));
      } else {
        // 6. A API retornou um erro (isSuccess: false)
        _changeState(MaterialsErrorState(result.message ?? "Não foi possível carregar os materiais."));
      }
    } catch (e) {
      // 7. A chamada falhou (exceção de rede ou parsing)
      log("Exceção no GetMateriais: $e");
      _changeState(MaterialsErrorState('Erro de conexão: ${e.toString()}'));
    }
  }
}

