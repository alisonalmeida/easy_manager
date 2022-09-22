// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:easy_manager/consts.dart';
import 'package:easy_manager/custom_widgets/button_round_with_shadow.dart';
import 'package:easy_manager/custom_widgets/custom_modal_bottom_sheet_customer.dart';
import 'package:easy_manager/custom_widgets/custom_search_text_field.dart';
import 'package:easy_manager/main.dart';
import 'package:easy_manager/models/budget.dart';
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

  @override
  void initState() {
    print('ON INIT ${widget.budget}');
    super.initState();
  }

  @override
  void dispose() {
    print('ON DISPOSE ${widget.budget}');
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
              callback: () => Navigator.pop(context)),
        ),
        actions: [
          Consumer(
            builder: (context, ref, child) => Padding(
              padding: const EdgeInsets.only(right: 16),
              child: ButtonRoundWithShadow(
                  borderColor: black,
                  shadowColor: black,
                  color: white,
                  iconPath: kpathSvgRefresh,
                  size: 40,
                  callback: () async {}),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Row(
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
                            widget.budget!.nomeCliente =
                                await showCustomerChoiceDialog(context);

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
      floatingActionButton: ButtonRoundWithShadow(
          borderColor: black,
          shadowColor: black,
          color: white,
          iconPath: kpathSvgSave,
          size: 50,
          callback: () async {
            setState(() {});
            showGeneralLoading(context);

            if (mounted) {
              Navigator.pop(context);
            }
          }),
    );
  }

  Widget _futureBuilder() {
    return FutureBuilder(
      future: gSheetDb.getProducts(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var listProducts = snapshot.data as List<Map<String, String>>;

          if (widget.budget!.listaProdutos == null) {
            print('IFFFF');
            widget.budget!.listaProdutos = [];
            widget.budget!.listaValoresProdutos = [];
            for (var element in listProducts) {
              widget.budget!.listaProdutos!.add(
                {'''"${element['nome']!}"''': 0},
              );
              widget.budget!.listaValoresProdutos!
                  .add(double.parse(element['valorVenda']!));
            }
          } else {
            
            print('ELSE');
          }
          print(
              'widget.budget!.listaProdutos:::::: ${widget.budget!.listaProdutos}');

          var iterableProducts = widget.budget!.listaProdutos!.expand(
            (element) => element.keys,
          );
          var iterableQuantity =
              widget.budget!.listaProdutos!.expand((element) => element.values);
          var lenghtList = widget.budget!.listaProdutos!.length;
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
                          border:
                              Border.all(color: productBackgroundColorShadow),
                          shape: BoxShape.rectangle,
                        ),
                        child: Wrap(
                          children: [
                            TextButton(
                              onPressed: () async {
                                widget.budget!.decrementProduct(
                                    iterableProducts.elementAt(index),
                                    double.parse(listProducts
                                        .elementAt(index)['valorVenda']!));
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
                              iterableQuantity.elementAt(index).toString(),
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                                onPressed: () async {
                                  widget.budget!.addIncrementProduct(
                                      iterableProducts.elementAt(index),
                                      double.parse(listProducts
                                          .elementAt(index)['valorVenda']!));
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
