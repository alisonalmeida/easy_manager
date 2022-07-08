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
      phoneNumber1: fields[2] as String,
      phoneNumber2: fields[3] as String,
      address: fields[4] as Address,
      email: fields[5] as String,
      observations: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ProductProvider obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.document)
      ..writeByte(2)
      ..write(obj.phoneNumber1)
      ..writeByte(3)
      ..write(obj.phoneNumber2)
      ..writeByte(4)
      ..write(obj.address)
      ..writeByte(5)
      ..write(obj.email)
      ..writeByte(6)
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
