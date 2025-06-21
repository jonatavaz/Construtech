import 'dart:developer';

import 'package:flutter/material.dart';

class PersonFormPage extends StatefulWidget {
  const PersonFormPage({super.key});

  @override
  State<PersonFormPage> createState() => _PersonFormPageState();
}

class _PersonFormPageState extends State<PersonFormPage>{


  @override
  Widget build(BuildContext context) {

    return Scaffold(body: Center(
       child: Text("Pagamentos"),
    ));
  }
}