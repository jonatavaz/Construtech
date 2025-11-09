import 'dart:developer';

import 'package:construtech/common/constants/app_colors.dart';
import 'package:construtech/common/constants/app_text_style.dart';
import 'package:construtech/common/constants/app_url.dart';
import 'package:construtech/common/constants/routes.dart';
import 'package:construtech/common/utils/HelperAPI.dart';
import 'package:construtech/common/utils/ui_utils.dart';
import 'package:construtech/common/widgets/cliente_dropdown_form_field.dart';
import 'package:construtech/common/widgets/custom_text_form_field.dart';
import 'package:construtech/common/widgets/password_form_field.dart';
import 'package:construtech/common/widgets/primay_button.dart';
import 'package:construtech/controllers/home_form_controller.dart';
import 'package:construtech/features/home/home_form_state.dart';
import 'package:construtech/controllers/materials_form_controller.dart';
import 'package:construtech/features/materials/materials_form_state.dart';
import 'package:construtech/models/obra.dart';
import 'package:construtech/screens/onboarding_page.dart';
import 'package:construtech/locator.dart';
import 'package:decimal/decimal.dart';
import 'package:construtech/models/material.dart' as model;
import 'package:construtech/controllers/web_result.dart';
import 'package:flutter/material.dart';

class MaterialsFormPage extends StatefulWidget {
  const MaterialsFormPage({super.key});

  @override
  State<MaterialsFormPage> createState() => _MaterialsFormPageState();
}

class _MaterialsFormPageState extends State<MaterialsFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _quantidadeController = TextEditingController();
  //final _nomeController = TextEditingController();
  //final _nomeObraController = TextEditingController();

  List<Obra> _listaObras = [];
  List<model.Material> _listaMateriais = [];
  Obra? _obraSelecionada;
  model.Material? _materialSelecionado;
  
  bool _isLoadingObras = true;
  bool _isLoadingMateriais = true;

  final _controller = locator.get<MaterialsFormController>();

  @override
  void initState() {
    super.initState();
    _carregarObras();
    _carregarMateriais();

    _controller.addListener(() {
      if (_controller.state is MaterialsFormLoadingState) {
        // ... (seu código de loading) ...
      }
      if (_controller.state is MaterialsFormSuccessState) {
        Navigator.pop(context); // Fecha o loading
        Navigator.pop(context); // Volta para a tela anterior
      }
      if (_controller.state is MaterialsFormErrorState) {
        final error = (_controller.state as MaterialsFormErrorState).message;
        Navigator.pop(context); // Fecha o loading
        showAlerts(context, error); // Mostra o erro
      }
    });
  }

  Future<void> _carregarObras() async {
    try {
      final url = '${AppUrl.baseUrl}${AppUrl.construtechApiPath}/Obra/getObras';
      final result = await HelperAPI.get<List<dynamic>>(url);
      if (result.isSuccess && result.data != null) {
        setState(() {
          _listaObras = result.data!
              .map((json) => Obra.fromJson(json as Map<String, dynamic>))
              .toList();
          _isLoadingObras = false;
        });
      } else {
        log("Erro ao carregar Obras: ${result.message}");
      }
    } catch (e) {
      log("Exceção ao carregar Obras: $e");
    }
  }

  // (Certifique-se que o import no topo do arquivo foi alterado para '... as model;')

Future<void> _carregarMateriais() async {
  try {
    final url = '${AppUrl.baseUrl}${AppUrl.construtechApiPath}/Material/getMateriais'; // Use a URL correta
    final result = await HelperAPI.get<List<dynamic>>(url);
    if (result.isSuccess && result.data != null) {
      setState(() {
        _listaMateriais = result.data!
            .map((json) => model.Material.fromJson(json as Map<String, dynamic>))
            .toList();
        _isLoadingMateriais = false;
      });
    } else {
      log("Erro ao carregar Materiais: ${result.message}");
    }
  } catch (e) {
    log("Exceção ao carregar Materiais: $e");
  }
}

  @override
  void dispose() {
    _quantidadeController.dispose();
    //_nomeController.dispose();
    //_nomeObraController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25.0),
            child: Text(
              'Pedidos de Materiais',
              textAlign: TextAlign.center,
              style: AppTextStyle.mediumText.copyWith(
                color: AppColors.purpleOne,
              ),
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextFormField(
                  controller: _quantidadeController,
                  labelText: "Quantidade",
                ),
                CustomDropdownFormField<Obra>(
                  labelText: "Obra",
                  hintText: "Selecione a obra",
                  isLoading: _isLoadingObras,
                  value: _obraSelecionada,
                  items: _listaObras,
                  validator: (value) => value == null ? 'Selecione uma obra.' : null,
                  itemBuilderText: (Obra obra) => obra.nomeObra, 
                  onChanged: (Obra? novoValor) {
                    setState(() {
                      _obraSelecionada = novoValor;
                    });
                  },
                ),
                CustomDropdownFormField<model.Material>(
                  labelText: "Material",
                  hintText: "Selecione o material",
                  isLoading: _isLoadingMateriais,
                  value: _materialSelecionado,
                  items: _listaMateriais,
                  validator: (value) => value == null ? 'Selecione um material.' : null,
                  itemBuilderText: (model.Material material) => material.nome, 
                  onChanged: (model.Material? novoValor) {
                    setState(() {
                      _materialSelecionado = novoValor;
                    });
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 32.0,
              right: 32.0,
              top: 16.0,
              bottom: 4.0,
            ),
            child: PrimaryButton(
              text: "Salvar",
              onPressed: () {
                final valid =
                    _formKey.currentState != null &&
                    _formKey.currentState!.validate();
                if (valid) {
                  _controller.InsertPedidoMaterial( // Renomeei para clareza
                    context: context,
                    Quantidade: int.tryParse(_quantidadeController.text) ?? 0,
                    CodObra: _obraSelecionada!.codObra,
                    CodMaterial: _materialSelecionado!.codMaterial,
                  );
                } else {
                  log("Erro ao logar");
                }
              },
            ),
          ),
          SizedBox(height: 10.0),
        ],
      ),
    );
  }
}
