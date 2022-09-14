// To parse this JSON data, do
//
//     final budget = budgetFromMap(jsonString);

import 'dart:convert';

import 'package:easy_manager/models/product_model.dart';

Budget budgetFromMap(String str) => Budget.fromMap(json.decode(str));

String budgetToMap(Budget data) => json.encode(data.toMap());

class Budget {
  Budget({
    this.id,
    this.nomeCliente,
    this.data,
    this.listaProdutos,
    this.valorTotal,
    this.status,
  });

  String? id;
  String? nomeCliente;
  String? data;
  List<Product>? listaProdutos;
  double? valorTotal;
  String? status;

  factory Budget.fromMap(Map<String, dynamic> json) {
    return Budget(
      id: json["id"],
      nomeCliente: json["nomeCliente"],
      data: json["data"],
      listaProdutos: List<Product>.from([]),
      valorTotal: double.parse(json["valorTotal"]),
      status: json["status"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "nomeCliente": nomeCliente,
      "data": data,
      "Product": List<Product>.from(listaProdutos!.map((x) => x.toMap())),
      "valorTotal": valorTotal,
      "status": status,
    };
  }
}
