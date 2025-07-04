import 'package:construtech/common/constants/routes.dart';
import 'package:construtech/features/equipamento/equipamento_controller.dart';
import 'package:construtech/features/equipamento/equipamento_page.dart';
import 'package:construtech/features/home/home_controller.dart';
import 'package:construtech/features/home/home_form_page.dart';
import 'package:construtech/features/home/home_page.dart';
import 'package:construtech/features/home/home_page_view.dart';
import 'package:construtech/features/materials/materials_controller.dart';
import 'package:construtech/features/materials/materials_form_page.dart';
import 'package:construtech/features/materials/materials_page.dart';
import 'package:construtech/features/onboarding/onboarding_page.dart';
import 'package:construtech/features/payments/forms/payments_form_page.dart';
import 'package:construtech/features/payments/payments_controller.dart';
import 'package:construtech/features/payments/payments_page.dart';
import 'package:construtech/features/person/person_form_page.dart';
import 'package:construtech/features/person/person_page.dart';
import 'package:construtech/features/sign_in/sign_in_page.dart';
import 'package:construtech/features/sign_up/sign_up_page.dart';
import 'package:construtech/features/splash/splash_page.dart';
import 'package:construtech/locator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeController>(
          create: (_) => locator<HomeController>(),
        ),
        ChangeNotifierProvider<EquipamentoController>(
          create: (_) => locator<EquipamentoController>(),
        ),
        ChangeNotifierProvider<MaterialsController>(
          create: (_) => locator<MaterialsController>(),
        ),
        ChangeNotifierProvider<PaymentsController>(
          create: (_) => locator<PaymentsController>(),
        ),
      ],
      child: MaterialApp(
        initialRoute: NamedRoute.splash,
        routes: {
          NamedRoute.initial: (context) => const OnboardingPage(),
          NamedRoute.splash: (context) => const SplashPage(),
          NamedRoute.signUp: (context) => const SignUpPage(),
          NamedRoute.signIn: (context) => const SignInPage(),
          NamedRoute.home: (context) => const HomePageView(), 
          //NamedRoute.payments: (context) => const PaymentsPage(),
          NamedRoute.materials: (context) => const MaterialsPage(),
          NamedRoute.person: (context) => const PersonPage(),
          NamedRoute.homeFormPage: (context) => const HomeFormPage(),
          NamedRoute.materialsFormPage: (context) => const MaterialsFormPage(),
          NamedRoute.paymentsFormPage: (context) => const PaymentsFormPage(),
          NamedRoute.personFormPage: (context) => const PersonPage(), 
         },
      ),
    );
  }
}