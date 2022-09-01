import 'package:easy_manager/models/address_model.dart';


class Customer {
  final String? name;
  final String? cpf;
  final Address? address;
  final String? phoneNumber1;
  final String? phoneNumber2;
  final String? email;
  final String? observations;


  Customer({
    this.name,
    this.cpf,
    this.address,
    this.phoneNumber1,
    this.phoneNumber2,
    this.email,
    this.observations,
  });


}
