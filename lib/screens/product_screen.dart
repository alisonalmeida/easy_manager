// ignore_for_file: prefer_const_constructors

import 'package:easy_manager/consts.dart';
import 'package:easy_manager/custom_widgets/button_round_with_shadow.dart';
import 'package:easy_manager/custom_widgets/custom_app_bar.dart';
import 'package:easy_manager/custom_widgets/custom_list_tile.dart';
import 'package:easy_manager/custom_widgets/empty_widget.dart';
import 'package:easy_manager/main.dart';
import 'package:easy_manager/models/product_model.dart';
import 'package:easy_manager/screens/crud_product_screen.dart';
import 'package:easy_manager/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ProductsScreen extends StatefulWidget {
  ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late Stream<List<Map<String, String>>?> stream;
  bool showFabVisible = true;
  bool listReverse = false;

  @override
  void initState() {
    stream = gSheetDb.getAllProducts();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: productBackgroundColor,
        appBar: CustomAppBar(
            title: 'Produtos',
            backgroundColor: productBackgroundColor,
            callback: () async => Navigator.pop(context),
            svgImage: kpathSvgFactory,
            heroAnimation: 'Produtos'),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Center(
            child: StreamBuilder(
              stream: stream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(color: black),
                  );
                } else {
                  if (snapshot.hasData) {
                    List<Map<String, String>> mapList =
                        snapshot.data as List<Map<String, String>>;
                    listReverse ? mapList = mapList.reversed.toList() : null;

                    return NotificationListener<UserScrollNotification>(
                      onNotification: (notification) {
                        if (notification.direction == ScrollDirection.reverse) {
                          setState(() {
                            showFabVisible = false;
                          });
                        }
                        if (notification.direction == ScrollDirection.forward) {
                          setState(() {
                            showFabVisible = true;
                          });
                        }
                        return true;
                      },
                      child: ListView.builder(
                          itemCount: mapList.toList().length,
                          itemBuilder: (context, index) {
                            Product product = Product.fromMap(mapList[index]);

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
                                icon: Icons.catching_pokemon,
                                subtitle: 'R\$ ${product.valorVenda}');
                          }),
                    );
                  } else {
                    return EmptyWidget();
                  }
                }
              },
            ),
          ),
        ),
        persistentFooterButtons: [
          IconButton(
              onPressed: () => listReverse = !listReverse,
              icon: Icon(Icons.filter_alt)),
          IconButton(onPressed: () {}, icon: Icon(Icons.search))
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

  _showDeleteAlertDialog(context, Product product) {
    // set up the buttons

    Widget cancelButton = TextButton(
      child: Text("Cancelar"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Confirmar"),
      onPressed: () async {
        await gSheetDb.deleteProvider(product.id!);
        Navigator.of(context).pop();
      },
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
