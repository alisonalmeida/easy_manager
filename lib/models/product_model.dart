//flutter pub run build_runner build --delete-conflicting-outputs

import 'package:easy_manager/objectbox.g.dart';

import 'db_model.dart';

@Entity()
@Sync()
class Product {
  int id;
  final String name;
  final String cod;
  final String productProviderDocument;
  final double costValue;
  final double saleValue;
  final String brand;
  final String categoryName;
  final String unitMeasurement;
  final int minQuantity;
  final String description;

  final dbModel = ToOne<DbModelBox>();

  Product(
      {this.id = 0,
      required this.cod,
      required this.name,
      required this.productProviderDocument,
      required this.brand,
      required this.categoryName,
      required this.unitMeasurement,
      required this.costValue,
      required this.saleValue,
      required this.minQuantity,
      required this.description});
}
