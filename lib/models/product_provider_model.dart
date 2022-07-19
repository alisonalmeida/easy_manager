import 'package:easy_manager/models/address_model.dart';
import 'package:objectbox/objectbox.dart';

import 'company_model.dart';

//flutter pub run build_runner build --delete-conflicting-outputs
@Entity()
@Sync()
class ProductProvider {
  int id;

  final String? name;
  final String? document;
  final String? phoneNumber1;
  final String? phoneNumber2;
  String? address;
  final String? email;
  final String? observations;

  final dbModel = ToOne<CompanyModel>();

  ProductProvider(
      {this.id = 0,
      this.name,
      this.document,
      this.phoneNumber1,
      this.phoneNumber2,
      this.address,
      this.email,
      this.observations});

  setAddress(Address? address) {
    this.address = addressToJson(address!).toString();
  }

  String get getAddress {
    return address!;
  }
}
