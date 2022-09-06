// ignore_for_file: prefer_const_constructors

import 'package:easy_manager/custom_widgets/custom_button_add.dart';
import 'package:easy_manager/custom_widgets/custom_search_text_field.dart';
import 'package:easy_manager/custom_widgets/empty_widget.dart';
import 'package:easy_manager/main.dart';
import 'package:easy_manager/models/product_model.dart';
import 'package:easy_manager/screens/crud_product_screen.dart';
import 'package:easy_manager/utils/colors.dart';
import 'package:flutter/material.dart';

Future<List<String>> showProductChoiceDialog(BuildContext context) async {
  DraggableScrollableController controller = DraggableScrollableController();
  TextEditingController searchController = TextEditingController();
  Stream<List<Map<String, String>>?> stream;
  stream = gSheetDb.getAllProducts();
  searchController.text = 'teste';
  List<String> returnedValue = [];

  await showModalBottomSheet(
    backgroundColor: productBackgroundColor,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    context: context,
    builder: (context) {
      return DraggableScrollableSheet(
        expand: false,
        controller: controller,
        initialChildSize: 0.9,
        builder: (context, scrollController) {
          return Padding(
            padding: EdgeInsets.all(10),
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
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: white,
                    border: Border.all(color: black),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      fillColor: white,
                      hintText: 'Pesquisar',
                      prefixIcon: const Icon(
                        Icons.search,
                        color: black,
                      ),
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.cancel,
                          color: black,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: FutureBuilder(
                  future: stream.first,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
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
                      return Center(
                        child: ListView.builder(
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
                              ], color: Colors.white, shape: Border.all()),
                              child: CheckboxListTile(
                                  title: Text(product.nome!),
                                  value: false,
                                  onChanged: (v) {}),
                            );
                          },
                        ),
                      );
                    }
                    return Text(snapshot.connectionState.toString());
                  },
                )),
              ],
            ),
          );
        },
      );
    },
  );
  return returnedValue;
}
