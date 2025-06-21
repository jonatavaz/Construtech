import 'dart:math';

import 'package:construtech/common/constants/app_colors.dart';
import 'package:construtech/common/widgets/custom_bottom_app_bar.dart';
import 'package:construtech/features/home/home_form_page.dart';
import 'package:construtech/features/home/home_page.dart';
import 'package:construtech/features/materials/materials_form_page.dart';
import 'package:construtech/features/materials/materials_page.dart';
import 'package:construtech/features/payments/payments_form_page.dart';
import 'package:construtech/features/payments/payments_page.dart';
import 'package:construtech/features/person/person_form_page.dart';
import 'package:construtech/features/person/person_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  final pageController = PageController();
  int _pageIndex = 0; 

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      if (pageController.page?.round() != _pageIndex) {
        setState(() {
          _pageIndex = pageController.page!.round();
        });
      }
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void _showFormForCurrentPage(BuildContext context) {
    Widget formPage;
    String formTitle = '';

    switch (_pageIndex) {
      case 0: 
        formPage = const HomeFormPage();
        formTitle = 'Cadastrar Obras';
        break;
      case 1: 
        formPage = const MaterialsFormPage(); 
        formTitle = 'Cadastrar Materiais';
        break;
      case 2: 
        formPage = const PaymentsFormPage(); 
        formTitle = 'Registrar Pagamento';
        break;
      case 3: 
        formPage = const PersonFormPage(); 
        formTitle = 'Cadastrar Pessoa';
        break;
      default:
        formPage = const Center(child: Text('Nenhum formulário disponível para esta página.'));
        formTitle = 'Formulário';
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true, 
      builder: (BuildContext ctx) {
        return Container(
          height: MediaQuery.of(ctx).size.height * 0.9, 
          padding: const EdgeInsets.all(16.0),
          child: formPage,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: const [
          HomePage(),
          MaterialsPage(),
          PaymentsPage(),
          PersonPage(),
          
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.purpleOne,
        onPressed: () => _showFormForCurrentPage(context),
        child: const Icon(Icons.add),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.0)
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomAppBar(
        selectedItemColor: AppColors.purpleOne,
        currentIndex: _pageIndex, 
        onItemSelected: (index) { 
          setState(() {
            _pageIndex = index; 
            pageController.jumpToPage(index); 
          });
        },
        children: [
          CustomBottomAppBarItem(
            label: 'Home',
            primaryIcon: Icons.home_work_outlined,
            secondaryIcon: Icons.home_work_outlined,
            onPressed: () => pageController.jumpToPage(0),
          ),
          CustomBottomAppBarItem(
            label: 'Materials',
            primaryIcon: Icons.handyman_outlined,
            secondaryIcon: Icons.handyman_outlined,
            onPressed: () => pageController.jumpToPage(1),
          ),
          CustomBottomAppBarItem.empty(), 
          CustomBottomAppBarItem(
            label: 'Payments', 
            primaryIcon: Icons.account_balance_wallet_outlined,
            secondaryIcon: Icons.account_balance_wallet_outlined,
            onPressed: () => pageController.jumpToPage(2),
          ),
          CustomBottomAppBarItem(
            label: 'Profile',
            primaryIcon: Icons.group_add_outlined,
            secondaryIcon: Icons.group_add_outlined,
            onPressed: () => pageController.jumpToPage(3),
          ),
        ],
      ),
    );
  }
}