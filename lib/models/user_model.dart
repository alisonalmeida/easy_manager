// To parse this JSON data, do
//
//     final user = userFromMap(jsonString);

import 'dart:convert';

User userFromMap(String str) => User.fromMap(json.decode(str));

String userToMap(User data) => json.encode(data.toMap());

class User {
  User({
    this.nome,
    this.email,
    this.senha,
    this.perfil,
  });

  String? nome;
  String? email;
  String? senha;
  String? perfil;

  factory User.fromMap(Map<String, dynamic> json) => User(
        nome: json["nome"],
        email: json["email"],
        senha: json["senha"],
        perfil: json["perfil"],
      );

  Map<String, dynamic> toMap() => {
        "nome": nome,
        "email": email,
        "senha": senha,
        "perfil": perfil,
      };
}
