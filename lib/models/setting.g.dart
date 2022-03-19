// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SettingAdapter extends TypeAdapter<Setting> {
  @override
  final int typeId = 0;

  @override
  Setting read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Setting(
      name: fields[0] as String,
      boolValue: fields[1] as bool?,
      intValue: fields[2] as int?,
      stringValue: fields[3] as String?,
      objectValue: fields[4] as dynamic,
    )
      ..valueType = fields[5] as String
      ..hiveKey = fields[6] as String;
  }

  @override
  void write(BinaryWriter writer, Setting obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.boolValue)
      ..writeByte(2)
      ..write(obj.intValue)
      ..writeByte(3)
      ..write(obj.stringValue)
      ..writeByte(4)
      ..write(obj.objectValue)
      ..writeByte(5)
      ..write(obj.valueType)
      ..writeByte(6)
      ..write(obj.hiveKey);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
