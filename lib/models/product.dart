
import 'package:json_annotation/json_annotation.dart';
part 'product.g.dart';


@JsonSerializable()
class Product {
  String? id;
  final String? nome;
  final String? codigo;
  final String? fornecedorDocumento;
  final double? valorCusto;
  final double? valorVenda;
  final String? marca;
  final String? categoria;
  final String? unidadeMedida;
  final int? quantidadeMinima;
  final String? descricao;

  Product(
      {this.id = '',
      this.codigo,
      this.nome,
      this.fornecedorDocumento,
      this.valorCusto,
      this.valorVenda,
      this.marca,
      this.categoria,
      this.unidadeMedida,
      this.quantidadeMinima,
      this.descricao});

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  @override
  String toString() {
    return '{id: $id, nome: $nome, codigo: $codigo, fornecedorDocumento: $fornecedorDocumento, valorCusto: $valorCusto, valorVenda: $valorVenda, marca: $marca, categoria: $categoria, unidadeMedida: $unidadeMedida, quantidadeMinima: $quantidadeMinima, descricao: $descricao}';
  }
}
