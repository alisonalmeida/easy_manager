// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: json['id'] as String? ?? '',
      codigo: json['codigo'] as String?,
      nome: json['nome'] as String?,
      fornecedorDocumento: json['fornecedorDocumento'] as String?,
      valorCusto: (double.parse(json['valorCusto'])),
      valorVenda: (double.parse(json['valorVenda'])),
      marca: json['marca'] as String?,
      categoria: json['categoria'] as String?,
      unidadeMedida: json['unidadeMedida'] as String?,
      quantidadeMinima:  int.parse(json['quantidadeMinima']),
      descricao: json['descricao'] as String?,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'nome': instance.nome,
      'codigo': instance.codigo,
      'fornecedorDocumento': instance.fornecedorDocumento,
      'valorCusto': instance.valorCusto,
      'valorVenda': instance.valorVenda,
      'marca': instance.marca,
      'categoria': instance.categoria,
      'unidadeMedida': instance.unidadeMedida,
      'quantidadeMinima': instance.quantidadeMinima,
      'descricao': instance.descricao,
    };
