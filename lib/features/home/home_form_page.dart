import 'dart:developer';

import 'package:construtech/common/constants/app_colors.dart';
import 'package:construtech/common/constants/app_text_style.dart';
import 'package:construtech/common/constants/routes.dart';
import 'package:construtech/common/widgets/custom_text_form_field.dart';
import 'package:construtech/common/widgets/password_form_field.dart';
import 'package:construtech/common/widgets/primay_button.dart';
import 'package:construtech/features/home/home_form_controller.dart';
import 'package:construtech/features/home/home_form_state.dart';
import 'package:construtech/features/onboarding/onboarding_page.dart';
import 'package:construtech/locator.dart';
import 'package:flutter/material.dart';

class HomeFormPage extends StatefulWidget {
  const HomeFormPage({super.key});

  @override
  State<HomeFormPage> createState() => _HomeFormPageState();
}

class _HomeFormPageState extends State<HomeFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeClienteController = TextEditingController();
  final _nomeObraController = TextEditingController();
  final _enderecoController = TextEditingController();
  final _tipoObraController = TextEditingController();
  final _prazoController = TextEditingController();
  final _estagioController = TextEditingController();
  final _detalhesController = TextEditingController();

  final _controller = locator.get<HomeFormController>();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.state is HomeFormLoadingState) {
        showDialog(
          context: context,
          builder: (context) => const Center(
            child: CircularProgressIndicator(color: AppColors.purpleOne),
          ),
        );
      }
      if (_controller.state is HomeFormSuccessState) {
        Navigator.pushReplacementNamed(context, NamedRoute.home);
      }
      if (_controller.state is HomeFormErrorState) {
        final error = (_controller.state as HomeFormErrorState).message;
        Navigator.pop(context);
      }
    });
  }

  @override
  void dispose() {
    _nomeClienteController.dispose();
    _nomeObraController.dispose();
    _enderecoController.dispose();
    _tipoObraController.dispose();
    _prazoController.dispose();
    _detalhesController.dispose();
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
              'Cadastro de Obras',
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
                  controller: _nomeClienteController,
                  labelText: "Nome do Cliente",
                  hintText: "Nome Sobrenome",
                ),
                CustomTextFormField(
                  controller: _nomeObraController,
                  labelText: "Nome da Obra",
                  hintText: "Nome",
                ),
                CustomTextFormField(
                  controller: _enderecoController,
                  labelText: "Endereço",
                  hintText: "Rua: exemplo 121",
                ),
                CustomTextFormField(
                  controller: _tipoObraController,
                  labelText: "Tipo da obra",
                  hintText: "Casa/Prédio",
                ),
                CustomTextFormField(
                  controller: _prazoController,
                  labelText: "Prazo Execução",
                  hintText: "exemplo",
                ),
                CustomTextFormField(
                  controller: _estagioController,
                  labelText: "Estágio Atual",
                  hintText: "Acabamento/Alicerce",
                ),
                CustomTextFormField(
                  controller: _detalhesController,
                  labelText: "Detalhes",
                  hintText: "exemplo",
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
                  _controller.InsertObra(
                    context: context,
                    NomeCliente: _nomeClienteController.text,
                    NomeObra: _nomeObraController.text,
                    Endereco: _enderecoController.text,
                    TipoObra: _tipoObraController.text,
                    PrazoExecucao: _prazoController.text,
                    EstagioAtual: _estagioController.text,
                    Detalhes: _detalhesController.text,
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
