// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_evaluation.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DailyEvaluationAdapter extends TypeAdapter<DailyEvaluation> {
  @override
  final int typeId = 0;

  @override
  DailyEvaluation read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DailyEvaluation(
      date: fields[0] as DateTime,
      spiritualScore: fields[1] as int,
      physicalScore: fields[2] as int,
      mentalScore: fields[3] as int,
      notes: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DailyEvaluation obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.spiritualScore)
      ..writeByte(2)
      ..write(obj.physicalScore)
      ..writeByte(3)
      ..write(obj.mentalScore)
      ..writeByte(4)
      ..write(obj.notes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DailyEvaluationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
