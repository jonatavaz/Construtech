import 'dart:developer';

import 'package:construtech/common/constants/app_colors.dart';
import 'package:construtech/common/constants/app_text_style.dart';
import 'package:construtech/common/constants/routes.dart';
import 'package:construtech/common/widgets/custom_text_form_field.dart';
import 'package:construtech/common/widgets/primay_button.dart';
import 'package:construtech/controllers/payments_form_controller.dart';
import 'package:construtech/features/payments/forms/payments_form_state.dart';
import 'package:construtech/controllers/person_form_controller.dart';
import 'package:construtech/features/person/forms/person_form_state.dart';
import 'package:construtech/locator.dart';
import 'package:flutter/material.dart';

class PersonFormPage extends StatefulWidget {
  const PersonFormPage({super.key});

  @override
  State<PersonFormPage> createState() => _PersonFormPageState();
}

class _PersonFormPageState extends State<PersonFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _historicoController = TextEditingController();
  final _avaliacaoController = TextEditingController();
  final _nomeController = TextEditingController();
  final _cpfController = TextEditingController();
  final _nascimentoController = TextEditingController();
  final _emailController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _passwordController = TextEditingController();

  final _controller = locator.get<PersonFormController>();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.state is PersonFormLoadingState) {
        showDialog(
          context: context,
          builder: (context) => const Center(
            child: CircularProgressIndicator(color: AppColors.purpleOne),
          ),
        );
      }
      if (_controller.state is PersonFormSuccessState) {
        Navigator.pushReplacementNamed(context, NamedRoute.person);
      }
      if (_controller.state is PersonFormErrorState) {
        final error = (_controller.state as PersonFormErrorState).message;
        Navigator.pop(context);
      }
    });
  }

  @override
  void dispose() {
    _historicoController.dispose();
    _avaliacaoController.dispose();
    _nomeController.dispose();
    _cpfController.dispose();
    _nascimentoController.dispose();
    _emailController.dispose();
    _telefoneController.dispose();
    _passwordController.dispose();
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
              'Cadastro de Fornecedor',
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
                  controller: _historicoController,
                  labelText: "Histórico",
                ),
                CustomTextFormField(
                  controller: _avaliacaoController,
                  labelText: "Avaliação",
                ),
                CustomTextFormField(
                  controller: _nomeController,
                  labelText: "Nome",
                ),
                CustomTextFormField(
                  controller: _cpfController,
                  labelText: "CPF/CNPJ",
                ),
                CustomTextFormField(
                  controller: _nascimentoController,
                  labelText: "Data Nascimento/Criação",
                  hintText: "01/01/2001",
                ),
                CustomTextFormField(
                  controller: _passwordController,
                  labelText: "Senha ",
                ),

                CustomTextFormField(
                  controller: _telefoneController,
                  labelText: "Telefone",
                  hintText: "(99) 99999-9999",
                ),
                CustomTextFormField(
                  controller: _emailController,
                  labelText: "E-mail ",
                  hintText: "email@email.com",
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
                  _controller.CadastroFornecedor(
                    context: context,
                    Historico: _historicoController.text,
                    Avaliacao: _avaliacaoController.text,
                    Nome: _nomeController.text,
                    CPF: _cpfController.text,
                    Nascimento: _nascimentoController.text,
                    Telefone: _telefoneController.text,
                    Email: _emailController.text,
                    Senha: _passwordController.text,
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
