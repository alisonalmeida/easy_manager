import 'dart:convert';

ProductProvider productProviderFromJson(String str) =>
    ProductProvider.fromJson(json.decode(str));

String productProviderToJson(ProductProvider data) =>
    json.encode(data.toJson());

class ProductProvider {
  String? id;
  final String? nome;
  final String? documento;
  final String? telefone1;
  final String? telefone2;
  final String? cep;
  final String? uf;
  final String? localidade;
  final String? logradouro;
  final String? bairro;
  final String? numero;
  final String? complemento;
  final String? email;
  final String? observacoes;

  ProductProvider({
    this.id = '',
    this.nome,
    this.documento,
    this.telefone1,
    this.telefone2,
    this.email,
    this.cep,
    this.uf,
    this.localidade,
    this.logradouro,
    this.bairro,
    this.numero,
    this.complemento,
    this.observacoes,
  });

  factory ProductProvider.fromJson(String str) =>
      ProductProvider.fromMap(json.decode(str));

  factory ProductProvider.fromMap(Map<String, dynamic> json) => ProductProvider(
        id: json["id"],
        nome: json["nome"],
        documento: json["documento"],
        telefone1: json["telefone1"],
        telefone2: json["telefone2"],
        email: json["email"],
        cep: json["cep"],
        uf: json["uf"],
        localidade: json["localidade"],
        logradouro: json["logradouro"],
        bairro: json["bairro"],
        numero: json["numero"],
        complemento: json["complemento"],
        observacoes: json["observacoes"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nome": nome,
        "documento": documento,
        "telefone1": telefone1,
        "telefone2": telefone2,
        "email": email,
        "cep": cep,
        "uf": uf,
        "localidade": localidade,
        "logradouro": logradouro,
        "bairro": bairro,
        "numero": numero,
        "complemento": complemento,
        "observacoes": observacoes,
      };

  @override
  String toString() {
    return 'ProductProvider{id: $id, nome: $nome, documento: $documento, telefone1: $telefone1, telefone2: $telefone2, email: $email, cep: $cep, uf: $uf, localidade: $localidade, logradouro: $logradouro, bairro: $bairro, numero: $numero, complemento: $complemento, observacoes: $observacoes}';
  }
}
