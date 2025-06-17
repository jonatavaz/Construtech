import 'dart:developer';

import 'package:construtech/common/constants/app_colors.dart';
import 'package:construtech/common/constants/app_text_style.dart';
import 'package:construtech/common/constants/routes.dart';
import 'package:construtech/common/utils/validator.dart';
import 'package:construtech/common/widgets/custom_buttom_sheet.dart';
import 'package:construtech/common/widgets/custom_text_form_field.dart';
import 'package:construtech/common/widgets/password_form_field.dart';
import 'package:construtech/common/widgets/primay_button.dart';
import 'package:construtech/features/home/home_page.dart';
import 'package:construtech/features/sign_in/sign_in_controller.dart';
import 'package:construtech/features/sign_in/sign_in_state.dart';
import 'package:construtech/locator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _cpfController = TextEditingController();
  final _passwordController = TextEditingController();

  final _controller = locator.get<SignInController>();

  @override
  void dispose() {
    _nomeController.dispose();
    _cpfController.dispose();
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
        Navigator.pushReplacementNamed(context, NamedRoute.home);
      }
      if (_controller.state is SignInErrorState) {
        Navigator.pop(context);
        customModalBottomSheet(context, SignInError(message: "Erro"));
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
              'Entrar',
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
                  controller: _cpfController,
                  labelText: "CPF",
                  hintText: "Digite seu CPF",
                  validator: Validator.validateEmail,
                ),
                PasswordFormField(
                  controller: _passwordController,
                  labelText: "Senha",
                  hintText: "******",
                  validator: Validator.validatePassword,
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
              text: "Entar",
              onPressed: () {
                final valid =
                    _formKey.currentState != null &&
                    _formKey.currentState!.validate();
                if (valid) {
                  _controller.SignIn(
                    context: context,
                    CPF: _cpfController.text,
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
          Navigator.pushReplacementNamed(context, NamedRoute.signUp),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Não possui uma conta? ',
              style: AppTextStyle.smallText.copyWith(color: AppColors.purple),
              recognizer: TapGestureRecognizer()
                ..onTap = () =>
                    Navigator.popAndPushNamed(context, NamedRoute.signUp),
            ),
            TextSpan(
              children: [TextSpan(text: 'Criar agora')],
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
