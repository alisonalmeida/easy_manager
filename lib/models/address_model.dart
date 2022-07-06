import 'package:hive/hive.dart';

part 'address_model.g.dart';

//flutter pub run build_runner build --delete-conflicting-outputs
@HiveType(typeId: 0)
class Address {
  Address({
    this.cep,
    this.logradouro,
    this.complemento,
    this.bairro,
    this.localidade,
    this.uf,
    this.numero,
  });
  @HiveField(0)
  String? cep;
  @HiveField(1)
  String? logradouro;
  @HiveField(2)
  String? complemento;
  @HiveField(3)
  String? bairro;
  @HiveField(4)
  String? localidade;
  @HiveField(5)
  String? uf;
  @HiveField(6)
  String? numero;

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
        bairro: json['bairro'],
        cep: json['cep'],
        complemento: json['complemento'],
        localidade: json['localidade'],
        logradouro: json['logradouro'],
        numero: json['numero'],
        uf: json['uf']);
  }
}
