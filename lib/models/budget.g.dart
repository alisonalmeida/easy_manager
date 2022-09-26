// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Budget _$BudgetFromJson(Map<String, dynamic> json) {
  return Budget(
    id: json['id'] as String? ?? '',
    nomeCliente: json['nomeCliente'] as String? ?? '',
    data: json['data'] as String? ?? '',
    itens: (jsonDecode(json['itens']) as List<dynamic>?)
        ?.map((e) => ItemBudget.fromJson(e as Map<String, dynamic>))
        .toList(),
    valorTotal: (double.parse(json['valorTotal'])),
    status: json['status'] as String? ?? '',
  );
}

Map<String, dynamic> _$BudgetToJson(Budget instance) {
  return <String, dynamic>{
    'id': instance.id,
    'nomeCliente': instance.nomeCliente,
    'data': instance.data,
    'itens': instance.itens?.map((e) => e.toJson()).toList(),
    'valorTotal': instance.valorTotal,
    'status': instance.status,
  };
}
