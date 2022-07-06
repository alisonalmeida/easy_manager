// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ClientAdapter extends TypeAdapter<Client> {
  @override
  final int typeId = 1;

  @override
  Client read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Client(
      name: fields[0] as String,
      cpf: fields[1] as String,
      address: fields[2] as Address,
      phoneList: (fields[3] as List).cast<String>(),
      email: fields[4] as String,
      observations: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Client obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.cpf)
      ..writeByte(2)
      ..write(obj.address)
      ..writeByte(3)
      ..write(obj.phoneList)
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
      other is ClientAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
