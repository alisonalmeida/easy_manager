import 'package:easy_manager/models/address_model.dart';
import 'package:objectbox/objectbox.dart';

//flutter pub run build_runner build --delete-conflicting-outputs

@Entity()
@Sync()
class CustomerModel {
  int id = 0;
  final String? name;
  final String? cpf;
  String? _address;
  final String? phoneNumber1;
  final String? phoneNumber2;
  final String? email;
  final String? observations;

  CustomerModel({
    required this.name,
    required this.cpf,
    required this.phoneNumber1,
    required this.phoneNumber2,
    required this.email,
    required this.observations,
  });

  setAddress(Address? address) {
    _address = addressToJson(address!).toString();
  }

  String get getAddress {
    return _address!;
  }
}
