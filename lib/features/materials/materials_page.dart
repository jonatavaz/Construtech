import 'dart:developer';

import 'package:construtech/common/constants/app_colors.dart';
import 'package:construtech/common/constants/app_text_style.dart';
import 'package:construtech/common/constants/routes.dart';
import 'package:construtech/common/exceptions/sizes.dart';
import 'package:flutter/material.dart';

class MaterialsPage extends StatefulWidget {
  const MaterialsPage({super.key});

  @override
  State<MaterialsPage> createState() => _MaterialsPageState();
}

class _MaterialsPageState extends State<MaterialsPage> {
  double get textScaleFactor =>
      MediaQuery.of(context).size.width < 360 ? 0.7 : 1.0;
  double get iconSize => MediaQuery.of(context).size.width < 360 ? 16.0 : 24.0;

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
                      'Materiais',
                      textScaleFactor: textScaleFactor,
                      style: AppTextStyle.mediumText20.apply(
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
                // Container(
                //   padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
                //   decoration: BoxDecoration(
                //     borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                //     color: AppColors.white.withOpacity(0.06),
                //   ),
                //   child: Stack(
                //     alignment: const AlignmentDirectional(0.5, -0.5),
                //     children: [
                //       const Icon(
                //         Icons.person_outline_outlined,
                //         color: AppColors.white,
                //       ),
                //       // Container(width: 8.w, height: 8.w,decoration: BoxDecoration(color: AppC),,)],
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
          //Positioned(
            // left: 0.w,
            // right: 0.w,
            // top: 180.h,
            //child: Container(
              // padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 34.h),
              // decoration: const BoxDecoration(
              //   color: AppColors.white,
              //   borderRadius: BorderRadius.all(Radius.circular(24.0)),
              // ),
              // child: Column(
              //   children: [
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: [
                  //     Column(
                  //       crossAxisAlignment: CrossAxisAlignment.center,
                  //       children: [
                  //         Text(
                  //           'Total a Pagar',
                  //           textScaleFactor: textScaleFactor,
                  //           style: AppTextStyle.smallText.apply(
                  //             color: AppColors.purple,
                  //           ),
                  //         ),
                  //         Text(
                  //           '\$ 500,90',
                  //           textScaleFactor: textScaleFactor,
                  //           style: AppTextStyle.mediumText20.apply(
                  //             color: AppColors.purple,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ],
                  // ),
                  // const SizedBox(height: 24.0),
                  // Row(
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: [
                  //     Expanded(
                  //       child: ElevatedButton(
                  //         onPressed: () {
                  //           print('Botão Depósitos clicado!');
                  //         },
                  //         style: ElevatedButton.styleFrom(
                  //           backgroundColor: AppColors.purple.withOpacity(0.06),
                  //           foregroundColor: AppColors.purple,
                  //           padding: const EdgeInsets.all(10.0),
                  //           shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(16.0),
                  //           ),
                  //           elevation: 0,
                  //         ),
                  //         child: Column(
                  //           mainAxisSize: MainAxisSize.min,
                  //           crossAxisAlignment: CrossAxisAlignment.center,
                  //           children: [
                  //             Row(
                  //               children: [
                  //                 Icon(
                  //                   Icons.arrow_downward,
                  //                   color: AppColors.purple,
                  //                   size: iconSize,
                  //                 ),
                  //                 const SizedBox(width: 10.0),
                  //                 Text(
                  //                   'Depósitos',
                  //                   textScaleFactor: textScaleFactor,
                  //                   style: AppTextStyle.smallText.apply(
                  //                     color: AppColors.purple,
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),

                  //             const SizedBox(height: 4.0),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  // const SizedBox(width: 16.0),

                  //             Expanded(
                  //               child: ElevatedButton(
                  //                 onPressed: () {
                  //                   print('Botão Início obra clicado!');
                  //                 },
                  //                 style: ElevatedButton.styleFrom(
                  //                   backgroundColor: AppColors.purple.withOpacity(0.06),
                  //                   foregroundColor: AppColors.white,
                  //                   padding: const EdgeInsets.all(12.0),
                  //                   shape: RoundedRectangleBorder(
                  //                     borderRadius: BorderRadius.circular(16.0),
                  //                   ),
                  //                   elevation: 0,
                  //                 ),
                  //                 child: Column(
                  //                   mainAxisSize: MainAxisSize.min,
                  //                   crossAxisAlignment: CrossAxisAlignment.center,
                  //                   children: [
                  //                     Row(
                  //                       children: [
                  //                         Icon(
                  //                           Icons.arrow_upward,
                  //                           color: AppColors.purple,
                  //                           size: iconSize,
                  //                         ),
                  //                         const SizedBox(width: 10.0),
                  //                         Text(
                  //                           'Transação',
                  //                           textScaleFactor: textScaleFactor,
                  //                           style: AppTextStyle.smallText.apply(
                  //                             color: AppColors.purple,
                  //                           ),
                  //                         ),
                  //                       ],
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                // ],
              //),
            //),
          //),
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
                          ? "Em estoque"
                          : "Prédio LGA Sul";
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
                          'Bitoneira',
                          style: AppTextStyle.smallText,
                        ),
                        subtitle: const Text(
                          '21/03/2025',
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
