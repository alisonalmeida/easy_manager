// ignore_for_file: prefer_const_constructors

import 'package:easy_manager/consts.dart';
import 'package:easy_manager/core/show_list_items.dart';
import 'package:easy_manager/custom_widgets/button_round_with_shadow.dart';
import 'package:easy_manager/custom_widgets/custom_app_bar.dart';
import 'package:easy_manager/screens/crud_product_screen.dart';
import 'package:easy_manager/utils/colors.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  //late final Box _productBox;

  @override
  void initState() {
    //  _productBox = Hive.box(kProductBox);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: pastelPink,
        /**appBar: CustomAppBar(
          backgroundColor: pastelPink,
          title: 'Produtos',
        ), */
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Text(
                '1asdasdasd') /**ShowListItemsProduct(
                box: _productBox,
                callback: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CrudProductScreen(
                              isUpdate: true,
                            )))) */
            ),
        persistentFooterButtons: [
          ElevatedButton(onPressed: () {}, child: Text('teste'))
        ],
        floatingActionButton: ButtonRoundWithShadow(
            size: 60,
            borderColor: woodSmoke,
            color: white,
            callback: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CrudProductScreen(
                          isUpdate: false,
                        ))),
            shadowColor: woodSmoke,
            iconPath: kpathSvgPlus));
  }
}
