import 'package:construtech/common/constants/app_colors.dart';
import 'package:construtech/common/constants/app_text_style.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: AppColors.purpleGradient,
          ),
        ),
        child: Image.asset('assets/images/Construtech_logo.png'),
      ),
    );
  }
}
