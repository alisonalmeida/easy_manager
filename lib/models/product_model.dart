import 'package:easy_manager/models/product_provider_model.dart';
import 'package:hive/hive.dart';
part 'product_model.g.dart';

//flutter pub run build_runner build --delete-conflicting-outputs

@HiveType(typeId: 2)
class Product {
  Product(
      {required this.cod,
      required this.name,
      required this.productProviderDocument,
      required this.brand,
      required this.categoryName,
      required this.unitMeasurement,
      required this.costValue,
      required this.saleValue,
      required this.minQuantity,
      this.description = ''});
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String cod;
  @HiveField(2)
  final String productProviderDocument;
  @HiveField(3)
  final double costValue;
  @HiveField(4)
  final double saleValue;
  @HiveField(5)
  final String brand;
  @HiveField(6)
  final String categoryName;
  @HiveField(7)
  final String unitMeasurement;
  @HiveField(8)
  final int minQuantity;
  @HiveField(9)
  final String description;
}
