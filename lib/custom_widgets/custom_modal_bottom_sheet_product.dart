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
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomModalBottomSheetProducts {
  CustomModalBottomSheetProducts({Key? key});

  void showProductChoiceBottomSheet(BuildContext context) async {
    DraggableScrollableController controller = DraggableScrollableController();
    TextEditingController searchController = TextEditingController();

    FocusNode focusNode = FocusNode();

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
        return Consumer(
          builder: (context, ref, child) {
            var listProducts = ref.watch(productsProvider);
            var listBudgets = ref.watch(budgetsProvider);

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
                                child: ListTile(
                                  title: Text(product.nome!),
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
                                          '0',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        TextButton(
                                          onPressed: () {
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
                      ))
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
