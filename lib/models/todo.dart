library models;

import 'package:todo/logic/converter.dart';
import 'package:todo/models/identifiable_model.dart';

/// Object which represents a single Todo used in the App
/// [selected] and [checked] are usually not given while creating a Todo
/// These Values are used by the Widget in the Homescreen to show the Todo
/// properally
class Todo implements IdentifiableModel {
  final String title;
  final String content;
  late final DateTime time;
  final List<String> tags;
  bool selected;
  bool checked;
  late final DateTime created;

  Todo({
    required this.title,
    required this.content,
    required this.time,
    this.tags = const ["Standard"],
    this.checked = false,
    this.selected = false,
    required this.created,
  })  : assert(
          selected == false,
          "A Todo can't be selected while being created",
        ),
        assert(
          checked == false,
          "A Todo can't be checked while being created",
        );

  Todo.empty({
    this.title = "",
    this.content = "",
    this.checked = false,
    this.selected = false,
    this.tags = const ["Standard"],
  }) {
    time = DateTime.now();
    created = DateTime.now();
  }

  /// Returns the Todo as a Map of String : String
  Map<String, String> get asMap {
    final _map = <String, String>{
      "Title": title,
      "Content": content,
      "Time": timeAsString,
      "Selected": selected.toString(),
      "Checked": checked.toString(),
      "Tags": "Following are tags",
    };

    for (int i = 1; i <= tags.length; i++) {
      _map.addAll({i.toString(): tags[i]});
    }

    return _map;
  }

  @override
  String toString() {
    String _result = "";

    // Add Title
    _result += "Title:";
    _result += title;

    // Add Content
    _result += "Content:";
    _result += content;

    // Add Time
    _result += "DateTime:";
    _result += timeAsString;

    // Add Checked
    _result += "Checked";
    _result += checked.toString();

    // Add created Time
    _result += "Created on:";
    _result += createdAsString;

    // Add Tags
    for (int i = 0; i <= tags.length; i++) {
      _result += "tag ${i.toString()}:";
      _result += tags[i];
    }

    return _result;
  }

  /// Returns the [time] as a String to use in Widgets,
  /// or to store the Value
  String get timeAsString => Converter.dateToString(time);

  /// Returns only the time from the [time]
  String get onlyTime => Converter.onlyTime(time);

  /// Returns only the date of the [time]
  String get onlyDate => Converter.onlyDate(time);

  /// Returns the DateTime as String. The DateTime returned is the
  /// Date of creation of this Todo
  String get createdAsString => Converter.dateToString(created);

  @override

  /// Returns the Identifier of this Todo Object
  /// This is used to mark a new Todo in the Storage
  String get identifier => "Todo:";

  @override
  // TODO: implement regExp
  Pattern get regExp => throw UnimplementedError();
}
