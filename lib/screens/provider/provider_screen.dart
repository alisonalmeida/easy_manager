// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:async';
import 'package:easy_manager/consts.dart';
import 'package:easy_manager/custom_widgets/button_round_with_shadow.dart';
import 'package:easy_manager/custom_widgets/custom_app_bar.dart';
import 'package:easy_manager/custom_widgets/custom_list_tile.dart';
import 'package:easy_manager/custom_widgets/custom_search_text_field.dart';
import 'package:easy_manager/custom_widgets/empty_widget.dart';
import 'package:easy_manager/main.dart';
import 'package:easy_manager/models/product_provider_model.dart';
import 'package:easy_manager/screens/provider/crud_provider_screen.dart';
import 'package:easy_manager/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProvidersScreen extends ConsumerWidget {
  ProvidersScreen({Key? key}) : super(key: key);
  static String name = 'Fornecedores';

  bool showFabVisible = true;
  bool listReverse = true;
  bool isSearching = false;
  FocusNode focusNode = FocusNode();
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var productProviderList = ref.watch(productProvidersProvider);

    return Scaffold(
        backgroundColor: providerBackgroundColor,
        appBar: CustomAppBar(
            title: ProvidersScreen.name,
            backgroundColor: providerBackgroundColor,
            callback: () async => Navigator.pop(context),
            svgImage: kpathSvgFactory,
            heroAnimation: ProvidersScreen.name),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            children: [
              isSearching
                  ? SearchTextField(
                      clearField: () {
                        searchController.clear();
                        ref.refresh(productProvidersProvider);
                      },
                      focusNode: focusNode,
                      searchController: searchController,
                      onChanged: (v) => ref.refresh(productProvidersProvider),
                    )
                  : Container(),
              Expanded(
                child: productProviderList.when(
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
                                ProductProvider productProvider =
                                    ProductProvider.fromMap(mapList[index]);

                                return CustomListTile(
                                    deleteCallback: () async =>
                                        await _showDeleteAlertDialog(
                                            context, productProvider),
                                    editCallback: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CrudProviderScreen(
                                                  id: productProvider.id),
                                        ),
                                      );
                                    },
                                    title: productProvider.nome!,
                                    icon: Icons.factory,
                                    subtitle: productProvider.documento!);
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
              onPressed: () {
                listReverse = !listReverse;
                ref.refresh(productProvidersProvider);
              },
              icon: Icon(Icons.filter_alt)),
          IconButton(
              onPressed: () {
                isSearching = !isSearching;
                ref.refresh(productProvidersProvider);
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
                        builder: (context) => CrudProviderScreen())),
                shadowColor: woodSmoke,
                iconPath: kpathSvgPlus)
            : null);
  }

  Future _showDeleteAlertDialog(
      context, ProductProvider productProvider) async {
    // set up the buttons

    Widget cancelButton = Consumer(
      builder: (context, ref, child) => TextButton(
        child: Text("Cancelar"),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
    Widget continueButton = Consumer(
      builder: (context, ref, child) => TextButton(
        child: Text("Confirmar"),
        onPressed: () async {
          showGeneralLoading(context);
          await gSheetDb.deleteProvider(productProvider.id!);
          searchController.clear();
          ref.refresh(productProvidersProvider);
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        },
      ),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(productProvider.nome!),
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
