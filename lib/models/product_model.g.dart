// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductAdapter extends TypeAdapter<Product> {
  @override
  final int typeId = 2;

  @override
  Product read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Product(
      cod: fields[1] as String,
      name: fields[0] as String,
      productProvider: fields[2] as ProductProvider,
      brand: fields[5] as String,
      categoryName: fields[6] as String,
      unitMeasurement: fields[7] as String,
      costValue: fields[3] as double,
      saleValue: fields[4] as double,
      minQuantity: fields[8] as int,
      description: fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Product obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.cod)
      ..writeByte(2)
      ..write(obj.productProvider)
      ..writeByte(3)
      ..write(obj.costValue)
      ..writeByte(4)
      ..write(obj.saleValue)
      ..writeByte(5)
      ..write(obj.brand)
      ..writeByte(6)
      ..write(obj.categoryName)
      ..writeByte(7)
      ..write(obj.unitMeasurement)
      ..writeByte(8)
      ..write(obj.minQuantity)
      ..writeByte(9)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
