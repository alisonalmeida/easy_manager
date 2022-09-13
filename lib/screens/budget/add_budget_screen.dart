// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:easy_manager/consts.dart';
import 'package:easy_manager/custom_widgets/custom_app_bar.dart';
import 'package:easy_manager/custom_widgets/custom_modal_bottom_sheet_customer.dart';
import 'package:easy_manager/custom_widgets/custom_modal_bottom_sheet_product.dart';
import 'package:easy_manager/main.dart';
import 'package:easy_manager/models/product_model.dart';
import 'package:easy_manager/screens/budget/budget_screen.dart';
import 'package:easy_manager/utils/colors.dart';
import 'package:flutter/material.dart';

class AddBudgetScreen extends StatefulWidget {
  const AddBudgetScreen({Key? key}) : super(key: key);

  @override
  State<AddBudgetScreen> createState() => _AddBudgetScreenState();
}

class _AddBudgetScreenState extends State<AddBudgetScreen> {
  Future<List<Map<String, String>>>? productsStream = gSheetDb.getProducts();

  String customerName = '';
  List<Widget> list = [
    Text(
      'Descrasasdasdasdsad ao',
    ),
    Text(
      '1',
      textAlign: TextAlign.center,
    ),
    Text(
      'Valor Unitário',
      textAlign: TextAlign.center,
    ),
  ];

  TableRow titleTableRow = TableRow(children: [
    Text(
      'Produtos',
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
  ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: CustomAppBar(
          title: BudgetsScreen.name,
          backgroundColor: white,
          callback: () async => Navigator.pop(context),
          svgImage: kpathSvgBudgets,
          heroAnimation: BudgetsScreen.name),
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
              Row(
                children: [
                  Flexible(
                    child: Text('Cliente: '),
                  ),
                  customerName.isNotEmpty
                      ? Flexible(
                          child: Row(
                            children: [
                              Flexible(
                                child: Text(
                                  customerName,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  customerName = '';
                                  setState(() {});
                                },
                                icon: Icon(Icons.clear),
                              )
                            ],
                          ),
                        )
                      : ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: customerBackgroundColor,
                              foregroundColor: black),
                          label: Text('Escolher'),
                          onPressed: () async {
                            customerName =
                                await showCustomerChoiceDialog(context);
                            setState(() {});
                          },
                          icon: Icon(Icons.person),
                        ),
                ],
              ),
              Divider(color: black),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: productBackgroundColor,
                    foregroundColor: black),
                child: Text('Adicionar Produto'),
                onPressed: () async {
                  var v = await showProductChoiceDialog(context);
                  print(v);
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
                  titleTableRow,
                  TableRow(children: list),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.save),
      ),
    );
  }
}
