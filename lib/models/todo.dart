library models;

import 'package:hive/hive.dart'
    show
        HiveField,
        HiveType,
        HiveObject,
        TypeAdapter,
        BinaryReader,
        BinaryWriter;

part 'todo.g.dart';

/// Object which represents a single Todo used in the App
/// [selected] and [checked] are usually not given while creating a Todo
/// These Values are used by the Widget in the Homescreen to show the Todo
/// properly
@HiveType(typeId: 1)
class Todo extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String content;

  // @HiveField(2)
  // late final DateTime time;

  @HiveField(3)
  final String tags;

  @HiveField(4)
  bool selected;

  @HiveField(5)
  bool checked;

  // @HiveField(6)
  // late final DateTime created;

  // @HiveField(7)
  // late final int? importance;

  Todo({
    required this.title,
    required this.content,
    // required this.time,
    this.tags = 'All_Todos',
    this.checked = false,
    this.selected = false,
    // required this.created,
    // this.importance,
  }) : assert(
          selected == false,
          'A Todo can\'t be selected while being created',
        ) {
    // importance ?? Notifications.importance;
  }

  /// Created an empty Todo.
  Todo.empty(
      {this.title = '',
      this.content = '',
      this.checked = false,
      this.selected = false,
      this.tags = 'Empty'
      // this.importance = 0,
      }) {
    // time = DateTime.now();
    // created = DateTime.now();
  }

  /// Returns the Todo as a Map of String : String
  Map<String, String> get asMap {
    final _map = <String, String>{
      'Title': title,
      'Content': content,
      // 'Time': timeAsString,
      'Selected': selected.toString(),
      'Checked': checked.toString(),
      // 'Importance': importance.toString(),
      // 'Tags': 'Following are tags',
    };

    /* for (int i = 1; i <= tags.length; i++) {
      _map.addAll({i.toString(): tags[i]});
    } */

    return _map;
  }

  @override
  String toString() {
    String _result = '';

    // Add Title
    _result += 'Title:';
    _result += title;

    // Add Content
    _result += 'Content:';
    _result += content;

    // Add Time
    /*  _result += 'DateTime:';
    _result += timeAsString; */

    // Add Checked
    _result += 'Checked';
    _result += checked.toString();

    // Add created Time
    /* _result += 'Created on:';
    _result += createdAsString; */

    // Add Importance
    /*  _result += 'Importance';
    _result += importance.toString();

    // Add Tags
    for (int i = 0; i <= tags.length; i++) {
      _result += 'tag ${i.toString()}:';
      _result += tags[i];
    } */

    return _result;
  }

  /// Returns the [time] as a String to use in Widgets,
  /// or to store the Value
// String get timeAsString => Converter.dateToString(time);

  /// Returns only the time from the [time]
// String get onlyTime => Converter.onlyTime(time);

  /// Returns only the date of the [time]
// String get onlyDate => Converter.onlyDate(time);

  /// Returns the DateTime as String. The DateTime returned is the
  /// Date of creation of this Todo
// String get createdAsString => Converter.dateToString(created);
}
