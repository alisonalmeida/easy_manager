// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_budget.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemBudget _$ItemBudgetFromJson(Map<String, dynamic> json) => ItemBudget(
      idProduct: '"${json['idProduct']}"',
      produtoNome: '"${json['produtoNome']}"',
      produtoValor: (json['produtoValor'] as num?)?.toDouble(),
      quantidade: json['quantidade'] as int?,
    );

Map<String, dynamic> _$ItemBudgetToJson(ItemBudget instance) =>
    <String, dynamic>{
      'idProduct': '"${instance.idProduct}"',
      'produtoNome': '"${instance.produtoNome}"',
      'produtoValor': instance.produtoValor,
      'quantidade': instance.quantidade,
    };
