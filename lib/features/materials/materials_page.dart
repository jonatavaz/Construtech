import 'dart:developer';

import 'package:construtech/common/constants/routes.dart';
import 'package:flutter/material.dart';

class MaterialsPage extends StatefulWidget {
  const MaterialsPage({super.key});

  @override
  State<MaterialsPage> createState() => _MaterialsPageState();
}

class _MaterialsPageState extends State<MaterialsPage>{

 

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
       child: Text("Materiais"),
    ));
  }
}