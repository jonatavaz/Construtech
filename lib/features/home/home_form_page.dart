import 'dart:developer';

import 'package:construtech/common/constants/app_colors.dart';
import 'package:construtech/common/constants/app_text_style.dart';
import 'package:construtech/common/widgets/custom_text_form_field.dart';
import 'package:construtech/common/widgets/password_form_field.dart';
import 'package:construtech/common/widgets/primay_button.dart';
import 'package:construtech/features/onboarding/onboarding_page.dart';
import 'package:flutter/material.dart';

class HomeFormPage extends StatefulWidget {
  const HomeFormPage({super.key});

  @override
  State<HomeFormPage> createState() => _HomeFormPageState();
}

class _HomeFormPageState extends State<HomeFormPage>{


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
          // SizedBox(
          //   height: 180,
          //   child: Image.asset(
          //     'assets/images/Sign_up.png',
          //     fit: BoxFit.contain,
          //   ),
          // ),
          Form(
            //key: _formKey,
            child: Column(
              children: [
                CustomTextFormField(
                  //controller: _cpfController,
                  labelText: "Nome do Cliente",
                  hintText: "nome sobrenome",
                  //validator: Validator.validateEmail,
                ),
                CustomTextFormField(
                  //controller: _cpfController,
                  labelText: "Endereço",
                  hintText: "Rua: exemplo 121",
                  //validator: Validator.validateEmail,
                ),
                CustomTextFormField(
                  //controller: _cpfController,
                  labelText: "Tipo da obra",
                  hintText: "Casa/Prédio",
                  //validator: Validator.validateEmail,
                ),
                CustomTextFormField(
                  //controller: _cpfController,
                  labelText: "Prazo Execução",
                  hintText: "exemplo",
                  //validator: Validator.validateEmail,
                ),
                CustomTextFormField(
                  //controller: _cpfController,
                  labelText: "Detalhes",
                  hintText: "exemplo",
                  //validator: Validator.validateEmail,
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
                // final valid =
                //     _formKey.currentState != null &&
                //     _formKey.currentState!.validate();
                // if (valid) {
                //   _controller.SignIn(
                //     context: context,
                //     CPF: _cpfController.text,
                //     Senha: _passwordController.text,
                //   );
                // } else {
                //   log("Erro ao logar");
                // }
              },
            ),
          ),
          //CustomTextButton(),
          SizedBox(height: 10.0),
        ],
      ),
    );
  }
}