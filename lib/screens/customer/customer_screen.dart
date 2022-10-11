// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, must_be_immutable

import 'package:easy_manager/consts.dart';
import 'package:easy_manager/custom_widgets/button_round_with_shadow.dart';
import 'package:easy_manager/custom_widgets/custom_app_bar.dart';
import 'package:easy_manager/custom_widgets/custom_list_tile.dart';
import 'package:easy_manager/custom_widgets/custom_search_text_field.dart';
import 'package:easy_manager/custom_widgets/empty_widget.dart';
import 'package:easy_manager/main.dart';
import 'package:easy_manager/models/customer_model.dart';
import 'package:easy_manager/screens/customer/crud_customer_screen.dart';
import 'package:easy_manager/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomerScreen extends ConsumerWidget {
  CustomerScreen({Key? key}) : super(key: key);
  static String name = 'Clientes';

  bool showFabVisible = true;
  bool listReverse = true;
  bool isSearching = false;
  FocusNode focusNode = FocusNode();
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var customerList = ref.watch(customersProvider);
    return Scaffold(
        backgroundColor: customerBackgroundColor,
        appBar: CustomAppBar(
          title: CustomerScreen.name,
          backgroundColor: customerBackgroundColor,
          callback: () async => Navigator.pop(context),
          svgImage: kpathSvgPerson,
          heroAnimation: CustomerScreen.name,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            children: [
              isSearching
                  ? SearchTextField(
                      clearField: () {
                        searchController.clear();
                        ref.refresh(customersProvider);
                      },
                      focusNode: focusNode,
                      searchController: searchController,
                      onChanged: (v) => ref.refresh(customersProvider),
                    )
                  : Container(),
              Expanded(
                child: customerList.when(
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
                                Customer customer =
                                    Customer.fromMap(mapList[index]);

                                return CustomListTile(
                                    listOptions:
                                        buildOptionsMenu(context, customer),
                                    title: customer.nome!,
                                    icon: Icons.person,
                                    subtitle: Text(customer.documento!));
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
                ref.refresh(customersProvider);
              },
              icon: Icon(Icons.filter_alt)),
          IconButton(
              onPressed: () {
                ref.refresh(customersProvider);
                isSearching = !isSearching;
                focusNode.requestFocus();
              },
              icon: Icon(Icons.search))
        ],
        floatingActionButton: showFabVisible
            ? ButtonRoundWithShadow(
                size: 60,
                borderColor: black,
                color: white,
                callback: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CrudCustomerScreen())),
                shadowColor: black,
                iconPath: kpathSvgPlus)
            : null);
  }

  Widget buildOptionsMenu(BuildContext context, Customer customer) {
    return PopupMenuButton<String>(
      shape: Border.all(),
      tooltip: 'Menu',
      onSelected: (value) {
        if (value == 'Editar') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CrudCustomerScreen(id: customer.id),
            ),
          );
        } else if (value == 'Deletar') {
          _showDeleteAlertDialog(context, customer);
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 'Editar',
          child: Text('Editar'),
        ),
        PopupMenuItem(
          value: 'Deletar',
          child: Text('Deletar'),
        ),
      ],
    );
  }

  Future _showDeleteAlertDialog(context, Customer customer) async {
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
          await gSheetDb.deleteCustomer(customer.id!);
          searchController.clear();
          ref.refresh(customersProvider);
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        },
      ),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(customer.nome!),
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
