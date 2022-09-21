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
      valorCusto: (json['valorCusto'] as num?)?.toDouble(),
      valorVenda: (json['valorVenda'] as num?)?.toDouble(),
      marca: json['marca'] as String?,
      categoria: json['categoria'] as String?,
      unidadeMedida: json['unidadeMedida'] as String?,
      quantidadeMinima: json['quantidadeMinima'] as int?,
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
