import 'package:easy_manager/models/address_model.dart';
import 'package:hive/hive.dart';
part 'customer_model.g.dart';

//flutter pub run build_runner build --delete-conflicting-outputs
@HiveType(typeId: 1)
class Customer {
  Customer({
    required this.name,
    required this.cpf,
    required this.address,
    required this.phoneNumber1,
    required this.phoneNumber2,
    required this.email,
    required this.observations,
  });
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String cpf;
  @HiveField(2)
  final Address address;
  @HiveField(3)
  final String phoneNumber1;
  @HiveField(4)
  final String phoneNumber2;
  @HiveField(5)
  final String email;
  @HiveField(6)
  final String observations;
}
