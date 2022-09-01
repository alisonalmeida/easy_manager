
class Product {
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

  Product(
      {
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
