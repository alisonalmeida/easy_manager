// ignore_for_file: prefer_const_constructors

import 'package:easy_manager/custom_widgets/custom_list_tile_check.dart';
import 'package:easy_manager/custom_widgets/empty_widget.dart';
import 'package:easy_manager/main.dart';
import 'package:easy_manager/models/product_provider_model.dart';
import 'package:flutter/material.dart';

class CustomModalBottomSheetProvider extends StatefulWidget {
  CustomModalBottomSheetProvider({Key? key}) : super(key: key);

  @override
  State<CustomModalBottomSheetProvider> createState() =>
      _CustomModalBottomSheetProviderState();
}

class _CustomModalBottomSheetProviderState
    extends State<CustomModalBottomSheetProvider> {
  late Stream<List<ProductProvider>> streamProviders;

  @override
  Widget build(BuildContext context) {
    streamProviders = companyBox.getProviders();
    return StreamBuilder<List<ProductProvider>>(
      stream: streamProviders,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return EmptyWidget();
        } else {
          final providers = snapshot.data;
          if (providers!.isEmpty) {
            return EmptyWidget();
          }

          return Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20))),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    height: 5,
                    width: 50,
                    decoration: BoxDecoration(color: Colors.grey),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: providers.length,
                        itemBuilder: (context, index) {
                          final provider = providers[index];
                          return CustomListTileCheck(
                              title: provider.name!,
                              icon: Icons.add_box,
                              subtitle: provider.document!);
                        }),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
