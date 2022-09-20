// To parse this JSON data, do
//
//     final budget = budgetFromMap(jsonString);

import 'dart:convert';

import 'package:easy_manager/models/product_model.dart';

Budget budgetFromMap(String str) => Budget.fromMap(json.decode(str));

String budgetToMap(Budget data) => json.encode(data.toMap());

class Budget {
  Budget({
    this.id = '',
    this.nomeCliente = '',
    this.data = '',
    this.listaProdutos,
    this.valorTotal = 0,
    this.status = '',
  });

  String? id;
  String? nomeCliente;
  String? data;
  List<Map<Product, int>>? listaProdutos = [];
  double? valorTotal;
  String? status;

  void addIncrementProduct(Product product) {
    var keysList = listaProdutos!.expand((element) => element.keys);
    var valuesList = listaProdutos!.expand((element) => element.values);
    var lenghtList = listaProdutos!.length;

    for (var i = 0; i < lenghtList; i++) {
      if (product.id == keysList.elementAt(i).id) {
        listaProdutos![i][keysList.elementAt(i)] = valuesList.elementAt(i) + 1;
      }
    }
  }

  factory Budget.fromMap(Map<String, dynamic> json) => Budget(
        id: json["id"],
        nomeCliente: json["nomeCliente"],
        data: json["data"],
        listaProdutos: [],
        valorTotal: double.parse(json["valorTotal"]),
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nomeCliente": nomeCliente,
        "data": data,
        "listaProdutos": List<dynamic>.from(listaProdutos!.map((x) => x)),
        "valorTotal": valorTotal,
        "status": status,
      };

  @override
  String toString() {
    return 'Budget{id: $id, nomeCliente: $nomeCliente, data: $data, listaProdutos: $listaProdutos, valorTotal: $valorTotal, status: $status}';
  }
}
