import 'dart:developer';

import 'package:flutter/material.dart';

class PaymentsFormPage extends StatefulWidget {
  const PaymentsFormPage({super.key});

  @override
  State<PaymentsFormPage> createState() => _PaymentsFormPageState();
}

class _PaymentsFormPageState extends State<PaymentsFormPage>{


  @override
  Widget build(BuildContext context) {

    return Scaffold(body: Center(
       child: Text("Pagamentos"),
    ));
  }
}