import 'dart:math';

import 'package:construtech/common/constants/app_colors.dart';
import 'package:construtech/common/widgets/custom_bottom_app_bar.dart';
import 'package:construtech/features/home/home_page.dart';
import 'package:construtech/features/materials/materials_page.dart';
import 'package:construtech/features/payments/payments_page.dart';
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

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      //log(pageController.page.toString());
    });
  }

  @override
  // TODO: implement widget
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
        onPressed: () {},
        child: const Icon(Icons.add),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.0)
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomAppBar(
        selectedItemColor: AppColors.purpleOne,
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
          CustomBottomAppBarItem(
            label: 'payments',
            primaryIcon: Icons.account_balance_wallet_outlined,
            secondaryIcon: Icons.account_balance_wallet_outlined,
            onPressed: () => pageController.jumpToPage(2),
          ),
          CustomBottomAppBarItem(
            label: 'profile',
            primaryIcon: Icons.group_add_outlined,
            secondaryIcon: Icons.group_add_outlined,
            onPressed: () => pageController.jumpToPage(3),
          ),
        ],
      ),
    );
  }
}

