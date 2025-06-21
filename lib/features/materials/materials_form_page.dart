import 'dart:developer';

import 'package:flutter/material.dart';

class MaterialsFormPage extends StatefulWidget {
  const MaterialsFormPage({super.key});

  @override
  State<MaterialsFormPage> createState() => _MaterialsFormPageState();
}

class _MaterialsFormPageState extends State<MaterialsFormPage>{


  @override
  Widget build(BuildContext context) {

    return Scaffold(body: Center(
       child: Text("Material"),
    ));
  }
}