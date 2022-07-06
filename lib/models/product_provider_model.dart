import 'package:easy_manager/models/address_model.dart';
import 'package:hive/hive.dart';
part 'product_provider_model.g.dart';

//flutter pub run build_runner build --delete-conflicting-outputs

@HiveType(typeId: 3)
class ProductProvider {
  ProductProvider(
      {required this.name,
      required this.document,
      required this.phoneList,
      required this.address,
      required this.email,
      required this.observations});
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String document;
  @HiveField(2)
  final List<String> phoneList;
  @HiveField(3)
  final Address address;
  @HiveField(4)
  final List<String> email;
  @HiveField(5)
  final String observations;
}
