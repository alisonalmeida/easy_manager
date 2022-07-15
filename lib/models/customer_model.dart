import 'package:easy_manager/models/address_model.dart';
import 'package:easy_manager/models/db_model.dart';
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

  final dbModel = ToOne<DbModelBox>();

  CustomerModel({
    this.name,
    this.cpf,
    this.address,
    this.phoneNumber1,
    this.phoneNumber2,
    this.email,
    this.observations,
  });

  setAddress(Address? address) {
    this.address = addressToJson(address!).toString();
  }

  String get getAddress {
    return address!;
  }
}
