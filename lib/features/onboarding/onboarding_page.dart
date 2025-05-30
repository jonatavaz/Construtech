import 'dart:developer';

import 'package:construtech/common/constants/app_colors.dart';
import 'package:construtech/common/constants/app_text_style.dart';
import 'package:construtech/common/widgets/primay_button.dart';
import 'package:flutter/material.dart';

class OnrboardingPage extends StatelessWidget {
  const OnrboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whitePurple,
      body: Align(
        child: Column(
          children: [
            const SizedBox(height: 150.0),
            Expanded(
              flex: 2,
              child: Image.asset('assets/images/Construtech_logo.png'),
            ),
            Text(
              'Bem vindo ao App',
              style: AppTextStyle.mediumText.copyWith(
                color: AppColors.purpleOne,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: PrimaryButton(text: "Criar agora", onPressed: () {},),
            ),
            Text(
              'Possui uma conta? Login',
              style: AppTextStyle.smallText.copyWith(color: AppColors.purple),
            ),
            SizedBox(height: 24.0),
          ],
        ),
      ),
    );
  }
}
