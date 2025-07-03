// lib/features/materials/materials_page.dart

import 'dart:developer';

import 'package:construtech/common/constants/app_colors.dart';
import 'package:construtech/common/constants/app_text_style.dart';
import 'package:construtech/common/exceptions/sizes.dart'; // Para .h e .w
import 'package:construtech/features/materials/materials_controller.dart'; // Importe o controller
import 'package:construtech/common/models/material.dart'; // Importe o modelo MaterialModel
import 'package:construtech/common/utils/ui_utils.dart'; // Para showAlerts

import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Para Consumer e Provider.of

class MaterialsPage extends StatefulWidget {
  const MaterialsPage({super.key});

  @override
  State<MaterialsPage> createState() => _MaterialsPageState();
}

class _MaterialsPageState extends State<MaterialsPage> {
  // Obtenha a instância do MaterialsController

  double get textScaleFactor =>
      MediaQuery.of(context).size.width < 360 ? 0.7 : 1.0;
  double get iconSize => MediaQuery.of(context).size.width < 360 ? 16.0 : 24.0;

  @override
  void initState() {
    super.initState();
    // Use WidgetsBinding.instance.addPostFrameCallback para garantir que o context está disponível
    WidgetsBinding.instance.addPostFrameCallback((_) {
        Provider.of<MaterialsController>(context, listen: false).GetMateriais(context);
    });
  }

  @override
  void dispose() {
    //_controller.removeListener(_onControllerStateChange); // Remova o listener
    // O Provider cuida do dispose se o controller for registerFactory
    // _controller.dispose();
    super.dispose();
  }

  // void _onControllerStateChange() {
  //   if (!mounted) return; // Evita setState em widget não montado


  //   // Lógica para mostrar/esconder indicadores de carregamento
  //   // if (state is! MaterialsLoadingState) {
  //   //   if (Navigator.of(context, rootNonEphemeral: true).canPop()) {
  //   //     Navigator.of(context, rootNonEphemeral: true).pop();
  //   //   }
  //   // }

  //   if (state is MaterialsLoadingState) {
  //     // Apenas mostra o diálogo se ele ainda não estiver visível
  //     if (ModalRoute.of(context)?.isCurrent != true) {
  //       showDialog(
  //         context: context,
  //         barrierDismissible: false,
  //         builder: (ctx) => const Center(child: CircularProgressIndicator(color: AppColors.purpleOne)),
  //       );
  //     }
  //   } else if (state is MaterialsErrorState) {
  //     showAlerts(context, (state as MaterialsErrorState).message);
  //   } else if (state is MaterialsSuccessState) {
  //     // Opcional: showAlerts(context, 'Materiais carregados com sucesso!');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Cabeçalho com Degradê
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
              ],
            ),
          ),
          Positioned(
            top: 300.h,
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Listagem de Materiais',
                        style: AppTextStyle.mediumText18,
                      ),
                    ],
                  ),
                ),
                Consumer<MaterialsController>(
                  builder: (context, controller, child) {
                    if (controller.state is MaterialsLoadingState) {
                      return const Expanded(child: Center(child: CircularProgressIndicator()));
                    } else if (controller.state is MaterialsErrorState) {
                      return Expanded(
                        child: Center(
                          child: Text(
                            'Erro ao carregar materiais: ${(controller.state as MaterialsErrorState).message}',
                            style: AppTextStyle.smallText.apply(color: Colors.red),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    } else if (controller.state is MaterialsSuccessState && controller.materials.isEmpty) {
                      return const Expanded(
                        child: Center(
                          child: Text(
                            'Nenhum material cadastrado ainda.',
                            style: AppTextStyle.smallText,
                          ),
                        ),
                      );
                    } else if (controller.state is MaterialsSuccessState) {
                      return Expanded(
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount: controller.materials.length,
                          itemBuilder: (context, index) {
                            final material = controller.materials[index];
                            final color = material.unidade > 0 ? Colors.green : Colors.red;
                            final value = material.unidade.toString();

                            return ListTile(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                              leading: Container(
                                decoration: const BoxDecoration(
                                  color: AppColors.whitePurple,
                                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                ),
                                padding: const EdgeInsets.all(8.0),
                                child: const Icon(Icons.category_outlined),
                              ),
                              title: Text(
                                material.nome,
                                style: AppTextStyle.smallText,
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Obra: ${material.nomeObra}',
                                    style: AppTextStyle.smallText13,
                                  ),
                                  Text(
                                    'Cod: ${material.codMaterial}',
                                    style: AppTextStyle.smallText13,
                                  ),
                                ],
                              ),
                              trailing: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '${value} Un.', // Quantidade
                                    style: AppTextStyle.mediumText18.apply(color: color),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    }
                    // Retorno padrão para outros estados (ex: MaterialsInitialState antes do fetch)
                    return const Expanded(child: Center(child: Text('Iniciando busca de materiais...')));
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