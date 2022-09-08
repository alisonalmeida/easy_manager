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
    this.produtos,
    this.valorTotal,
    this.status,
  });

  String? id;
  String? nomeCliente;
  String? data;
  List<Product>? produtos;
  double? valorTotal;
  String? status;

  factory Budget.fromMap(Map<String, dynamic> json) => Budget(
        id: json["id"],
        nomeCliente: json["nomeCliente"],
        data: json["data"],
        produtos:
            List<Product>.from(json["produtos"].map((x) => Product.fromMap(x))),
        valorTotal: json["valorTotal"].toDouble(),
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nomeCliente": nomeCliente,
        "data": data,
        "produtos": List<dynamic>.from(produtos!.map((x) => x.toMap())),
        "valorTotal": valorTotal,
        "status": status,
      };
}
