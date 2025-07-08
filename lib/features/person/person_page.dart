import 'dart:developer';

import 'package:construtech/common/constants/app_colors.dart';
import 'package:construtech/common/constants/app_text_style.dart';
import 'package:construtech/common/constants/routes.dart';
import 'package:construtech/common/exceptions/sizes.dart';
import 'package:construtech/features/person/person_controller.dart'; // Importe o controller
import 'package:construtech/common/models/fornecedor.dart'; // Importe o modelo Fornecedor
import 'package:construtech/common/utils/ui_utils.dart';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart'; // Para Consumer

class PersonPage extends StatefulWidget {
  const PersonPage({super.key});

  @override
  State<PersonPage> createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  late final PersonController _controller; // Declare como late final

  double get textScaleFactor =>
      MediaQuery.of(context).size.width < 360 ? 0.7 : 1.0;
  double get iconSize => MediaQuery.of(context).size.width < 360 ? 16.0 : 24.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller = Provider.of<PersonController>(context, listen: false); // Obtém via Provider
      _controller.addListener(_onControllerStateChange);
      _controller.fetchFornecedores(context); // Chama para buscar os fornecedores
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_onControllerStateChange);
    _controller.dispose(); // O Provider cuida do dispose se for registerFactory
    super.dispose();
  }

  void _onControllerStateChange() {
    if (!mounted) return;

    final state = _controller.state;

    if (state is! PersonLoadingState) {
      if (Navigator.of(context, ).canPop()) {
        Navigator.of(context, ).pop();
      }
    }

    if (state is PersonLoadingState) {
      if (ModalRoute.of(context)?.isCurrent != true) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (ctx) => const Center(child: CircularProgressIndicator(color: AppColors.purpleOne)),
        );
      }
    } else if (state is PersonErrorState) {
      showAlerts(context, (state as PersonErrorState).message);
    } else if (state is PersonSuccessState) {
    }
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Listagem de Fornecedores',
                        style: AppTextStyle.mediumText18,
                      ),
                    ],
                  ),
                ),
                Consumer<PersonController>(
                  builder: (context, controller, child) {
                    if (controller.state is PersonLoadingState) {
                      return const Expanded(child: Center(child: CircularProgressIndicator()));
                    } else if (controller.state is PersonErrorState) {
                      return Expanded(
                        child: Center(
                          child: Text(
                            'Erro ao carregar fornecedores: ${(controller.state as PersonErrorState).message}',
                            style: AppTextStyle.smallText.apply(color: Colors.red),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    } else if (controller.state is PersonSuccessState && controller.fornecedores.isEmpty) {
                      return const Expanded(
                        child: Center(
                          child: Text(
                            'Nenhum fornecedor cadastrado ainda.',
                            style: AppTextStyle.smallText,
                          ),
                        ),
                      );
                    } else if (controller.state is PersonSuccessState) {
                      return Expanded(
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount: controller.fornecedores.length,
                          itemBuilder: (context, index) {
                            final fornecedor = controller.fornecedores[index];
                             final color = (fornecedor.avaliacao == 'Excelente' || fornecedor.avaliacao == 'Bom') ? Colors.green : Colors.red;
                            return ListTile(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                              leading: Container(
                                decoration: const BoxDecoration(
                                  color: AppColors.whitePurple,
                                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                ),
                                padding: const EdgeInsets.all(8.0),
                                child: const Icon(Icons.person_outline_outlined),
                              ),
                              title: Text(
                                fornecedor.nome,
                                style: AppTextStyle.smallText,
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Avaliação: ${fornecedor.avaliacao}',
                                    style: AppTextStyle.smallText13.apply(color: color),
                                  ),
                                  
                                ],
                              ),
                              trailing: Text(
                                'Cód: ${fornecedor.codFornecedor}',
                                style: AppTextStyle.mediumText18.apply(color: AppColors.purple),
                              ),
                            );
                          },
                        ),
                      );
                    }
                    return const Expanded(child: Center(child: Text('Iniciando busca de fornecedores...')));
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