import 'package:easy_manager/core/database_helper.dart';
import 'package:easy_manager/models/product_provider_model.dart';

class Product {
  Product({
    required this.name,
    required this.cod,
    required this.productProvider,
    required this.costValue,
    required this.saleValue,
    required this.brand,
    required this.categoryName,
    required this.unitMeasurement,
  });
  final String name;
  final String cod;
  final ProductProvider? productProvider;
  final double costValue;
  final double saleValue;
  final String brand;
  final String categoryName;
  final String unitMeasurement;

  void save() async {
    await ConectDb();
  }
}
