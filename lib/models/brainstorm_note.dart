library models;

import 'package:hive/hive.dart'
    show
        HiveField,
        HiveType,
        HiveObject,
        TypeAdapter,
        BinaryReader,
        BinaryWriter;

part 'brainstorm_note.g.dart';

@HiveType(typeId: 2)
class BrainstormNote extends HiveObject {
  @HiveField(0)
  String? title;

  @HiveField(1)
  String note;

  @HiveField(2)
  bool checked;

  @HiveField(3)
  bool selected;

  BrainstormNote({
    this.title,
    required this.note,
    this.checked = false,
    this.selected = false,
  });
}
