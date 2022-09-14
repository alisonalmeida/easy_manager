// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

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
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BudgetsScreen extends ConsumerWidget {
  BudgetsScreen({Key? key}) : super(key: key);
  static String name = 'Orçamentos';

  bool showFabVisible = true;
  bool listReverse = false;
  bool isSearch = false;
  bool isSearching = false;
  FocusNode focusNode = FocusNode();
  TextEditingController searchController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var budgetList = ref.watch(budgetsProvider);
    return Scaffold(
        key: _scaffoldKey,
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
                      clearField: () {
                        searchController.clear();
                      },
                      focusNode: focusNode,
                      searchController: searchController,
                    )
                  : Container(),
              Expanded(
                child: budgetList.when(
                    data: (data) {
                      List<Map<String, String>> mapList = data;
                      listReverse ? mapList = mapList.reversed.toList() : null;
                      isSearching
                          ? mapList = mapList
                              .where((element) => element['id']
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
                            showFabVisible = false;
                          }
                          if (notification.direction ==
                              ScrollDirection.forward) {
                            showFabVisible = true;
                          }
                          return true;
                        },
                        child: mapList == null
                            ? EmptyWidget()
                            : ListView.builder(
                                itemCount: mapList.toList().length,
                                itemBuilder: (context, index) {
                                  Budget budget =
                                      Budget.fromMap(mapList[index]);

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
                                      icon: Icons.list,
                                      subtitle: budget.valorTotal.toString());
                                }),
                      );
                    },
                    error: (error, stackTrace) => Center(
                          child: Column(
                            children: [
                              Text(stackTrace.toString()),
                              Text(error.toString()),
                            ],
                          ),
                        ),
                    loading: () {
                      return Center(
                        child: CircularProgressIndicator(color: black),
                      );
                    }),
              ),
            ],
          ),
        ),
        persistentFooterButtons: [
          IconButton(
              onPressed: () {
                listReverse = !listReverse;
                ref.refresh(budgetsProvider);
              },
              icon: Icon(Icons.filter_alt)),
          IconButton(
              onPressed: () {
                isSearching = !isSearching;
                ref.refresh(budgetsProvider);
                focusNode.requestFocus();
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

  Future _showDeleteAlertDialog(context, Budget budget) async {
    // set up the buttons

    Widget cancelButton = Consumer(
      builder: (context, ref, child) => TextButton(
          child: Text("Cancelar"), onPressed: () => Navigator.pop(context)),
    );
    Widget continueButton = Consumer(
      builder: (context, ref, child) => TextButton(
        child: Text("Confirmar"),
        onPressed: () async {
          await gSheetDb.deleteBudget(budget.id!);
          Navigator.pop(context);
          ref.refresh(budgetsProvider);
        },
      ),
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
      builder: (context) => alert,
    );
  }
}
