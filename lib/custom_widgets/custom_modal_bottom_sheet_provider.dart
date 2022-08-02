// ignore_for_file: prefer_const_constructors

import 'package:easy_manager/consts.dart';
import 'package:easy_manager/custom_widgets/button_round_with_shadow.dart';
import 'package:easy_manager/custom_widgets/custom_list_tile_check.dart';
import 'package:easy_manager/custom_widgets/empty_widget.dart';
import 'package:easy_manager/main.dart';
import 'package:easy_manager/models/product_provider_model.dart';
import 'package:easy_manager/utils/colors.dart';
import 'package:flutter/material.dart';

Future<String> showProviderChoiceDialog(BuildContext context) async {
  late Stream<List<ProductProvider>> streamProviders;
  DraggableScrollableController controller = DraggableScrollableController();

  streamProviders = companyBox.getProviders();
  String returnedValue = '';
  await showModalBottomSheet(
    enableDrag: true,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    context: context,
    builder: (context) {
      return DraggableScrollableSheet(
        controller: controller,
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        builder: (context, scrollController) {
          return StreamBuilder<List<ProductProvider>>(
              stream: streamProviders,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  final providers = snapshot.data;
                  if (providers!.isEmpty) {
                    return Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(),
                            color: white,
                            borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(20),
                              right: Radius.circular(20),
                            )),
                        child: Column(
                          children: [
                            Container(
                              height: 4,
                              width: 50,
                              color: Colors.grey,
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 30),
                              child: Text('Escolha um Fornecedor'),
                            ),
                            SizedBox(height: 5),
                            EmptyWidget(),
                          ],
                        ));
                  }

                  return Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(),
                        color: white,
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(20),
                          right: Radius.circular(20),
                        )),
                    child: Column(
                      children: [
                        Container(
                          height: 4,
                          width: 50,
                          color: Colors.grey,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 30),
                          child: Text('Escolha um Fornecedor'),
                        ),
                        Expanded(
                          child: ListView.builder(
                              itemCount: providers.length,
                              itemBuilder: (context, index) {
                                final provider = providers[index];
                                return CustomListTileCheck(
                                  callback: () {
                                    returnedValue =
                                        '${provider.name!} - ${provider.document!}';
                                    Navigator.pop(context);
                                  },
                                  subtitle: provider.document!,
                                  icon: Icons.data_array,
                                  title: provider.name!,
                                );
                              }),
                        ),
                      ],
                    ),
                  );
                }
              });
        },
      );
    },
  );
  return returnedValue;
}
