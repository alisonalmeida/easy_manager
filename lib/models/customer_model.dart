import 'package:easy_manager/models/address_model.dart';
import 'package:easy_manager/models/company_model.dart';
import 'package:objectbox/objectbox.dart';

//flutter pub run build_runner build --delete-conflicting-outputs

@Entity()
@Sync()
class Customer {
  int id;
  final String? name;
  final String? cpf;
  String? address;
  final String? phoneNumber1;
  final String? phoneNumber2;
  final String? email;
  final String? observations;

  final dbModel = ToOne<CompanyModel>();

  Customer({
    this.id = 0,
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

  teste() {
    Customer customer = Customer();
  }
}
