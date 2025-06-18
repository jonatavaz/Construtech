import 'dart:developer';

import 'package:construtech/common/constants/routes.dart';
import 'package:flutter/material.dart';

class PaymentsPage extends StatefulWidget {
  const PaymentsPage({super.key});

  @override
  State<PaymentsPage> createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage>{

  @override
  void dispose() {
    log('disposed');
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    log('init');
    //timer;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(
       child: Text("Pagamentos"),
    ));
  }
}