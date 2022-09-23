// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_budget.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemBudget _$ItemBudgetFromJson(Map<String, dynamic> json) => ItemBudget(
      produtoNome: json['produtoNome'] as String?,
      produtoValor: (json['produtoValor'] as num?)?.toDouble(),
      quantidade: json['quantidade'] as int?,
    );

Map<String, dynamic> _$ItemBudgetToJson(ItemBudget instance) =>
    <String, dynamic>{
      'produtoNome': instance.produtoNome,
      'produtoValor': instance.produtoValor,
      'quantidade': instance.quantidade,
    };
