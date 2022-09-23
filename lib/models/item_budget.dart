import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
part 'item_budget.g.dart';

@JsonSerializable()
class ItemBudget {
  String? produtoNome;
  double? produtoValor;
  int? quantidade;

  ItemBudget({
    this.produtoNome,
    this.produtoValor,
    this.quantidade,
  });

  factory ItemBudget.fromJson(Map<String, dynamic> json) =>
      _$ItemBudgetFromJson(json);

  Map<String, dynamic> toJson() => _$ItemBudgetToJson(this);

  @override
  String toString() {
    return 'produtoNome: $produtoNome, produtoValor: $produtoValor, quantidade: $quantidade';
  }
}
