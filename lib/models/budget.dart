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
    print('INSERT');
    if (itens!.isNotEmpty) {
      for (var i = 0; i < itens!.length; i++) {
        ItemBudget newItem = ItemBudget(
            idProduct: '"${product.id}"',
            produtoNome: '"${product.nome}"',
            produtoValor: product.valorVenda,
            quantidade: itens!.elementAt(i).quantidade!);

        if (itens!.elementAt(i).idProduct == '"${product.id}"') {
          print('IF 1');

          itens!.removeAt(i);
          newItem.quantidade = newItem.quantidade! + 1;
          itens!.add(newItem);
          break;
        }
        var v = itens!.map((e) => e.idProduct);
        if (v.contains(itens!.elementAt(i).idProduct)) {
          print('IF 2');
          ItemBudget newItem = ItemBudget(
            idProduct: '"${product.id}"',
            produtoNome: '"${product.nome}"',
            produtoValor: product.valorVenda,
            quantidade: itens!.elementAt(i).quantidade,
          );

          newItem.quantidade = newItem.quantidade! + 1;
          itens!.insert(i, newItem);
          break;
        }
      }
    }
    if (itens!.isEmpty) {
      ItemBudget itemBudget = ItemBudget(
        idProduct: '"${product.id}"',
        produtoNome: '"${product.nome}"',
        produtoValor: product.valorVenda,
        quantidade: 1,
      );
      itens!.add(itemBudget);
      return;
    }
  }

  void decrementItem(String productName, double productValue) {
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
