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

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late Stream<List<Product>> streamProducts;

  @override
  void initState() {
    streamProducts = companyDB.getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: pastelPink,
        appBar: CustomAppBar(
          heroAnimation: 'Produtos',
          svgImage: kpathSvgProduct,
          callback: () async => Navigator.pop(context),
          backgroundColor: pastelPink,
          title: 'Produtos',
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Center(
              child: StreamBuilder<List<Product>>(
                  stream: streamProducts,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }

                    final products = snapshot.data;
                    if (products!.isEmpty) {
                      return EmptyWidget();
                    }

                    return ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        return CustomListTile(
                            deleteCallback: () {
                              companyDB.deleteProduct(products[index].id);
                            },
                            editCallback: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return CrudProductScreen(
                                    productkey: products[index].id,
                                  );
                                },
                              ));
                            },
                            title: products[index].name,
                            icon: Icons.person,
                            subtitle: products[index].id.toString());
                      },
                    );
                  }),
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
