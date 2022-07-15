// ignore_for_file: prefer_const_constructors

import 'package:easy_manager/consts.dart';
import 'package:easy_manager/custom_widgets/button_round_with_shadow.dart';
import 'package:easy_manager/custom_widgets/custom_app_bar.dart';
import 'package:easy_manager/custom_widgets/empty_widget.dart';
import 'package:easy_manager/models/product_provider_model.dart';
import 'package:easy_manager/screens/crud_provider_screen.dart';
import 'package:easy_manager/utils/colors.dart';
import 'package:flutter/material.dart';

class ProvidersScreen extends StatefulWidget {
  const ProvidersScreen({Key? key}) : super(key: key);

  @override
  State<ProvidersScreen> createState() => _ProvidersScreenState();
}

class _ProvidersScreenState extends State<ProvidersScreen> {
  //late final Box _productProviderBox;

  @override
  void initState() {
    // _productProviderBox = Hive.box(kProductProviderBox);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: carribeanGreen,
        /**appBar: CustomAppBar(
          backgroundColor: carribeanGreen,
          title: 'Fornecedores',
        ), */
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: EmptyWidget()
            /*
          ValueListenableBuilder(
              valueListenable: _productProviderBox.listenable(),
              builder: (context, Box box, widget) {
                List<ProductProvider> list = [];
                box.toMap().forEach((key, value) {
                  list.add(value);
                });
                if (box.isEmpty) {
                  return EmptyWidget();
                } else {
                  return ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CrudProviderScreen(
                                    isUpdate: true,
                                    productProviderKey: list[index].document))),
                        child: Container(
                          margin: EdgeInsets.only(bottom: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: white,
                              border: Border.all(),
                              boxShadow: const [
                                BoxShadow(
                                    offset: Offset(3, 2), color: Colors.black)
                              ]),
                          child: ListTile(
                            leading: Text(index.toString()),
                            title: Text(list[index].name),
                            subtitle: Text(list[index].document),
                          ),
                        ),
                      );
                    },
                  );
                }
              }),

              */
            ),
        persistentFooterButtons: [
          ElevatedButton(onPressed: () {}, child: Text('Limpar Box'))
        ],
        floatingActionButton: ButtonRoundWithShadow(
            size: 60,
            borderColor: woodSmoke,
            color: white,
            callback: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CrudProviderScreen(isUpdate: false))),
            shadowColor: woodSmoke,
            iconPath: kpathSvgPlus));
  }
}
