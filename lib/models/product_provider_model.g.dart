// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_provider_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductProviderAdapter extends TypeAdapter<ProductProvider> {
  @override
  final int typeId = 3;

  @override
  ProductProvider read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductProvider(
      name: fields[0] as String,
      document: fields[1] as String,
      phoneList: (fields[2] as List).cast<String>(),
      address: fields[3] as Address,
      email: (fields[4] as List).cast<String>(),
      observations: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ProductProvider obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.document)
      ..writeByte(2)
      ..write(obj.phoneList)
      ..writeByte(3)
      ..write(obj.address)
      ..writeByte(4)
      ..write(obj.email)
      ..writeByte(5)
      ..write(obj.observations);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductProviderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
