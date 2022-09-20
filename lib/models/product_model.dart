import 'dart:convert';



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

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        id: json["id"],
        codigo: json["codigo"],
        nome: json["nome"],
        fornecedorDocumento: json["fornecedorDocumento"],
        valorCusto: double.parse(json["valorCusto"]),
        valorVenda: double.parse(json["valorVenda"]),
        marca: json["marca"],
        categoria: json["categoria"],
        unidadeMedida: json["unidadeMedida"],
        quantidadeMinima: int.parse(json["quantidadeMinima"]),
        descricao: json["descricao"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "codigo": codigo,
        "nome": nome,
        "fornecedorDocumento": fornecedorDocumento,
        "valorCusto": valorCusto,
        "valorVenda": valorVenda,
        "marca": marca,
        "categoria": categoria,
        "unidadeMedida": unidadeMedida,
        "quantidadeMinima": quantidadeMinima,
        "descricao": descricao,
      };

  @override
  String toString() {
    return '{id: $id, nome: $nome, codigo: $codigo, fornecedorDocumento: $fornecedorDocumento, valorCusto: $valorCusto, valorVenda: $valorVenda, marca: $marca, categoria: $categoria, unidadeMedida: $unidadeMedida, quantidadeMinima: $quantidadeMinima, descricao: $descricao}';
  }
}
