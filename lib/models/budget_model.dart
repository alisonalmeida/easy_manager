// To parse this JSON data, do
//
//     final Budget = BudgetFromMap(jsonString);

import 'dart:convert';

Budget budgetFromMap(String str) => Budget.fromMap(json.decode(str));

String budgetToMap(Budget data) => json.encode(data.toMap());

class Budget {
  Budget({
    this.id = '',
    this.nomeCliente,
    this.data,
    this.listaProdutosId,
    this.valorTotal,
    this.status,
  });

  String? id;
  String? nomeCliente;
  String? data;
  List<String>? listaProdutosId=[];
  double? valorTotal;
  String? status;

  factory Budget.fromMap(Map<String, dynamic> json) => Budget(
        id: json["id"],
        nomeCliente: json["nomeCliente"],
        data: json["data"],
        listaProdutosId:
            List<String>.from(json["listaProdutosId"].map((x) => x)),
        valorTotal: json["valorTotal"].toDouble(),
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nomeCliente": nomeCliente,
        "data": data,
        "listaProdutosId": List<dynamic>.from(listaProdutosId!.map((x) => x)),
        "valorTotal": valorTotal,
        "status": status,
      };
}
