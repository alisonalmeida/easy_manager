import 'package:easy_manager/models/address_model.dart';
import 'package:objectbox/objectbox.dart';

//flutter pub run build_runner build --delete-conflicting-outputs

@Entity()
@Sync()
class Customer {
  int id;
  final String name;
  final String cpf;
  var address = Address;
  final String phoneNumber1;
  final String phoneNumber2;
  final String email;
  final String observations;

  Customer({
    this.id = 0,
    required this.name,
    required this.cpf,
    //TODO handle address  this.address = Address,
    required this.phoneNumber1,
    required this.phoneNumber2,
    required this.email,
    required this.observations,
  });
}
