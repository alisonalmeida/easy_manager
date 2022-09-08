// ignore_for_file: prefer_const_constructors

import 'package:easy_manager/custom_widgets/custom_button_add.dart';
import 'package:easy_manager/custom_widgets/custom_search_text_field.dart';
import 'package:easy_manager/custom_widgets/empty_widget.dart';
import 'package:easy_manager/main.dart';
import 'package:easy_manager/models/budget_model.dart';
import 'package:easy_manager/models/product_model.dart';
import 'package:easy_manager/screens/product/crud_product_screen.dart';
import 'package:easy_manager/utils/colors.dart';
import 'package:flutter/material.dart';

Future<List<Product>> showProductChoiceDialog(BuildContext context) async {
  DraggableScrollableController controller = DraggableScrollableController();
  TextEditingController searchController = TextEditingController();

  List<Product> listBudget = [];

  await showModalBottomSheet(
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
      return StatefulBuilder(
        builder: (context, setState) => DraggableScrollableSheet(
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
                            ));
                      }),
                  SearchTextField(
                    onChanged: (p0) {
                      setState.call(() {});
                    },
                    clearField: () {
                      setState.call(() {
                        searchController.clear();
                      });
                    },
                    searchController: searchController,
                  ),
                  Expanded(
                    child: FutureBuilder(
                      future: gSheetDb.getProducts(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (snapshot.hasData) {
                          List<Map<String, String>> mapList =
                              snapshot.data as List<Map<String, String>>;
                          mapList = mapList
                              .where((element) => element['nome']
                                  .toString()
                                  .toLowerCase()
                                  .contains(searchController.text))
                              .toList();
                          for (var i = 0; i < mapList.length; i++) {}
                          return ListView.builder(
                            itemCount: mapList.length,
                            itemBuilder: (context, index) {
                              Product product = Product.fromMap(mapList[index]);

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
                                child: CheckboxListTile(
                                  title: Text(product.nome!),
                                  value: listBudget.contains(product),
                                  onChanged: (v) {
                                    if (v!) {
                                      listBudget.add(product);
                                    } else {
                                      listBudget.remove(product);
                                    }

                                    setState(() {});
                                    for (var i = 0;
                                        i < listBudget.length;
                                        i++) {}
                                  },
                                ),
                              );
                            },
                          );
                        }
                        return Text(snapshot.connectionState.toString());
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    },
  );

  return listBudget;
}
