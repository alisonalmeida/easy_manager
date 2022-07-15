import 'package:easy_manager/models/address_model.dart';
import 'package:easy_manager/objectbox.g.dart';



//flutter pub run build_runner build --delete-conflicting-outputs

@Entity()
@Sync()
class CustomerModel {
  int id = 0;
  final String? name;
  final String? cpf;
  String? address;
  final String? phoneNumber1;
  final String? phoneNumber2;
  final String? email;
  final String? observations;

  CustomerModel({
    required this.name,
    required this.cpf,
    this.address,
    required this.phoneNumber1,
    required this.phoneNumber2,
    required this.email,
    required this.observations,
  });

  setAddress(Address? address) {
    this.address = addressToJson(address!).toString();
  }

  String get getAddress {
    return address!;
  }
}
