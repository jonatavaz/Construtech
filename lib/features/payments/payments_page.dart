import 'dart:developer';

import 'package:construtech/common/constants/app_colors.dart';
import 'package:construtech/common/constants/app_text_style.dart';
import 'package:construtech/common/constants/routes.dart';
import 'package:construtech/common/exceptions/sizes.dart';
import 'package:construtech/features/payments/payments_controller.dart';
import 'package:construtech/common/models/pagamento.dart';
import 'package:construtech/common/utils/ui_utils.dart';
import 'package:construtech/locator.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class PaymentsPage extends StatefulWidget {
  const PaymentsPage({super.key});

  @override
  State<PaymentsPage> createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage> {
  final _controller = locator.get<PaymentsController>();

  double get textScaleFactor =>
      MediaQuery.of(context).size.width < 360 ? 0.7 : 1.0;
  double get iconSize => MediaQuery.of(context).size.width < 360 ? 16.0 : 24.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.fetchPagamentos(context); 
    });
  }

  @override
  void dispose() {
    _controller.dispose();
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
                            'Total a Pagar',
                            textScaleFactor: textScaleFactor,
                            style: AppTextStyle.smallText.apply(
                              color: AppColors.purple,
                            ),
                          ),
                          Text(
                            '\$ 500,90',
                            textScaleFactor: textScaleFactor,
                            style: AppTextStyle.mediumText20.apply(
                              color: AppColors.purple,
                            ),
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
                          onPressed: () { print('Botão Depósitos clicado!'); },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.purple.withOpacity(0.06),
                            foregroundColor: AppColors.purple,
                            padding: const EdgeInsets.all(10.0),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
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
                                  Icon(Icons.arrow_downward, color: AppColors.purple, size: iconSize),
                                  const SizedBox(width: 10.0),
                                  Text('Depósitos', textScaleFactor: textScaleFactor, style: AppTextStyle.smallText.apply(color: AppColors.purple)),
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
                          onPressed: () { print('Botão Transação clicado!'); },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.purple.withOpacity(0.06),
                            foregroundColor: AppColors.white,
                            padding: const EdgeInsets.all(12.0),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
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
                                  Icon(Icons.arrow_upward, color: AppColors.purple, size: iconSize),
                                  const SizedBox(width: 10.0),
                                  Text('Transação', textScaleFactor: textScaleFactor, style: AppTextStyle.smallText.apply(color: AppColors.purple)),
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
                        'Histórico de Pagamentos',
                        style: AppTextStyle.mediumText18,
                      ),
                    ],
                  ),
                ),
                Consumer<PaymentsController>(
                  builder: (context, controller, child) {
                    print('Consumer: Reconstruindo com estado: ${controller.state.runtimeType}');
                            print('Consumer: Quantidade de pagamentos: ${controller.pagamentos.length}');
                    if (controller.state is PaymentsLoadingState) {
                      return const Expanded(child: Center(child: CircularProgressIndicator()));
                    } else if (controller.state is PaymentsErrorState) {
                      return Expanded(
                        child: Center(
                          child: Text(
                            'Erro ao carregar pagamentos: ${(controller.state as PaymentsErrorState).message}',
                            style: AppTextStyle.smallText.apply(color: Colors.red),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    } else if (controller.state is PaymentsSuccessState && controller.pagamentos.isEmpty) {
                      return const Expanded(
                        child: Center(
                          child: Text(
                            'Nenhum pagamento registrado ainda.',
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
                            final color = pagamento.valorPago > 0 ? Colors.green : Colors.red;
                            //final value = '\$ ${pagamento.valorPago.toStringAsFixed(2)}';
                            
                            
                            return ListTile(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                              leading: Container(
                                decoration: const BoxDecoration(
                                  color: AppColors.whitePurple,
                                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                ),
                                padding: const EdgeInsets.all(8.0),
                                child: const Icon(Icons.attach_money_outlined),
                              ),
                              title: Text(
                                pagamento.nomeObra,
                                style: AppTextStyle.smallText,
                              ),
                              subtitle: Text(
                                pagamento.dataHoraPagamento,
                                style: AppTextStyle.smallText13,
                              ),
                              trailing: Text(
                                pagamento.valorPago.toStringAsFixed(2),
                                style: AppTextStyle.mediumText18.apply(color: color),
                              ),
                            );
                          },
                        ),
                      );
                    }
                    return const Expanded(child: Center(child: Text('Iniciando busca de pagamentos...')));
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