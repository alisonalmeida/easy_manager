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
    this.nomeCliente,
    this.data,
    this.listaprodutos,
    this.valorTotal = 0,
    this.status,
  });

  String? id;
  String? nomeCliente;
  String? data;
  List<Map<int, Product>>? listaprodutos = [];
  double? valorTotal;
  String? status;

  factory Budget.fromMap(Map<String, dynamic> json) => Budget(
        id: json["id"],
        nomeCliente: json["nomeCliente"],
        data: json["data"],
        listaprodutos: [],
        valorTotal: double.parse(json["valorTotal"]),
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nomeCliente": nomeCliente,
        "data": data,
        "listaprodutos": listaprodutos,
        "valorTotal": valorTotal,
        "status": status,
      };
}
