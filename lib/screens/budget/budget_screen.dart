// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:easy_manager/consts.dart';
import 'package:easy_manager/custom_widgets/button_round_with_shadow.dart';
import 'package:easy_manager/custom_widgets/custom_app_bar.dart';
import 'package:easy_manager/custom_widgets/custom_list_tile.dart';
import 'package:easy_manager/custom_widgets/custom_search_text_field.dart';
import 'package:easy_manager/custom_widgets/empty_widget.dart';
import 'package:easy_manager/main.dart';
import 'package:easy_manager/models/budget_model.dart';
import 'package:easy_manager/screens/budget/add_budget_screen.dart';
import 'package:easy_manager/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class BudgetsScreen extends StatefulWidget {
  const BudgetsScreen({Key? key}) : super(key: key);
  static String name = 'Orçamentos';

  @override
  State<BudgetsScreen> createState() => _BudgetsScreenState();
}

class _BudgetsScreenState extends State<BudgetsScreen> {
  late Stream<List<Map<String, String>>?> stream;
  bool showFabVisible = true;
  bool listReverse = false;
  bool isSearch = false;
  bool isSearching = false;
  FocusNode focusNode = FocusNode();
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    stream = gSheetDb.getStreamBudgets();
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
        backgroundColor: budgetBackgroundColor,
        appBar: CustomAppBar(
            title: BudgetsScreen.name,
            backgroundColor: budgetBackgroundColor,
            callback: () async => Navigator.pop(context),
            svgImage: kpathSvgBudgets,
            heroAnimation: BudgetsScreen.name),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            children: [
              isSearching
                  ? SearchTextField(
                      clearField: () =>
                          setState(() => searchController.clear()),
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
                        listReverse
                            ? mapList = mapList.reversed.toList()
                            : null;
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
                                Budget budget = Budget.fromMap(mapList[index]);

                                return CustomListTile(
                                    deleteCallback: () async {
                                      await _showDeleteAlertDialog(
                                          context, budget);
                                    },
                                    editCallback: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              AddBudgetScreen(),
                                        ),
                                      );
                                    },
                                    title: budget.nomeCliente!,
                                    icon: Icons.factory,
                                    subtitle: budget.valorTotal.toString());
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
        floatingActionButton: showFabVisible
            ? ButtonRoundWithShadow(
                size: 60,
                borderColor: woodSmoke,
                color: white,
                callback: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddBudgetScreen())),
                shadowColor: woodSmoke,
                iconPath: kpathSvgPlus)
            : null);
  }

  _showDeleteAlertDialog(context, Budget budget) {
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
        await gSheetDb.deleteProvider(budget.id!);
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(budget.nomeCliente!),
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
