// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:easy_manager/consts.dart';
import 'package:easy_manager/custom_widgets/custom_app_bar.dart';
import 'package:easy_manager/utils/colors.dart';
import 'package:flutter/material.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  List<String> list = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: CustomAppBar(
          title: 'Orçamentos',
          backgroundColor: white,
          callback: () async => Navigator.pop(context),
          svgImage: kpathSvgBudgets,
          heroAnimation: 'Orçamentos'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                    height: 100, width: 200, child: Image.asset(kpathMainLogo)),
              ],
            ),
            Divider(
              color: black,
            ),
            Row(
              children: [
                Text('Cliente: Teste Cliente'),
              ],
            ),
            Row(
              children: [
                Text('Orçamento Nº: Teste Cliente'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
