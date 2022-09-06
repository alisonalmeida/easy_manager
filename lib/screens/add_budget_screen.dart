// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:easy_manager/consts.dart';
import 'package:easy_manager/custom_widgets/custom_app_bar.dart';
import 'package:easy_manager/custom_widgets/custom_button_add.dart';
import 'package:easy_manager/custom_widgets/custom_modal_bottom_sheet_customer.dart';
import 'package:easy_manager/custom_widgets/custom_modal_bottom_sheet_product.dart';
import 'package:easy_manager/custom_widgets/custom_text_field_with_data.dart';
import 'package:easy_manager/main.dart';
import 'package:easy_manager/screens/budget_screen.dart';
import 'package:easy_manager/utils/colors.dart';
import 'package:flutter/material.dart';

class AddBudgetScreen extends StatefulWidget {
  const AddBudgetScreen({super.key, this.id});
  final String? id;

  @override
  State<AddBudgetScreen> createState() => _AddBudgetScreenState();
}

class _AddBudgetScreenState extends State<AddBudgetScreen> {
  late Stream<List<Map<String, String>>?> customerStream;
  String customerName = '';

  @override
  void initState() {
    customerStream = gSheetDb.getAllCustomers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: CustomAppBar(
          title: BudgetssScreen.name,
          backgroundColor: white,
          callback: () async => Navigator.pop(context),
          svgImage: kpathSvgBudgets,
          heroAnimation: BudgetssScreen.name),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SingleChildScrollView(
            child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  child: SizedBox(
                      height: 100,
                      width: 200,
                      child: Image.asset(kpathMainLogo)),
                ),
              ],
            ),
            Divider(color: black),
            CustomAddButton(
              text: 'Adicionar Item',
              onTap: () {
                showProductChoiceDialog(context);
              },
            ),
            Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: {
                0: FlexColumnWidth(2.0),
                1: FlexColumnWidth(0.5),
                2: FlexColumnWidth(0.5),
              },
              border: TableBorder.all(),
              children: [
                TableRow(children: [
                  Text(
                    'Descrição',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Qtd',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Valor Unitário',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ]),
                TableRow(children: [
                  Text(
                    'Descrasasdasdasdsad asd asasd asdas dasd asdad asdasd asd asdas dasdsdasdasdasdição',
                  ),
                  Text(
                    '1',
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Valor Unitário',
                    textAlign: TextAlign.center,
                  ),
                ]),
              ],
            ),
          ],
        )),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {}),
    );
  }
}
