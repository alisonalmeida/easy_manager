import 'package:easy_manager/models/address_model.dart';

class ProductProvider {
  ProductProvider(
      {required this.name,
      required this.document,
      required this.phoneList,
      required this.address,
      required this.email,
      required this.observations});

  final String name;
  final String document;
  final List<String> phoneList;
  final Address address;
  final List<String> email;
  final String observations;
}
