import 'dart:developer';

import 'package:construtech/common/constants/app_colors.dart';
import 'package:construtech/common/constants/app_text_style.dart';
import 'package:construtech/common/constants/routes.dart';
import 'package:construtech/common/exceptions/sizes.dart';
import 'package:flutter/material.dart';

class PersonPage extends StatefulWidget {
  const PersonPage({super.key});

  @override
  State<PersonPage> createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  get textScaleFactor => null;

  
  @override
  void dispose() {
    log('disposed');
    super.dispose();
  }

  @override
  void initState() {
    
    super.initState();
    log('init');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: AppColors.purpleGradient,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.elliptical(500, 30),
                  bottomRight: Radius.elliptical(500, 30),
                ),
              ),
              height: 287.h,
            ),
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            top: 80.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Fornecedores',
                      textScaleFactor: textScaleFactor,
                      style: AppTextStyle.mediumText20.apply(
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          Positioned(
            top: 397.h,
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      final color = index % 2 == 0 ? Colors.green : Colors.red;
                      final value = index % 2 == 0
                          ? "Pedido entregue"
                          : "Em atraso";
                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                        ),
                        leading: Container(
                          decoration: const BoxDecoration(
                            color: AppColors.whitePurple,
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                          ),
                          padding: const EdgeInsets.all(8.0),
                          child: const Icon(Icons.handyman_outlined),
                        ),
                        title: const Text(
                          'ABC da Construção',
                          style: AppTextStyle.smallText,
                        ),
                        subtitle: const Text(
                          '17/03/2025',
                          style: AppTextStyle.smallText13,
                        ),
                        trailing: Text(
                          value,
                          style: AppTextStyle.mediumText18.apply(color: color),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}