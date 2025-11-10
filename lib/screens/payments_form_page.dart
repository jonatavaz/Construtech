import 'dart:developer';

import 'package:construtech/common/constants/app_colors.dart';
import 'package:construtech/common/constants/app_text_style.dart';
import 'package:construtech/common/constants/app_url.dart';
import 'package:construtech/common/constants/routes.dart';
import 'package:construtech/common/utils/HelperAPI.dart';
import 'package:construtech/common/utils/ui_utils.dart';
import 'package:construtech/common/widgets/cliente_dropdown_form_field.dart';
import 'package:construtech/common/widgets/custom_text_form_field.dart';
import 'package:construtech/common/widgets/primay_button.dart';
import 'package:construtech/features/materials/materials_form_state.dart';
import 'package:construtech/controllers/payments_form_controller.dart';
import 'package:construtech/features/payments/forms/payments_form_state.dart';
import 'package:construtech/locator.dart';
import 'package:construtech/models/formaPagamento.dart';
import 'package:construtech/models/obra.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';

class PaymentsFormPage extends StatefulWidget {
  const PaymentsFormPage({super.key});

  @override
  State<PaymentsFormPage> createState() => _PaymentsFormPageState();
}

class _PaymentsFormPageState extends State<PaymentsFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _valorPagoController = TextEditingController();

 List<FormaPagamento> _listaFormasPagamento = [];
  FormaPagamento? _formaSelecionada;
  bool _isLoadingFormas = true;

  List<Obra> _listaObras = [];
  Obra? _obraSelecionada;
  bool _isLoadingObras = true;

  final _controller = locator.get<PaymentsFormController>();

  @override
  void initState() {
    super.initState();
    
    _carregarObras(); 
    _carregarFormasPagamento(); 

    _controller.addListener(() {
      if (_controller.state is PaymentsFormSuccessState) {
        Navigator.pop(context); 
        Navigator.pushReplacementNamed(context, NamedRoute.payments);
      }
      if (_controller.state is PaymentsFormErrorState) {
        final error = (_controller.state as PaymentsFormErrorState).message;
        Navigator.pop(context); 
        showAlerts(context, error); 
      }
    });
  }

  Future<void> _carregarObras() async {
    setState(() { _isLoadingObras = true; });
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
      } else { }
    } catch (e) { }
  }

  Future<void> _carregarFormasPagamento() async { 
    setState(() { _isLoadingFormas = true; });
    try {
      final url = '${AppUrl.baseUrl}${AppUrl.construtechApiPath}/FormaPagamento/getFormasPagamentos';
      final result = await HelperAPI.get<List<dynamic>>(url);
      if (result.isSuccess && result.data != null) {
        setState(() {
          _listaFormasPagamento = result.data!
              .map((json) => FormaPagamento.fromJson(json as Map<String, dynamic>))
              .toList();
          _isLoadingFormas = false;
        });
      } else {
        log("Erro ao carregar Formas de Pagamento: ${result.message}");
        setState(() { _isLoadingFormas = false; });
      }
    } catch (e) {
      log("Exceção ao carregar Formas de Pagamento: $e");
      setState(() { _isLoadingFormas = false; });
    }
  }

  @override
  void dispose() {
    _valorPagoController.dispose();
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
              'Pagamentos',
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
                  controller: _valorPagoController,
                  labelText: "Valor",
                  hintText: "00,00",
                ),
                CustomDropdownFormField<FormaPagamento>(
                  labelText: "Forma de Pagamento",
                  hintText: "Selecione a forma",
                  isLoading: _isLoadingFormas,
                  value: _formaSelecionada,
                  items: _listaFormasPagamento,
                  validator: (value) => value == null ? 'Selecione uma forma.' : null,
                  itemBuilderText: (FormaPagamento forma) => forma.nome,
                  onChanged: (FormaPagamento? novoValor) {
                    setState(() {
                      _formaSelecionada = novoValor;
                    });
                  },
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
                  _controller.InsertPagamento(
                    context: context,
                    ValorPago: Decimal.parse(_valorPagoController.text),
                    CodFormaPagamento: _formaSelecionada!.codFormaPagamento,
                    CodObra: _obraSelecionada!.codObra, 
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
