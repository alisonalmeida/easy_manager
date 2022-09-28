// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, must_be_immutable

import 'dart:io';

import 'package:barcode/barcode.dart';
import 'package:easy_manager/consts.dart';
import 'package:easy_manager/core/generate_product_qr_code.dart';
import 'package:easy_manager/custom_widgets/button_round_with_shadow.dart';
import 'package:easy_manager/custom_widgets/custom_app_bar.dart';
import 'package:easy_manager/custom_widgets/custom_list_tile.dart';
import 'package:easy_manager/custom_widgets/custom_search_text_field.dart';
import 'package:easy_manager/custom_widgets/empty_widget.dart';
import 'package:easy_manager/main.dart';
import 'package:easy_manager/models/product.dart';
import 'package:easy_manager/screens/product/crud_product_screen.dart';
import 'package:easy_manager/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ProductsScreen extends ConsumerWidget {
  ProductsScreen({Key? key}) : super(key: key);
  static String name = 'Produtos';

  bool showFabVisible = true;
  bool listReverse = true;
  bool isSearching = false;
  FocusNode focusNode = FocusNode();
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var productList = ref.watch(productsProvider);
    Product productteste = Product();

    return Scaffold(
        backgroundColor: productBackgroundColor,
        appBar: CustomAppBar(
            title: ProductsScreen.name,
            backgroundColor: productBackgroundColor,
            callback: () async => Navigator.pop(context),
            svgImage: kpathSvgProduct,
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
                      onChanged: (v) => ref.refresh(productsProvider),
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
                      child: mapList.isEmpty
                          ? EmptyWidget()
                          : ListView.builder(
                              itemCount: mapList.toList().length,
                              itemBuilder: (context, index) {
                                Product product =
                                    Product.fromJson(mapList[index]);
                                productteste = product;

                                return CustomListTile(
                                    deleteCallback: () async {
                                      await _showDeleteAlertDialog(
                                          context, product);
                                    },
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
                                    icon: Icons.dry_cleaning_rounded,
                                    subtitle: 'R\$ ${product.valorVenda}');
                              },
                            ),
                    );
                  },
                  error: (error, stackTrace) => Center(
                    child: Text(error.toString() + stackTrace.toString()),
                  ),
                  loading: () {
                    return Center(
                      child: CircularProgressIndicator(color: black),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        persistentFooterButtons: [
          IconButton(
              onPressed: () async {
                // Create a DataMatrix barcode
                final dm = Barcode.dataMatrix();
                buildBarcode(productteste, dm, 'data');
              },
              icon: Icon(Icons.qr_code)),
          IconButton(
              onPressed: () {
                listReverse = !listReverse;
                ref.refresh(productsProvider);
              },
              icon: Icon(Icons.filter_alt)),
          IconButton(
              onPressed: () {
                isSearching = !isSearching;
                ref.refresh(productsProvider);
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

  void buildBarcode(
    Product product,
    Barcode bc,
    String data, {
    String? filename,
    double? width,
    double? height,
    double? fontHeight,
  }) async {
    /// Create the Barcode
    final svg = bc.toSvg(
      data,
      width: width ?? 200,
      height: height ?? 80,
      fontHeight: fontHeight,
    );

    // Save the image

    GenerateProductQrCode(barcode: bc, product: product).generateDocument();
  }

  Future _showDeleteAlertDialog(context, Product product) async {
    // set up the buttons

    Widget cancelButton = TextButton(
      child: Text("Cancelar"),
      onPressed: () => Navigator.of(context).pop(),
    );

    Widget continueButton = Consumer(
      builder: (context, ref, child) => TextButton(
        child: Text("Confirmar"),
        onPressed: () async {
          showGeneralLoading(context);
          await gSheetDb.deleteProduct(product.id!);
          searchController.clear();
          ref.refresh(productsProvider);
          Navigator.of(context).pop();
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
