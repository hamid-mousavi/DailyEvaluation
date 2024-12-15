// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'criterion.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CriterionAdapter extends TypeAdapter<Criterion> {
  @override
  final int typeId = 1;

  @override
  Criterion read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Criterion(
      name: fields[0] as String,
      category: fields[1] as String,
      weight: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Criterion obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.category)
      ..writeByte(2)
      ..write(obj.weight);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CriterionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
