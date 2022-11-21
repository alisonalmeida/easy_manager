// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, must_be_immutable

import 'dart:async';
import 'package:easy_manager/consts.dart';
import 'package:easy_manager/core/generate_budget_pdf.dart';
import 'package:easy_manager/custom_widgets/button_round_with_shadow.dart';
import 'package:easy_manager/custom_widgets/custom_app_bar.dart';
import 'package:easy_manager/custom_widgets/custom_list_tile.dart';
import 'package:easy_manager/custom_widgets/custom_search_text_field.dart';
import 'package:easy_manager/custom_widgets/empty_widget.dart';
import 'package:easy_manager/main.dart';
import 'package:easy_manager/models/budget.dart';

import 'package:easy_manager/screens/budget/crud_budget_screen.dart';
import 'package:easy_manager/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BudgetsScreen extends ConsumerWidget {
  BudgetsScreen({Key? key}) : super(key: key);
  static String name = 'Orçamentos';

  bool showFabVisible = true;
  bool listReverse = true;
  bool isSearch = true;
  bool isSearching = false;
  FocusNode focusNode = FocusNode();
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future createUpdateBudget(Budget budget) async {
      showGeneralLoading(context);
      budget.id = await gSheetDb.putBudget(budget);
      Navigator.pop(context);
    }

    var budgetList = ref.watch(budgetsProvider);
    return Scaffold(
        backgroundColor: budgetBackgroundColor,
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            CustomAppBar(
                title: BudgetsScreen.name,
                backgroundColor: budgetBackgroundColor,
                callback: () async => Navigator.pop(context),
                svgImage: kpathSvgBudgets,
                heroAnimation: BudgetsScreen.name),
          ],
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
                        onChanged: (p0) => ref.refresh(budgetsProvider),
                      )
                    : Container(),
                Expanded(
                  child: budgetList.when(
                    data: (data) {
                      List<Map<String, String>> mapList = data;
                      listReverse ? mapList = mapList.reversed.toList() : null;
                      isSearching
                          ? mapList = mapList
                              .where((element) => element['nomeCliente']
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
                        child: mapList.isEmpty
                            ? EmptyWidget()
                            : ListView.builder(
                                itemCount: mapList.toList().length,
                                itemBuilder: (context, index) {
                                  Budget budget =
                                      Budget.fromJson(mapList[index]);

                                  return CustomListTile(
                                    listOptions:
                                        buildOptionsMenu(context, budget),
                                    title: budget.nomeCliente!,
                                    icon: Icons.table_rows,
                                    subtitle: Text(
                                      'Total: R\$ ${budget.valorTotal}',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.green[900],
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  );
                                }),
                      );
                    },
                    error: (error, stackTrace) => Center(
                        child: Text(error.toString() + stackTrace.toString())),
                    loading: () =>
                        Center(child: CircularProgressIndicator(color: black)),
                  ),
                ),
              ],
            ),
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
                ref.refresh(budgetsProvider);
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
                callback: () async {
                  try {
                    bool? shoudRefresh;
                    Budget budget = Budget();
                    await createUpdateBudget(budget);
                    shoudRefresh = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CrudBudgetScreen(
                                  isUpdate: false,
                                  budget: budget,
                                )));
                    shoudRefresh == true ? ref.refresh(budgetsProvider) : null;
                  } catch (e) {
                    showGeneralInformationDialogErrorMessage(
                        e.toString(), context);
                  }
                },
                shadowColor: black,
                iconPath: kpathSvgPlus,
              )
            : null);
  }

  Widget buildOptionsMenu(BuildContext context, Budget budget) {
    return PopupMenuButton<String>(
      shape: Border.all(),
      tooltip: 'Menu',
      onSelected: (value) async {
        if (value == 'Editar') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  CrudBudgetScreen(isUpdate: true, budget: budget),
            ),
          );
        } else if (value == 'Deletar') {
          _showDeleteAlertDialog(context, budget);
        } else if (value == 'Compartilhar') {
          showGeneralLoading(context);
          await GenerateBudgetPdf(budget: budget).generateDocument();
          Navigator.pop(context);
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
        PopupMenuItem(
          value: 'Compartilhar',
          child: Text('Compartilhar'),
        ),
      ],
    );
  }

  Future _showDeleteAlertDialog(context, Budget budget) async {
    // set up the buttons

    Widget cancelButton = TextButton(
        child: Text("Cancelar"), onPressed: () => Navigator.pop(context));

    Widget continueButton = Consumer(
      builder: (context, ref, child) => TextButton(
        child: Text("Confirmar"),
        onPressed: () async {
          showGeneralLoading(context);
          await gSheetDb.deleteBudget(budget.id!);
          searchController.clear();
          ref.refresh(budgetsProvider);
          Navigator.of(context).pop();
          Navigator.of(context).pop();
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
