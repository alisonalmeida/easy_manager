import 'package:hive/hive.dart';
part 'address_model.g.dart';

// to generate model.g.dart run> flutter pub run build_runner build --delete-conflicting-outputs
@HiveType(typeId: 0)
class Address {
  Address({
    required this.id,
    required this.cep,
    required this.logradouro,
    required this.complemento,
    required this.bairro,
    required this.localidade,
    required this.uf,
    required this.numero,
  });

  @HiveField(0)
  String id;
  @HiveField(1)
  String cep;
  @HiveField(2)
  String logradouro;
  @HiveField(3)
  String complemento;
  @HiveField(4)
  String bairro;
  @HiveField(5)
  String localidade;
  @HiveField(6)
  String uf;
  @HiveField(7)
  String numero;
}
