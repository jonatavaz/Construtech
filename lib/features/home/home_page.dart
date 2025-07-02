import 'dart:developer';

import 'package:construtech/common/constants/app_colors.dart';
import 'package:construtech/common/constants/app_text_style.dart';
import 'package:construtech/common/constants/routes.dart';
import 'package:construtech/common/exceptions/sizes.dart';
import 'package:construtech/features/equipamento/equipamento_page.dart';
import 'package:construtech/features/home/home_controller.dart';
import 'package:construtech/features/home/home_page_view.dart';
import 'package:construtech/common/models/obra.dart';
import 'package:construtech/common/utils/ui_utils.dart';
import 'package:construtech/locator.dart';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double get textScaleFactor =>
      MediaQuery.of(context).size.width < 360 ? 0.7 : 1.0;
  double get iconSize => MediaQuery.of(context).size.width < 360 ? 16.0 : 24.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomeController>(context, listen: false).GetObras(context);
    });
  }

  @override
  void dispose() {
    super.dispose();
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
            left: 24.0,
            right: 24.0,
            top: 74.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Boa tarde',
                      textScaleFactor: textScaleFactor,
                      style: AppTextStyle.smallText.apply(
                        color: AppColors.white,
                      ),
                    ),
                    Text(
                      'Jonata Vaz',
                      textScaleFactor: textScaleFactor,
                      style: AppTextStyle.mediumText20.apply(
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                    color: AppColors.white.withOpacity(0.06),
                  ),
                  child: Stack(
                    alignment: const AlignmentDirectional(0.5, -0.5),
                    children: [
                      const Icon(
                        Icons.person_outline_outlined,
                        color: AppColors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 24.w,
            right: 24.w,
            top: 155.h,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 34.h),
              decoration: const BoxDecoration(
                color: AppColors.purpleOne,
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total Obras',
                            textScaleFactor: textScaleFactor,
                            style: AppTextStyle.mediumText18.apply(
                              color: AppColors.white,
                            ),
                          ),
                          // Use o Consumer para exibir o total de obras
                          Consumer<HomeController>(
                            builder: (context, controller, child) {
                              return Text(
                                controller.obras.length.toString(),
                                textScaleFactor: textScaleFactor,
                                style: AppTextStyle.mediumText20.apply(
                                  color: AppColors.white,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () => log('options'),
                        child: PopupMenuButton<String>(
                          padding: EdgeInsets.zero,
                          child: const Icon(
                            Icons.more_horiz,
                            color: AppColors.white,
                          ),
                          itemBuilder: (context) => [
                            const PopupMenuItem<String>(
                              value: 'search_by_date',
                              height: 24.0,
                              child: Text('Pesquisa por data'),
                            ),
                          ],
                          onSelected: (value) {
                            if (value == 'search_by_date') {
                              log('Pesquisa por data selecionada');
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 36.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            print('Botão Fase final clicado!');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.purple.withOpacity(0.06),
                            foregroundColor: AppColors.white,
                            padding: const EdgeInsets.all(12.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            elevation: 0,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(4.0),
                                decoration: BoxDecoration(
                                  color: AppColors.purple.withOpacity(0.06),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(16.0),
                                  ),
                                ),
                                child: Icon(
                                  Icons.imagesearch_roller_outlined,
                                  color: AppColors.purple,
                                  size: iconSize,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                'Fase final',
                                textScaleFactor: textScaleFactor,
                                style: AppTextStyle.smallText.apply(
                                  color: AppColors.white,
                                ),
                              ),
                              const SizedBox(height: 4.0),
                              Consumer<HomeController>(
                                builder: (context, controller, child) {
                                  return Text(
                                    controller.obras.length.toString(),
                                    textScaleFactor: textScaleFactor,
                                    style: AppTextStyle.mediumText18.apply(
                                      color: AppColors.purple,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            print('Botão Início obra clicado!');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.purple.withOpacity(0.06),
                            foregroundColor: AppColors.white,
                            padding: const EdgeInsets.all(12.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            elevation: 0,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(4.0),
                                decoration: BoxDecoration(
                                  color: AppColors.purple.withOpacity(0.06),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(16.0),
                                  ),
                                ),
                                child: Icon(
                                  Icons.construction,
                                  color: AppColors.purple,
                                  size: iconSize,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                'Início obra',
                                textScaleFactor: textScaleFactor,
                                style: AppTextStyle.smallText.apply(
                                  color: AppColors.white,
                                ),
                              ),
                              const SizedBox(height: 4.0),
                              Consumer<HomeController>(
                                builder: (context, controller, child) {
                                  return Text(
                                    controller.obras.length.toString(),
                                    textScaleFactor: textScaleFactor,
                                    style: AppTextStyle.mediumText18.apply(
                                      color: AppColors.purple,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 450.h,
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Listagem de obras',
                        style: AppTextStyle.mediumText18,
                      ),
                      Text(
                        'Dias para a entrega',
                        style: AppTextStyle.smallText13,
                      ),
                    ],
                  ),
                ),
                Consumer<HomeController>(
                  builder: (context, controller, child) {
                    if (controller.state is HomeLoadingState) {
                      return const Expanded(
                        child: Center(child: CircularProgressIndicator()),
                      );
                    } else if (controller.state is HomeErrorState) {
                      return Expanded(
                        child: Center(
                          child: Text(
                            'Erro ao carregar obras: ${(controller.state as HomeErrorState).message}',
                            style: AppTextStyle.smallText.apply(
                              color: Colors.red,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    } else if (controller.state is HomeSuccessState &&
                        controller.obras.isEmpty) {
                      return const Expanded(
                        child: Center(
                          child: Text(
                            'Nenhuma obra cadastrada ainda.',
                            style: AppTextStyle.smallText,
                          ),
                        ),
                      );
                    } else if (controller.state is HomeSuccessState) {
                      return Expanded(
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount: controller.obras.length,
                          itemBuilder: (context, index) {
                            final obra = controller.obras[index];
                            final color = index % 2 == 0
                                ? Colors.green
                                : Colors.red;
                            String diasParaEntrega = "N/A";
                            try {
                              List<String> dateParts = obra.prazoExecucao.split(
                                '/',
                              );
                              DateTime? prazoDate = DateTime.tryParse(
                                '${dateParts[2]}-${dateParts[1]}-${dateParts[0]}',
                              );
                              if (prazoDate != null) {
                                final Duration remaining = prazoDate.difference(
                                  DateTime.now(),
                                );
                                diasParaEntrega = '${remaining.inDays} dias';
                              }
                            } catch (e) {
                              log(
                                'Erro ao parsear data de prazo: ${obra.prazoExecucao}',
                              );
                            }
                            return ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EquipamentoPage(
                                      codObra: obra.codObra,
                                      nomeObra: obra.nomeObra,
                                    ),
                                  ),
                                );
                              },
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
                                child: const Icon(Icons.home_work_outlined),
                              ),
                              title: Text(
                                obra.nomeObra,
                                style: AppTextStyle.smallText,
                              ),
                              subtitle: Text(
                                obra.prazoExecucao,
                                style: AppTextStyle.smallText13,
                              ),
                              trailing: Text(
                                diasParaEntrega,
                                style: AppTextStyle.mediumText18.apply(
                                  color: color,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                    return const Expanded(
                      child: Center(child: Text('Iniciando...')),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
