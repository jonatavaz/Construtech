import 'dart:developer';

import 'package:construtech/common/constants/app_colors.dart';
import 'package:construtech/common/constants/app_text_style.dart';
import 'package:construtech/common/constants/routes.dart';
import 'package:construtech/common/widgets/custom_text_form_field.dart';
import 'package:construtech/common/widgets/primay_button.dart';
import 'package:construtech/features/materials/materials_form_state.dart';
import 'package:construtech/features/payments/forms/payments_form_controller.dart';
import 'package:construtech/features/payments/forms/payments_form_state.dart';
import 'package:construtech/locator.dart';
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
  final _nomeController = TextEditingController();
  final _nomeObraController = TextEditingController();

  final _controller = locator.get<PaymentsFormController>();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.state is PaymentsFormLoadingState) {
        showDialog(
          context: context,
          builder: (context) => const Center(
            child: CircularProgressIndicator(color: AppColors.purpleOne),
          ),
        );
      }
      if (_controller.state is PaymentsFormSuccessState) {
        Navigator.pushReplacementNamed(context, NamedRoute.payments);
      }
      if (_controller.state is PaymentsFormErrorState) {
        final error = (_controller.state as PaymentsFormErrorState).message;
        Navigator.pop(context);
      }
    });
  }

  @override
  void dispose() {
    _valorPagoController.dispose();
    _nomeController.dispose();
    _nomeObraController.dispose();
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
                CustomTextFormField(
                  controller: _nomeController,
                  labelText: "Nome Forma Pagamento",
                  hintText: "Nome",
                ),
                CustomTextFormField(
                  controller: _nomeObraController,
                  labelText: "Nome Obra",
                  hintText: "Nome",
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
                    Nome: _nomeController.text,
                    NomeObra: _nomeObraController.text,
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
