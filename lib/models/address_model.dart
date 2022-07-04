// to generate model.g.dart run> flutter pub run build_runner build --delete-conflicting-outputs

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

  String id;

  String cep;

  String logradouro;

  String complemento;
  String bairro;

  String localidade;

  String uf;

  String numero;
}
