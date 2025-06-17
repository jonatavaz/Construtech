import 'dart:async';

import 'package:construtech/common/constants/app_colors.dart';
import 'package:construtech/common/constants/app_text_style.dart';
import 'package:construtech/common/constants/routes.dart';
import 'package:construtech/features/onboarding/onboarding_page.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  

  @override
  State<SplashPage> createState() => _SplashPageState();
  
}

class _SplashPageState extends State<SplashPage> {
  
  @override
  void initState() {
    super.initState();
    init();
  }

  Timer init() {
    return Timer(Duration(seconds: 2), navigateToOnborarding);
  }

  void navigateToOnborarding() {
    Navigator.pushReplacementNamed(
      context,
      NamedRoute.initial,
    );
  }

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
