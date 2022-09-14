// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:easy_manager/consts.dart';
import 'package:easy_manager/custom_widgets/button_round_with_shadow.dart';
import 'package:easy_manager/custom_widgets/custom_app_bar.dart';
import 'package:easy_manager/custom_widgets/custom_list_tile.dart';
import 'package:easy_manager/custom_widgets/custom_search_text_field.dart';
import 'package:easy_manager/custom_widgets/empty_widget.dart';
import 'package:easy_manager/main.dart';
import 'package:easy_manager/models/product_model.dart';
import 'package:easy_manager/screens/product/crud_product_screen.dart';
import 'package:easy_manager/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductsScreen extends ConsumerWidget {
  ProductsScreen({Key? key}) : super(key: key);
  static String name = 'Produtos';

  bool showFabVisible = true;
  bool listReverse = false;
  bool isSearching = false;
  FocusNode focusNode = FocusNode();
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var productList = ref.watch(productsProvider);
    return Scaffold(
        backgroundColor: productBackgroundColor,
        appBar: CustomAppBar(
            title: ProductsScreen.name,
            backgroundColor: productBackgroundColor,
            callback: () async => Navigator.pop(context),
            svgImage: kpathSvgFactory,
            heroAnimation: ProductsScreen.name),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            children: [
              isSearching
                  ? SearchTextField(
                      clearField: () {
                        searchController.clear();
                        ref.refresh(productsProvider);
                      },
                      focusNode: focusNode,
                      searchController: searchController,
                      onChanged: (v) {
                        ref.refresh(productsProvider);
                      },
                    )
                  : Container(),
              Expanded(
                child: productList.when(
                  data: (data) {
                    List<Map<String, String>> mapList = data;
                    listReverse ? mapList = mapList.reversed.toList() : null;
                    isSearching
                        ? mapList = mapList
                            .where((element) => element['nome']
                                .toString()
                                .toLowerCase()
                                .contains(searchController.text.toLowerCase()))
                            .toList()
                        : null;

                    return NotificationListener<UserScrollNotification>(
                      onNotification: (notification) {
                        if (notification.direction == ScrollDirection.reverse) {
                          showFabVisible = false;
                        }
                        if (notification.direction == ScrollDirection.forward) {
                          showFabVisible = true;
                        }
                        return true;
                      },
                      child: mapList == null
                          ? EmptyWidget()
                          : ListView.builder(
                              itemCount: mapList.toList().length,
                              itemBuilder: (context, index) {
                                Product product =
                                    Product.fromMap(mapList[index]);

                                return CustomListTile(
                                    deleteCallback: () async =>
                                        await _showDeleteAlertDialog(
                                            context, product),
                                    editCallback: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CrudProductScreen(id: product.id),
                                        ),
                                      );
                                    },
                                    title: product.nome!,
                                    icon: Icons.factory,
                                    subtitle: 'R\$ ${product.valorVenda}');
                              },
                            ),
                    );
                  },
                  error: (error, stackTrace) => Center(
                    child: Text(error.toString()),
                  ),
                  loading: () {
                    return Center(
                      child: CircularProgressIndicator(
                        color: black,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        persistentFooterButtons: [
          IconButton(
              onPressed: () => listReverse = !listReverse,
              icon: Icon(Icons.filter_alt)),
          IconButton(
              onPressed: () {
                ref.refresh(productsProvider);
                isSearching = !isSearching;
                focusNode.requestFocus();
              },
              icon: Icon(Icons.search))
        ],
        floatingActionButton: showFabVisible
            ? ButtonRoundWithShadow(
                size: 60,
                borderColor: woodSmoke,
                color: white,
                callback: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CrudProductScreen())),
                shadowColor: woodSmoke,
                iconPath: kpathSvgPlus)
            : null);
  }

  Future _showDeleteAlertDialog(context, Product product) async {
    // set up the buttons

    Widget cancelButton = Consumer(
      builder: (context, ref, child) => TextButton(
        child: Text("Cancelar"),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
    Widget continueButton = Consumer(
      builder: (context, ref, child) => TextButton(
        child: Text("Confirmar"),
        onPressed: () async {
          await gSheetDb.deleteProduct(product.id!);
          Navigator.of(context).pop();
        },
      ),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(product.nome!),
      content: Text("Confirma a exclusão do cadastro?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return alert;
      },
    );
  }
}
