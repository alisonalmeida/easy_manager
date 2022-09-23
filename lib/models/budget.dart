// To parse this JSON data, do
//
//     final budget = budgetFromMap(jsonString);

import 'dart:convert';
import 'package:easy_manager/models/item_budget.dart';
import 'package:json_annotation/json_annotation.dart';
part 'budget.g.dart';

@JsonSerializable(explicitToJson: true)
class Budget {
  Budget({
    this.id = '',
    this.nomeCliente = '',
    this.data = '',
    this.itens,
    this.valorTotal = 0.0,
    this.status = '',
  });

  String? id;
  String? nomeCliente;
  String? data;
  List<ItemBudget>? itens=[];
  double valorTotal = 0.0;
  String? status;

  void addIncrementProduct(String productName, double? productValue) {
    /**
     * 
    var keysList = listaProdutos!.expand((element) => element.keys);
    var quantityList = listaProdutos!.expand((element) => element.values);
    var lenghtList = listaProdutos!.length;
    productValue ??= 0;
    for (var i = 0; i < lenghtList; i++) {
      if (productName == keysList.elementAt(i)) {
        listaProdutos![i][keysList.elementAt(i)] =
            quantityList.elementAt(i) + 1;
        valorTotal = valorTotal! + productValue;
        break;
      }
    }
     */
  }

  void decrementProduct(String productName, double productValue) {
    /**
     *  var keysList = listaProdutos!.expand((element) => element.keys);
    var quantityList = listaProdutos!.expand((element) => element.values);
    var lenghtList = listaProdutos!.length;

    for (var i = 0; i < lenghtList; i++) {
      if (productName == keysList.elementAt(i) &&
          quantityList.elementAt(i) > 0) {
        listaProdutos![i][keysList.elementAt(i)] =
            quantityList.elementAt(i) - 1;
        valorTotal = valorTotal! - productValue;
        break;
      }
    }
     */
  }

  @override
  String toString() {
    return 'Budget(id: $id, nomeCliente: $nomeCliente, data: $data, itens: $itens, valorTotal: $valorTotal, status: $status)';
  }

  factory Budget.fromJson(Map<String, dynamic> json) => _$BudgetFromJson(json);

  Map<String, dynamic> toJson() => _$BudgetToJson(this);
}
