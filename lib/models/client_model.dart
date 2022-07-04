import 'package:easy_manager/models/address_model.dart';

class Client {
  Client({
    required this.name,
    required this.cpf,
    required this.address,
    required this.phoneList,
    required this.email,
    required this.observations,
  });

  final String name;

  final String cpf;

  final Address address;

  final List<String> phoneList;

  final String email;

  final String observations;
}
