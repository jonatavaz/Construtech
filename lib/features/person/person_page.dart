import 'dart:developer';

import 'package:construtech/common/constants/routes.dart';
import 'package:flutter/material.dart';

class PersonPage extends StatefulWidget {
  const PersonPage({super.key});

  @override
  State<PersonPage> createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  
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

  //Timer timer = Timer(const Duration(seconds: 2), () => log('finished'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(
       child: Text("Fornecedores"),
    ));
  }
}