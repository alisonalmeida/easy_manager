import 'package:easy_manager/models/address_model.dart';
import 'dart:convert';

class ProductProvider {
  final String? nome;
  final String? documento;
  final String? telefone1;
  final String? telefone2;
  final Address? address;
  final String? email;
  final String? observacoes;

  ProductProvider(
      {this.nome,
      this.documento,
      this.telefone1,
      this.telefone2,
      this.address,
      this.email,
      this.observacoes});

  factory ProductProvider.fromJson(String str) =>
      ProductProvider.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductProvider.fromMap(Map<String, dynamic> json) => ProductProvider(
        nome: json["nome"],
        documento: json["documento"],
        telefone1: json["telefone1"],
        telefone2: json["telefone2"],
        email: json["email"],
        observacoes: json["observacoes"],
      );

  Map<String, dynamic> toMap() => {
        "nome": nome,
        "documento": documento,
        "telefone1": telefone1,
        "telefone2": telefone2,
        "email": email,
        "observacoes": observacoes,
      };
}
