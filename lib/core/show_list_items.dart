import 'package:easy_manager/custom_widgets/empty_widget.dart';
import 'package:easy_manager/models/product_model.dart';
import 'package:easy_manager/models/product_provider_model.dart';
import 'package:easy_manager/screens/crud_product_screen.dart';
import 'package:easy_manager/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ShowListItemsProductProvider extends StatelessWidget {
  ShowListItemsProductProvider({
    Key? key,
    required this.box,
    required dynamic type,
    required this.callback,
  }) : super(key: key);

  final Box box;
  final Function(String?) callback;
  late dynamic type;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, Box box, widget) {
          List<ProductProvider> list = [];

          box.toMap().forEach((key, value) {
            list.add(value);
          });
          if (box.isEmpty) {
            return const EmptyWidget();
          } else {
            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: callback != null
                      ? () {
                          callback(list[index].document);
                          Navigator.pop(context);
                        }
                      : null,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: white,
                        border: Border.all(),
                        boxShadow: const [
                          BoxShadow(offset: Offset(3, 2), color: Colors.black)
                        ]),
                    child: ListTile(
                      title: Text(list[index].name),
                      subtitle: Text(list[index].document),
                    ),
                  ),
                );
              },
            );
          }
        });
  }
}

class ShowListItemsProduct extends StatelessWidget {
  const ShowListItemsProduct({
    Key? key,
    required this.box,
    required this.callback,
  }) : super(key: key);

  final Box box;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, Box box, widget) {
          List<Product> list = [];

          box.toMap().forEach((key, value) {
            list.add(value);
          });
          if (box.isEmpty) {
            return const EmptyWidget();
          } else {
            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CrudProductScreen(
                                isUpdate: true,
                                productkey: list[index].cod,
                              ))),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: white,
                        border: Border.all(),
                        boxShadow: const [
                          BoxShadow(offset: Offset(3, 2), color: Colors.black)
                        ]),
                    child: ListTile(
                      title: Text(list[index].name),
                      subtitle: Text(list[index].cod),
                    ),
                  ),
                );
              },
            );
          }
        });
  }
}
