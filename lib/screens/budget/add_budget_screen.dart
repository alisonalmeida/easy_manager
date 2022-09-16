// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:easy_manager/consts.dart';
import 'package:easy_manager/custom_widgets/custom_app_bar.dart';
import 'package:easy_manager/custom_widgets/custom_button_add.dart';
import 'package:easy_manager/custom_widgets/custom_button_confirm.dart';
import 'package:easy_manager/custom_widgets/custom_modal_bottom_sheet_customer.dart';

import 'package:easy_manager/custom_widgets/custom_search_text_field.dart';
import 'package:easy_manager/main.dart';
import 'package:easy_manager/models/budget_model.dart';
import 'package:easy_manager/models/product_model.dart';
import 'package:easy_manager/screens/budget/budget_screen.dart';
import 'package:easy_manager/screens/crud_product_screen.dart';
import 'package:easy_manager/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddBudgetScreen extends StatefulWidget {
  const AddBudgetScreen({Key? key}) : super(key: key);

  @override
  State<AddBudgetScreen> createState() => _AddBudgetScreenState();
}

class _AddBudgetScreenState extends State<AddBudgetScreen> {
  String customerName = '';

  List<Map<String, String>> listProducts = [];
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
  void initState() {
    getListProducts();
    super.initState();
  }

  void getListProducts() async {
    listProducts = await gSheetDb.getProducts();
  }

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
                  showProductChoiceBottomSheet(context, listProducts);
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
        onPressed: () async {
          showGeneralLoading(context);

          if (mounted) {
            Navigator.pop(context);
          }
        },
        child: Icon(Icons.save),
      ),
    );
  }

  void showProductChoiceBottomSheet(
      BuildContext context, List<Map<String, String>> listProduct) {
    DraggableScrollableController controller = DraggableScrollableController();
    TextEditingController searchController = TextEditingController();

    FocusNode focusNode = FocusNode();

    showModalBottomSheet(
      backgroundColor: productBackgroundColor,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        side: BorderSide.none,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      context: context,
      builder: (context) {
        Budget budget = Budget();

        return Consumer(
          builder: (context, ref, child) {
            var listProducts = ref.watch(productsProvider);
            var listBudgets = ref.watch(budgetsProvider);
            ref.refresh(productsProvider);

            return DraggableScrollableSheet(
              expand: false,
              controller: controller,
              initialChildSize: 0.9,
              builder: (context, scrollController) {
                return Container(
                  margin: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        height: 5,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: black,
                        ),
                      ),
                      CustomAddButton(
                        text: 'Adicionar Novo Produto',
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CrudProductScreen(),
                            ),
                          );
                        },
                      ),
                      SearchTextField(
                        clearField: () {
                          searchController.clear();
                          ref.refresh(productsProvider);
                        },
                        focusNode: focusNode,
                        searchController: searchController,
                        onChanged: (v) {
                          ref.refresh(productsProvider);
                        },
                      ),
                      Expanded(
                        child: listProducts.when(
                          data: (data) {
                            List<Map<String, String>> mapList = data;
                            mapList = mapList
                                .where((element) => element['nome']
                                    .toString()
                                    .toLowerCase()
                                    .contains(searchController.text))
                                .toList();

                            return ListView.builder(
                              itemCount: mapList.length,
                              itemBuilder: (context, index) {
                                Product product =
                                    Product.fromMap(mapList[index]);

                                return Container(
                                  decoration: ShapeDecoration(shadows: const [
                                    BoxShadow(
                                      color: Colors.black,
                                      offset: Offset(
                                        3.0,
                                        4.0,
                                      ),
                                    )
                                  ], color: white, shape: Border.all()),
                                  child: ListTile(
                                    title: Text(product.nome!),
                                    subtitle: Text(
                                        'R\$ ${product.valorVenda.toString()}'),
                                    trailing: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color:
                                                productBackgroundColorShadow),
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
                                            budget.listaProdutos![index]
                                                        [product] ==
                                                    null
                                                ? '0'
                                                : budget.listaProdutos![index]
                                                        [product]
                                                    .toString(),
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              budget
                                                  .addIncrementProduct(product);
                                            },
                                            child: Text('+',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        productBackgroundColorShadow)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          error: (error, stackTrace) {
                            return Center();
                          },
                          loading: () => Center(
                            child: CircularProgressIndicator(
                              color: black,
                            ),
                          ),
                        ),
                      ),
                      CustomButtonConfirm(
                        isEnabled: true,
                        text: 'Salvar',
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
