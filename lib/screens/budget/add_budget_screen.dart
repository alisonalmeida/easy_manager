// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:easy_manager/consts.dart';
import 'package:easy_manager/custom_widgets/button_round_with_shadow.dart';
import 'package:easy_manager/custom_widgets/custom_modal_bottom_sheet_customer.dart';
import 'package:easy_manager/custom_widgets/custom_search_text_field.dart';
import 'package:easy_manager/main.dart';
import 'package:easy_manager/models/budget.dart';
import 'package:easy_manager/models/item_budget.dart';
import 'package:easy_manager/models/product.dart';
import 'package:easy_manager/screens/product/crud_product_screen.dart';
import 'package:easy_manager/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddBudgetScreen extends StatefulWidget {
  const AddBudgetScreen({Key? key, this.budget, required this.isUpdate})
      : super(key: key);
  final Budget? budget;
  final bool isUpdate;

  @override
  State<AddBudgetScreen> createState() => _AddBudgetScreenState();
}

class _AddBudgetScreenState extends State<AddBudgetScreen> {
  TextEditingController searchController = TextEditingController();
  FocusNode focusNode = FocusNode();
  double totalValue = 0;
  bool listReverse = true;
  bool isSearching = false;
  List<Map<String, String>> listProducts = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    focusNode.dispose();
    searchController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: budgetBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Container(
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
          child: Text(
            'R\$ ${widget.budget!.valorTotal}',
            textAlign: TextAlign.end,
            style: TextStyle(
              color: black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
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
              callback: () async => Navigator.of(context).pop(true)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
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
                  widget.budget!.nomeCliente!.isNotEmpty
                      ? Flexible(
                          child: Row(
                            children: [
                              Flexible(
                                child: Text(
                                  widget.budget!.nomeCliente!,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  showGeneralLoading(context);
                                  widget.budget!.nomeCliente = '';

                                  await gSheetDb.putBudget(widget.budget!);
                                  if (mounted) {
                                    Navigator.pop(context);
                                  }

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

                            var name = await showCustomerChoiceDialog(context);
                            widget.budget!.changeCustomerName(name);

                            await gSheetDb.putBudget(widget.budget!);
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
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CrudProductScreen()),
                );
                setState(() {});
              },
            ),
            Expanded(child: _futureBuilder())
          ],
        ),
      ),
      persistentFooterButtons: [
        Consumer(
          builder: (context, ref, child) => IconButton(
              onPressed: () {
                listReverse = !listReverse;
                ref.refresh(productsProvider);
              },
              icon: Icon(Icons.filter_alt)),
        ),
        Consumer(
          builder: (context, ref, child) => IconButton(
              onPressed: () {
                ref.refresh(productsProvider);
                isSearching = !isSearching;
                focusNode.requestFocus();
              },
              icon: Icon(Icons.search)),
        )
      ],
    );
  }

  Widget _futureBuilder() {
    return FutureBuilder(
      future: gSheetDb.getProducts(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          listProducts = snapshot.data as List<Map<String, String>>;
          listReverse ? listProducts = listProducts.reversed.toList() : null;
          isSearching
              ? listProducts = listProducts
                  .where((element) => element['nome']
                      .toString()
                      .toLowerCase()
                      .contains(searchController.text.toLowerCase()))
                  .toList()
              : null;

          if (widget.budget!.itens == null) {
            widget.budget!.itens = [];
          }

          return ListView.builder(
            itemCount: listProducts.length,
            itemBuilder: (context, index) {
              Product product = Product.fromJson(listProducts[index]);
              ItemBudget itemBudget = ItemBudget();

              try {
                itemBudget = widget.budget!.itens!.firstWhere(
                    (element) => '"${product.id}"' == element.idProduct);
              } catch (e) {}

              return Column(
                children: [
                  Card(
                    child: ListTile(
                      title: Text(product.nome!),
                      subtitle: Text('R\$ ${product.valorVenda}'),
                      trailing: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border:
                              Border.all(color: productBackgroundColorShadow),
                          shape: BoxShape.rectangle,
                        ),
                        child: Wrap(
                          children: [
                            TextButton(
                              onPressed: () async {
                                widget.budget!.decrementItem(product);
                                showGeneralLoading(context);

                                await gSheetDb.putBudget(widget.budget!);

                                if (mounted) {
                                  Navigator.pop(context);
                                }
                                setState(() {});
                              },
                              child: SizedBox(
                                  height: 15,
                                  width: 15,
                                  child: SvgPicture.asset(kpathSvgMinus)),
                            ),
                            Text(
                              itemBudget.quantidade == null
                                  ? '0'
                                  : itemBudget.quantidade.toString(),
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                                onPressed: () async {
                                  widget.budget!.incrementItem(product);
                                  showGeneralLoading(context);
                                  await gSheetDb.putBudget(widget.budget!);

                                  if (mounted) {
                                    Navigator.pop(context);
                                  }
                                  setState(() {});
                                },
                                child: SizedBox(
                                    height: 15,
                                    width: 15,
                                    child: SvgPicture.asset(kpathSvgPlus))),
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
    );
  }
}
