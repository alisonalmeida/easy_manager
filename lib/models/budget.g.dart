// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Budget _$BudgetFromJson(Map<String, dynamic> json) {
  print(jsonDecode(json['listaProdutos']));
  return Budget(
    id: json['id'] as String? ?? '',
    nomeCliente: json['nomeCliente'] as String? ?? '',
    data: json['data'] as String? ?? '',
    listaProdutos: (jsonDecode('''"${json['listaProdutos']}"''') as List<dynamic>?)
        ?.map((e) => Map<String, int>.from(e as Map))
        .toList(),
    listaValoresProdutos:
        (jsonDecode(json['listaValoresProdutos']) as List<dynamic>?)
            ?.map((e) => (e as num).toDouble())
            .toList(),
    valorTotal: (double.parse(json['valorTotal'])).toDouble(),
    status: json['status'] as String? ?? '',
  );
}

Map<String, dynamic> _$BudgetToJson(Budget instance) => <String, dynamic>{
      'id': instance.id,
      'nomeCliente': instance.nomeCliente,
      'data': instance.data,
      'listaProdutos': instance.listaProdutos,
      'listaValoresProdutos': instance.listaValoresProdutos,
      'valorTotal': instance.valorTotal,
      'status': instance.status,
    };
