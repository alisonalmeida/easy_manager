class Address {
  Address({
    this.id,
    this.cep,
    this.logradouro,
    this.complemento,
    this.bairro,
    this.localidade,
    this.uf,
    this.numero,
  });

  String? id;
  String? cep;
  String? logradouro;
  String? complemento;
  String? bairro;
  String? localidade;
  String? uf;
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
