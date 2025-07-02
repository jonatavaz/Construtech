import 'dart:developer';

import 'package:construtech/common/constants/app_colors.dart';
import 'package:construtech/common/constants/app_text_style.dart';
import 'package:construtech/common/constants/routes.dart';
import 'package:construtech/common/widgets/custom_text_form_field.dart';
import 'package:construtech/common/widgets/password_form_field.dart';
import 'package:construtech/common/widgets/primay_button.dart';
import 'package:construtech/features/home/home_form_controller.dart';
import 'package:construtech/features/home/home_form_state.dart';
import 'package:construtech/features/materials/materials_form_controller.dart';
import 'package:construtech/features/materials/materials_form_state.dart';
import 'package:construtech/features/onboarding/onboarding_page.dart';
import 'package:construtech/locator.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';

class MaterialsFormPage extends StatefulWidget {
  const MaterialsFormPage({super.key});

  @override
  State<MaterialsFormPage> createState() => _MaterialsFormPageState();
}

class _MaterialsFormPageState extends State<MaterialsFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _quantidadeController = TextEditingController();
  final _nomeController = TextEditingController();
  final _nomeObraController = TextEditingController();

  final _controller = locator.get<MaterialsFormController>();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.state is MaterialsFormLoadingState) {
        showDialog(
          context: context,
          builder: (context) => const Center(
            child: CircularProgressIndicator(color: AppColors.purpleOne),
          ),
        );
      }
      if (_controller.state is MaterialsFormSuccessState) {
        Navigator.pushReplacementNamed(context, NamedRoute.home);
      }
      if (_controller.state is MaterialsFormErrorState) {
        final error = (_controller.state as MaterialsFormErrorState).message;
        Navigator.pop(context);
      }
    });
  }

  @override
  void dispose() {
    _quantidadeController.dispose();
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
              'Cadastro de Materiais',
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
                CustomTextFormField(
                  controller: _nomeController,
                  labelText: "Nome Material",
                  hintText: "Nome",
                ),
                CustomTextFormField(
                  controller: _nomeObraController,
                  labelText: "Nome da Obra",
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
                  _controller.InsertMaterias(
                    context: context,
                    Quantidade: int.parse(_quantidadeController.text),
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
