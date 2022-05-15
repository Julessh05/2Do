// GENERATED CODE - DO NOT MODIFY BY HAND

part of models;

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BrainstormNoteAdapter extends TypeAdapter<BrainstormNote> {
  @override
  final int typeId = 2;

  @override
  BrainstormNote read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BrainstormNote(
      title: fields[0] as String?,
      note: fields[1] as String,
      checked: fields[2] as bool,
      selected: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, BrainstormNote obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.note)
      ..writeByte(2)
      ..write(obj.checked)
      ..writeByte(3)
      ..write(obj.selected);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BrainstormNoteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
