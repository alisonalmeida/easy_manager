// To parse this JSON data, do
//
//     final budget = budgetFromMap(jsonString);

import 'dart:convert';
import 'package:easy_manager/models/item_budget.dart';
import 'package:easy_manager/models/product.dart';
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
  List<ItemBudget>? itens = [];
  double valorTotal = 0.0;
  String? status;

  void changeCustomerName(String name) {
    nomeCliente = name;
  }

  void incrementItem(Product product) {
    ItemBudget newItem = ItemBudget(
      idProduct: '"${product.id}"',
      produtoNome: '"${product.nome}"',
      produtoValor: product.valorVenda,
      quantidade: 1,
    );
    if (itens!.isNotEmpty) {
      for (var i = 0; i < itens!.length; i++) {
        if (itens!.elementAt(i).idProduct == newItem.idProduct) {
          int quantidade = itens!.elementAt(i).quantidade!;
          itens!.removeAt(i);
          newItem.quantidade = newItem.quantidade! + quantidade;
          itens!.add(newItem);
          calculateTotalValue();
          return;
        }
      }
      itens!.add(newItem);
      calculateTotalValue();
      return;
    }

    if (itens!.isEmpty) {
      itens!.add(newItem);
      calculateTotalValue();
      return;
    }
  }

  void decrementItem(Product product) {
    for (var i = 0; i < itens!.length; i++) {
      if (itens!.elementAt(i).idProduct == '"${product.id}"') {
        if (itens!.elementAt(i).quantidade! > 0) {
          itens!.elementAt(i).quantidade = itens!.elementAt(i).quantidade! - 1;
          break;
        }
        if (itens!.elementAt(i).quantidade == 0) {
          itens!.remove(itens!.elementAt(i));
          break;
        }
      }
    }
    calculateTotalValue();
  }

  void calculateTotalValue() {
    valorTotal = 0;
    for (var element in itens!) {
      valorTotal = element.produtoValor! * element.quantidade! + valorTotal;
    }
  }

  @override
  String toString() {
    return 'Budget(id: $id, nomeCliente: $nomeCliente, data: $data, itens: $itens, valorTotal: $valorTotal, status: $status)';
  }

  factory Budget.fromJson(Map<String, dynamic> json) => _$BudgetFromJson(json);

  Map<String, dynamic> toJson() => _$BudgetToJson(this);
}
