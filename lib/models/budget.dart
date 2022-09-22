// To parse this JSON data, do
//
//     final budget = budgetFromMap(jsonString);

import 'dart:convert';

import 'package:easy_manager/models/product.dart';
import 'package:json_annotation/json_annotation.dart';
part 'budget.g.dart';

@JsonSerializable()
class Budget {
  Budget({
    this.id = '',
    this.nomeCliente = '',
    this.data = '',
    this.listaProdutos,
    this.listaValoresProdutos,
    this.valorTotal = 0,
    this.status = '',
  });

  String? id;
  String? nomeCliente;
  String? data;
  List<Map<String, int>>? listaProdutos = [];
  List<double>? listaValoresProdutos = [];
  double? valorTotal;
  String? status;

  void addIncrementProduct(String productName, double? productValue) {
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
  }

  void decrementProduct(String productName, double productValue) {
    var keysList = listaProdutos!.expand((element) => element.keys);
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
  }

  factory Budget.fromJson(Map<String, dynamic> json) => _$BudgetFromJson(json);

  Map<String, dynamic> toJson() => _$BudgetToJson(this);

  @override
  String toString() {
    return 'Budget{id: $id, nomeCliente: $nomeCliente, data: $data, listaProdutos: $listaProdutos, valorTotal: $valorTotal, status: $status}';
  }
}
