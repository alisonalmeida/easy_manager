import 'dart:convert';

Customer productProviderFromJson(String str) =>
    Customer.fromJson(json.decode(str));

String productProviderToJson(Customer data) =>
    json.encode(data.toJson());

class Customer {
  String? id;
  final String? nome;
  final String? documento;
  final String? cep;
  final String? uf;
  final String? localidade;
  final String? logradouro;
  final String? bairro;
  final String? numero;
  final String? complemento;
  final String? telefone1;
  final String? telefone2;
  final String? email;
  final String? observacoes;

  Customer({
    this.id='',
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

  factory Customer.fromJson(String str) =>
      Customer.fromMap(json.decode(str));

  factory Customer.fromMap(Map<String, dynamic> json) => Customer(
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
}
