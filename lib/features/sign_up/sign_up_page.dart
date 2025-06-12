import 'dart:developer';

import 'package:construtech/common/constants/app_colors.dart';
import 'package:construtech/common/constants/app_text_style.dart';
import 'package:construtech/common/constants/routes.dart';
import 'package:construtech/common/utils/validator.dart';
import 'package:construtech/common/widgets/custom_buttom_sheet.dart';
import 'package:construtech/common/widgets/custom_text_form_field.dart';
import 'package:construtech/common/widgets/password_form_field.dart';
import 'package:construtech/common/widgets/primay_button.dart';
import 'package:construtech/features/sign_up/sign_up_controller.dart';
import 'package:construtech/features/sign_up/sign_up_state.dart';
import 'package:construtech/locator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _cpfController = TextEditingController();
  final _nascimentoController = TextEditingController();
  final _emailController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _passwordController = TextEditingController();

  final _controller = locator.get<SignUpController>();

  @override
  void dispose() {
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
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.state is SignInLoadingState) {
        showDialog(
          context: context,
          builder: (context) => const Center(
            child: CircularProgressIndicator(color: AppColors.purpleOne),
          ),
        );
      }
      if (_controller.state is SignInSuccessState) {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                Scaffold(body: Center(child: Text("DashBoard"))),
          ),
        );
      }
      if (_controller.state is SignInErrorState) {
        final error = (_controller.state as SignInErrorState).message;
        Navigator.pop(context);
        customModalBottomSheet(context, SignInError(message: error));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25.0),
            child: Text(
              'Criar conta',
              textAlign: TextAlign.center,
              style: AppTextStyle.mediumText.copyWith(
                color: AppColors.purpleOne,
              ),
            ),
          ),
          SizedBox(
            height: 180,
            child: Image.asset(
              'assets/images/Sign_up.png',
              fit: BoxFit.contain,
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextFormField(
                  controller: _nomeController,
                  labelText: "Nome",
                  hintText: "Digite seu nome",
                  textCapitalization: TextCapitalization.words,
                  validator: Validator.validateName,
                ),
                CustomTextFormField(
                  controller: _cpfController,
                  labelText: "CPF",
                  hintText: "Digite seu CPF",
                  textCapitalization: TextCapitalization.words,
                  validator: Validator.validateName,
                ),
                CustomTextFormField(
                  controller: _nascimentoController,
                  labelText: "Nascimento",
                  hintText: "Digite sua data",
                  textCapitalization: TextCapitalization.words,
                  validator: Validator.validateName,
                ),
                CustomTextFormField(
                  controller: _emailController,
                  labelText: "Email",
                  hintText: "email@email.com",
                  validator: Validator.validateEmail,
                ),
                CustomTextFormField(
                  controller: _telefoneController,
                  labelText: "Telefone",
                  hintText: "32 99999-9999",
                  validator: Validator.validateEmail,
                ),
                PasswordFormField(
                  controller: _passwordController,
                  labelText: "Senha",
                  hintText: "******",
                  validator: Validator.validatePassword,
                  helperText:
                      "Sua senha deve conter no minimo 8 caracteres, contendo Maiuscula, Minuscula e número",
                ),
                PasswordFormField(
                  labelText: "Confirme sua senha",
                  hintText: "******",
                  validator: (value) => Validator.validateConfirmPassword(
                    value,
                    _passwordController.text,
                  ),
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
              text: "Criar agora",
              onPressed: () {
                final valid =
                    _formKey.currentState != null &&
                    _formKey.currentState!.validate();
                if (valid) {
                  _controller.SignUp(
                    context: context,
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
          CustomTextButton(),
          SizedBox(height: 10.0),
        ],
      ),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () =>
          Navigator.pushReplacementNamed(context, NamedRoute.signIn),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Possui uma conta? ',
              style: AppTextStyle.smallText.copyWith(color: AppColors.purple),
              recognizer: TapGestureRecognizer()..onTap = () => log('message'),
            ),
            TextSpan(
              children: [TextSpan(text: 'Login')],
              style: AppTextStyle.smallText.copyWith(
                color: AppColors.purpleOne,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
