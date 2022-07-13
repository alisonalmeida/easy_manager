import 'package:objectbox/objectbox.dart';

//flutter pub run build_runner build --delete-conflicting-outputs

@Entity()
@Sync()
class Address {
  int id;

  String? cep;
  String? logradouro;
  String? complemento;
  String? bairro;
  String? localidade;
  String? uf;
  String? numero;

  Address({
    this.id = 0,
    this.cep,
    this.logradouro,
    this.complemento,
    this.bairro,
    this.localidade,
    this.uf,
    this.numero,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
        bairro: json['bairro'],
        cep: json['cep'],
        complemento: json['complemento'],
        localidade: json['localidade'],
        logradouro: json['logradouro'],
        uf: json['uf']);
  }
}
