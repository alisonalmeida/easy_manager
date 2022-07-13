import 'package:easy_manager/models/address_model.dart';
import 'package:objectbox/objectbox.dart';

//flutter pub run build_runner build --delete-conflicting-outputs

@Entity()
@Sync()
class ProductProvider {
  int id;

  final String name;
  final String document;
  final String phoneNumber1;
  final String phoneNumber2;
  var address = Address;
  final String email;
  final String observations;
  ProductProvider(
      {this.id = 0,
      required this.name,
      required this.document,
      required this.phoneNumber1,
      required this.phoneNumber2,
      this.address = Address,
      required this.email,
      required this.observations});
}
