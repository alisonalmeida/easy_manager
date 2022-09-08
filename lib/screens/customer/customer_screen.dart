// ignore_for_file: prefer_const_constructors

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

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({Key? key}) : super(key: key);
  static String name = 'Clientes';

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  late Stream<List<Map<String, String>>?> stream;
  bool showFabVisible = true;
  bool listReverse = false;
  bool isSearching = false;
  FocusNode focusNode = FocusNode();
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    stream = gSheetDb.getStreamCustomers();
    super.initState();
  }

  @override
  void dispose() {
    focusNode.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customerBackgroundColor,
      appBar: CustomAppBar(
          heroAnimation: CustomerScreen.name,
          svgImage: kpathSvgPerson,
          title: CustomerScreen.name,
          backgroundColor: customerBackgroundColor,
          callback: () async => Navigator.pop(context)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          children: [
            isSearching
                ? SearchTextField(
                    clearField: () => setState(() => searchController.clear()),
                    focusNode: focusNode,
                    searchController: searchController,
                  )
                : Container(),
            Expanded(
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
                      isSearching
                          ? mapList = mapList
                              .where((element) => element['nome']
                                  .toString()
                                  .toLowerCase()
                                  .contains(
                                      searchController.text.toLowerCase()))
                              .toList()
                          : null;

                      return NotificationListener<UserScrollNotification>(
                        onNotification: (notification) {
                          if (notification.direction ==
                              ScrollDirection.reverse) {
                            setState(() {
                              showFabVisible = false;
                            });
                          }
                          if (notification.direction ==
                              ScrollDirection.forward) {
                            setState(() {
                              showFabVisible = true;
                            });
                          }
                          return true;
                        },
                        child: ListView.builder(
                            itemCount: mapList.toList().length,
                            itemBuilder: (context, index) {
                              Customer customer =
                                  Customer.fromMap(mapList[index]);

                              return CustomListTile(
                                  deleteCallback: () async {
                                    _showDeleteAlertDialog(context, customer);
                                  },
                                  editCallback: () async {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CrudCustomerScreen(
                                                    id: customer.id)));
                                  },
                                  title: customer.nome!,
                                  icon: Icons.person,
                                  subtitle: customer.documento!);
                            }),
                      );
                    } else {
                      return EmptyWidget();
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
      persistentFooterButtons: [
        IconButton(
            onPressed: () => listReverse = !listReverse,
            icon: Icon(Icons.filter_alt)),
        IconButton(
            onPressed: () {
              setState(() {
                isSearching = !isSearching;
                focusNode.requestFocus();
              });
            },
            icon: Icon(Icons.search))
      ],
      floatingActionButton: ButtonRoundWithShadow(
          size: 60,
          borderColor: woodSmoke,
          color: white,
          callback: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CrudCustomerScreen()),
            );
          },
          shadowColor: woodSmoke,
          iconPath: kpathSvgPlus),
    );
  }

  _showDeleteAlertDialog(context, Customer customer) {
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
        await gSheetDb.deleteCustomer(customer.id!);
        Navigator.of(context).pop();
      },
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
