// ignore_for_file: prefer_const_constructors

import 'package:easy_manager/consts.dart';
import 'package:easy_manager/custom_widgets/button_round_with_shadow.dart';
import 'package:easy_manager/custom_widgets/custom_app_bar.dart';
import 'package:easy_manager/custom_widgets/custom_list_tile.dart';
import 'package:easy_manager/custom_widgets/empty_widget.dart';
import 'package:easy_manager/models/product_model.dart';
import 'package:easy_manager/screens/crud_product_screen.dart';
import 'package:easy_manager/utils/colors.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatefulWidget {
  ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: productBackgroundColor,
        appBar: CustomAppBar(
          heroAnimation: 'Produtos',
          svgImage: kpathSvgProduct,
          callback: () async => Navigator.pop(context),
          backgroundColor: productBackgroundColor,
          title: 'Produtos',
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Center(
            )),
        persistentFooterButtons: [
          ElevatedButton(onPressed: () {}, child: Text('teste'))
        ],
        floatingActionButton: ButtonRoundWithShadow(
            size: 60,
            borderColor: woodSmoke,
            color: white,
            callback: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => CrudProductScreen())),
            shadowColor: woodSmoke,
            iconPath: kpathSvgPlus));
  }
}
