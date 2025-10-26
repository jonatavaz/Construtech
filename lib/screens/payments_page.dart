import 'dart:developer';

import 'package:construtech/common/constants/app_colors.dart';
import 'package:construtech/common/constants/app_text_style.dart';
import 'package:construtech/common/constants/routes.dart';
import 'package:construtech/common/exceptions/sizes.dart';
import 'package:construtech/controllers/payments_controller.dart';
import 'package:construtech/models/pagamento.dart';
import 'package:construtech/common/utils/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentsPage extends StatefulWidget {
  const PaymentsPage({super.key});

  @override
  State<PaymentsPage> createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage> {
  late final PaymentsController _controller;

  double get textScaleFactor =>
      MediaQuery.of(context).size.width < 360 ? 0.7 : 1.0;
  double get iconSize => MediaQuery.of(context).size.width < 360 ? 16.0 : 24.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller = Provider.of<PaymentsController>(context, listen: false);
      _controller.addListener(_onControllerStateChange);
      _controller.GetListPagamentos(context);
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
    if (state is! PaymentsLoadingState) {
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
    }

    if (state is PaymentsLoadingState) {
      if (ModalRoute.of(context)?.isCurrent != true) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (ctx) => const Center(
            child: CircularProgressIndicator(color: AppColors.purpleOne),
          ),
        );
      }
    } else if (state is PaymentsErrorState) {
      showAlerts(context, (state as PaymentsErrorState).message);
    } else if (state is PaymentsSuccessState) {}
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
                      'Pagamentos',
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
            left: 0.w,
            right: 0.w,
            top: 180.h,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 34.h),
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.all(Radius.circular(24.0)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Total',
                            textScaleFactor: textScaleFactor,
                            style: AppTextStyle.smallText.apply(
                              color: AppColors.purple,
                            ),
                          ),
                          Consumer<PaymentsController>(
                            builder: (context, controller, child) {
                              final Valor = controller.totalPagamentos
                                  .toStringAsFixed(2)
                                  .replaceAll('.', ',');
                              return Text(
                                'R\$ $Valor',
                                textScaleFactor: textScaleFactor,
                                style: AppTextStyle.mediumText20.apply(
                                  color: AppColors.purple,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            print('Deposito Clicado!');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.purple.withOpacity(0.06),
                            foregroundColor: AppColors.purple,
                            padding: const EdgeInsets.all(10.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            elevation: 0,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.arrow_downward,
                                    color: AppColors.purple,
                                    size: iconSize,
                                  ),
                                  const SizedBox(width: 10.0),
                                  Text(
                                    'Depósitos',
                                    textScaleFactor: textScaleFactor,
                                    style: AppTextStyle.smallText.apply(
                                      color: AppColors.purple,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4.0),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            print('Transação Clicado!');
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
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.arrow_upward,
                                    color: AppColors.purple,
                                    size: iconSize,
                                  ),
                                  const SizedBox(width: 10.0),
                                  Text(
                                    'Transação',
                                    textScaleFactor: textScaleFactor,
                                    style: AppTextStyle.smallText.apply(
                                      color: AppColors.purple,
                                    ),
                                  ),
                                ],
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
                        'Listagem de Pagamentos',
                        style: AppTextStyle.mediumText18,
                      ),
                    ],
                  ),
                ),
                Consumer<PaymentsController>(
                  builder: (context, controller, child) {
                    print('${controller.state.runtimeType}');
                    print('${controller.pagamentos.length}');
                    if (controller.state is PaymentsLoadingState) {
                      return const Expanded(
                        child: Center(child: CircularProgressIndicator()),
                      );
                    } else if (controller.state is PaymentsErrorState) {
                      return Expanded(
                        child: Center(
                          child: Text(
                            'Erro ao carregar pagamentos: ${(controller.state as PaymentsErrorState).message}',
                            style: AppTextStyle.smallText.apply(
                              color: Colors.red,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    } else if (controller.state is PaymentsSuccessState &&
                        controller.pagamentos.isEmpty) {
                      return const Expanded(
                        child: Center(
                          child: Text(
                            'Nenhum pagamento.',
                            style: AppTextStyle.smallText,
                          ),
                        ),
                      );
                    } else if (controller.state is PaymentsSuccessState) {
                      return Expanded(
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount: controller.pagamentos.length,
                          itemBuilder: (context, index) {
                            final pagamento = controller.pagamentos[index];

                            final bool Positivo =
                                (pagamento.valorPago ?? 0) > 0;
                            final color = Positivo ? Colors.green : Colors.red;
                            final value =
                                '\$ ${pagamento.valorPago?.toStringAsFixed(2) ?? '0.00'}';

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
                                child: const Icon(Icons.attach_money_outlined),
                              ),
                              title: Text(
                                pagamento.nomeObra ?? 'Obra Desconhecida',
                                style: AppTextStyle.smallText,
                              ),
                              subtitle: Text(
                                pagamento.dataHoraPagamento ??
                                    'Data Desconhecida',
                                style: AppTextStyle.smallText13,
                              ),
                              trailing: Text(
                                value,
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
                      child: Center(child: Text('Iniciando busca')),
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
