import 'dart:developer';

import 'package:construtech/common/constants/app_colors.dart';
import 'package:construtech/common/constants/app_text_style.dart';
import 'package:construtech/common/constants/routes.dart';
import 'package:construtech/common/exceptions/sizes.dart';
import 'package:construtech/features/equipamento/equipamento_controller.dart';
import 'package:construtech/common/models/equipamento.dart';
import 'package:construtech/common/utils/ui_utils.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EquipamentoPage extends StatefulWidget {
  final int codObra;
  final String nomeObra;

  const EquipamentoPage({
    Key? key,
    required this.codObra,
    required this.nomeObra,
  }) : super(key: key);

  @override
  State<EquipamentoPage> createState() => _EquipamentoPageState();
}

class _EquipamentoPageState extends State<EquipamentoPage> {
  late final EquipamentoController _controller;

  double get textScaleFactor => MediaQuery.of(context).size.width < 360 ? 0.7 : 1.0;
  double get iconSize => MediaQuery.of(context).size.width < 360 ? 16.0 : 24.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller = Provider.of<EquipamentoController>(context, listen: false);
      _controller.addListener(_onControllerStateChange);
      _controller.fetchEquipamentos(context, widget.codObra);
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_onControllerStateChange);
    super.dispose();
  }

  void _onControllerStateChange() {
    if (!mounted) return;

    final state = _controller.state;
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
                      'Equipamentos da Obra',
                      textScaleFactor: textScaleFactor,
                      style: AppTextStyle.mediumText20.apply(
                        color: AppColors.white,
                      ),
                    ),
                    Text(
                      widget.nomeObra,
                      textScaleFactor: textScaleFactor,
                      style: AppTextStyle.smallText.apply(
                        color: AppColors.white.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          Positioned(
            top: 280.h,
            left: 0,
            right: 0,
            bottom: 0, 
            child: Column( 
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Listagem de Equipamentos',
                        style: AppTextStyle.mediumText18,
                      ),
                    ],
                  ),
                ),
                
                Consumer<EquipamentoController>(
                  builder: (context, controller, child) {
                    if (controller.state is EquipamentoLoadingState) {
                      return const Expanded(child: Center(child: CircularProgressIndicator()));
                    } else if (controller.state is EquipamentoErrorState) {
                      return Expanded(
                        child: Center(
                          child: Text(
                            'Erro ao carregar equipamentos: ${(controller.state as EquipamentoErrorState).message}',
                            style: AppTextStyle.smallText.apply(color: Colors.red),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    } else if (controller.state is EquipamentoSuccessState && controller.equipamentos.isEmpty) {
                      return const Expanded(
                        child: Center(
                          child: Text(
                            'Nenhum equipamento nessa obra.',
                            style: AppTextStyle.smallText,
                          ),
                        ),
                      );
                    } else if (controller.state is EquipamentoSuccessState) {
                      return Expanded(
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount: controller.equipamentos.length,
                          itemBuilder: (context, index) {
                            final equipamento = controller.equipamentos[index];
                            final color = equipamento.disponibilidadeObra == 'Em Estoque' ? Colors.green : Colors.red;
                            final value = equipamento.disponibilidadeObra;

                            return ListTile(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                              leading: Container(
                                decoration: const BoxDecoration(
                                  color: AppColors.whitePurple,
                                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                ),
                                padding: const EdgeInsets.all(8.0),
                                child: const Icon(Icons.handyman_outlined),
                              ),
                              title: Text(
                                equipamento.nomeEquipamento,
                                style: AppTextStyle.smallText,
                              ),
                              subtitle: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Obra: ${equipamento.nomeObra}',
                                    style: AppTextStyle.smallText13,
                                  ),
                                  Text(
                                    'Custo/Hora: \$${equipamento.custoHora.toStringAsFixed(2)}',
                                    style: AppTextStyle.smallText13,
                                  ),
                                  if (equipamento.dataAlocacao != null && equipamento.dataAlocacao!.isNotEmpty)
                                    Text(
                                      'Alocado em: ${equipamento.dataAlocacao}',
                                      style: AppTextStyle.smallText13,
                                    ),
                                  if (equipamento.dataRetorno != null && equipamento.dataRetorno!.isNotEmpty)
                                    Text(
                                      'Retorno em: ${equipamento.dataRetorno}',
                                      style: AppTextStyle.smallText13,
                                    ),
                                ],
                              ),
                              trailing: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    value,
                                    style: AppTextStyle.mediumText18.apply(color: color),
                                  ),
                                  if (equipamento.manutencao)
                                    Text(
                                      'Em Manutenção',
                                      style: AppTextStyle.smallText13.apply(color: Colors.orange),
                                    ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    }
                    return const Expanded(child: Center(child: Text('Buscando de equipamentos.')));
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