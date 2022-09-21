// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:easy_manager/consts.dart';
import 'package:easy_manager/custom_widgets/button_round_with_shadow.dart';
import 'package:easy_manager/custom_widgets/custom_modal_bottom_sheet_customer.dart';
import 'package:easy_manager/custom_widgets/custom_search_text_field.dart';
import 'package:easy_manager/main.dart';
import 'package:easy_manager/models/budget.dart';
import 'package:easy_manager/models/product.dart';
import 'package:easy_manager/utils/colors.dart';
import 'package:flutter/material.dart';

class AddBudgetScreen extends StatefulWidget {
  const AddBudgetScreen({Key? key, this.budgetId}) : super(key: key);
  final String? budgetId;

  @override
  State<AddBudgetScreen> createState() => _AddBudgetScreenState();
}

class _AddBudgetScreenState extends State<AddBudgetScreen> {
  String customerName = '';
  Budget budget = Budget();
  TextEditingController searchController = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    budget.id = widget.budgetId == null ? '' : widget.budgetId!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: budgetBackgroundColor,
      appBar: AppBar(
        backgroundColor: budgetBackgroundColor,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: ButtonRoundWithShadow(
              borderColor: black,
              shadowColor: black,
              color: white,
              iconPath: kpathSvgArrowBack,
              size: 30,
              callback: () => Navigator.pop(context)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: ShapeDecoration(shadows: const [
                      BoxShadow(
                        color: Colors.black,
                        offset: Offset(
                          3.0,
                          4.0,
                        ),
                      )
                    ], color: Colors.white, shape: Border.all()),
                    child: SizedBox(
                        height: 100,
                        width: 200,
                        child: Image.asset(kpathMainLogo)),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: ShapeDecoration(shadows: const [
                BoxShadow(
                  color: Colors.black,
                  offset: Offset(
                    3.0,
                    4.0,
                  ),
                )
              ], color: Colors.white, shape: Border.all()),
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      'Cliente: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
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
                            showGeneralLoading(context);
                            customerName =
                                await showCustomerChoiceDialog(context);

                            budget.nomeCliente = customerName;
                            await gSheetDb.putBudget(budget);
                            if (mounted) {
                              Navigator.pop(context);
                            }

                            setState(() {});
                          },
                          icon: Icon(Icons.person),
                        ),
                ],
              ),
            ),
            SearchTextField(
              clearField: () {
                searchController.clear();
              },
              focusNode: focusNode,
              searchController: searchController,
              onChanged: (v) {
                setState(() {});
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: white, foregroundColor: black),
              child: Text('Adicionar Novo Produto'),
              onPressed: () {
                // showProductChoiceBottomSheet(context, listProducts);
              },
            ),
            Expanded(
                child: FutureBuilder(
              future: gSheetDb.getProducts(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var listProducts = snapshot.data as List<Map<String, String>>;

                  if (budget.listaProdutos == null) {
                    budget.listaProdutos = [];
                    for (var element in listProducts) {
                      budget.listaProdutos!.add({element['nome']!: 0});
                    }
                  } else {}

                  var iterableProducts = budget.listaProdutos!.expand(
                    (element) {
                      return element.keys;
                    },
                  );
                  var iterableQuantity =
                      budget.listaProdutos!.expand((element) => element.values);
                  var lenghtList = budget.listaProdutos!.length;
                  return ListView.builder(
                    itemCount: lenghtList,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Card(
                            child: ListTile(
                              title: Text(iterableProducts.elementAt(index)),
                              subtitle: Text(
                                  'R\$ ${listProducts.elementAt(index)['valorVenda']}'),
                              trailing: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: productBackgroundColorShadow),
                                  shape: BoxShape.rectangle,
                                ),
                                child: Wrap(
                                  children: [
                                    TextButton(
                                      onPressed: () {},
                                      child: Text('-',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  productBackgroundColorShadow)),
                                    ),
                                    Text(
                                      iterableQuantity
                                          .elementAt(index)
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        budget.addIncrementProduct(
                                            iterableProducts.elementAt(index));
                                        showGeneralLoading(context);
                                        await gSheetDb.putBudget(budget);

                                        if (mounted) {
                                          Navigator.pop(context);
                                        }
                                        setState(() {});
                                      },
                                      child: Text(
                                        '+',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                productBackgroundColorShadow),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  return Center(child: CircularProgressIndicator(color: black));
                }
              },
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          setState(() {});
          showGeneralLoading(context);

          if (mounted) {
            Navigator.pop(context);
          }
        },
        child: Icon(Icons.save),
      ),
    );
  }
}
