import 'dart:developer';

import 'package:construtech/common/constants/app_colors.dart';
import 'package:construtech/common/constants/app_text_style.dart';
import 'package:construtech/common/constants/routes.dart';
import 'package:construtech/common/widgets/primay_button.dart';
import 'package:construtech/features/sign_up/sign_up_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whitePurple,
      body: Column(
        children: [
          const SizedBox(height: 150.0),
          Expanded(child: Image.asset('assets/images/Construtech_logo.png')),
          Text(
            'Bem vindo ao App',
            textAlign: TextAlign.center,
            style: AppTextStyle.mediumText.copyWith(color: AppColors.purpleOne),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: PrimaryButton(
              text: "Criar agora",
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  NamedRoute.signUp,
                );
              },
            ),
          ),
          CustomTextButton(),
          SizedBox(height: 24.0),
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
      onPressed: () => Navigator.pushReplacementNamed(context, NamedRoute.signIn),
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
