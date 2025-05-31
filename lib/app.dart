import 'package:construtech/features/onboarding/onboarding_page.dart';
import 'package:construtech/features/sign_up/sign_up_page.dart';
import 'package:construtech/features/splash/splash_page.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: SignUpPage(),
    );
  }
}