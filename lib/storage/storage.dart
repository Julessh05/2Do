library storage;

import 'dart:io';

import 'package:todo/logic/converter.dart';
import 'package:todo/models/setting.dart';
import 'package:todo/models/todo.dart';

/// Class that contains everything in interaction with the
/// File System
class Storage {
  /// The File where the Todos are stored
  /// Stored in Temp Directory because other Dirs are not avaible
  /// without Problems directly in Dart
  static final File _todoFile = File("${Directory.systemTemp}/Todos.txt");

  /// The File where all Settings are stored
  /// Stored in Temp Directory because other Dirs are not avaible
  /// without Problems directly in Dart
  static final File _settingsFile =
      File("${Directory.systemTemp}/Settings.txt");

  /// Stores the Todos to the File System.
  /// Stored as one String in the matching File
  static void storeTodos() {
    String _data = "";
    // Parsing Todo to String and adding it to _data
    for (Todo todo in listOfTodos) {
      _data += todo.identifier;
      _data += todo.toString();
    }
    // Write File
    _todoFile.writeAsStringSync(_data);
  }

  /// Loads the Todos and sets it to the [listOfTodos]
  /// Parsing the one String to all of the Todos
  static void loadTodos() {
    // Read Data
    final String _data = _todoFile.readAsStringSync();
    // Create empty Todo to get Identifier
    final _emptyTodo = Todo.empty();
    // Split Data to get different Todos
    final List<String> _splittedData = _data.split(_emptyTodo.identifier);
    // Create TodoAsString for every splitted String
    for (String todoAsString in _splittedData) {
      // split Data using Todo.regExp
      final _splittedTodo = todoAsString.split(_emptyTodo.regExp);
      // Getting Tags
      List<String> tags = [];
      for (int i = 6; i < _splittedTodo.length; i++) {
        tags.add(_splittedTodo[i]);
      }
      // create Todo
      final _todo = Todo(
        title: _splittedTodo[0],
        content: _splittedTodo[1],
        // time: Converter.stringToDateTime(_splittedTodo[3]),
        checked: _splittedTodo[4].parseBool(),
        // created: Converter.stringToDateTime(_splittedTodo[5]),
        // tags: tags,
        selected: false,
      );
      listOfTodos.add(_todo);
    }
  }

  /// Deletes the [_todoFile] and all content
  static void deleteTodos() {
    _todoFile.deleteSync();
  }

  /// Stores the Settings to the File System.
  /// Stored as one String in the matching File.
  static void storeSettings() {
    String _data = "";
    // Parsing Setting to String and adding it to _data
    for (Setting setting in listOfSettings) {
      _data += setting.identifier;
      _data += setting.toString();
    }
    _settingsFile.writeAsStringSync(_data);
  }

  /// Loads the Settings and sets it to the [listOfSettings]
  /// Only loads the Values
  static void loadSettings() {
    // Read Data
    final String _data = _settingsFile.readAsStringSync();
    // Create empty Setting to get Identifier,
    final _emptySetting = Setting.empty();
    // Split Data to get different Settings
    final List<String> _splittedData = _data.split(_emptySetting.identifier);
    // Create SettingAsString for every splitted String
    for (int i = 0; i < _splittedData.length; i++) {
      // split Data using Setting.regExp
      final _splittedString = _splittedData[i];
      // set value of the setting dependend on what Value Type they have
      switch (_splittedString[1]) {
        case "int":
          listOfSettings[i].intValue = int.parse(_splittedString[2]);
          break;
        case "bool":
          listOfSettings[i].boolValue = _splittedString[2].parseBool();
          break;
        case "String":
          listOfSettings[i].stringValue = _splittedString[2];
          break;
        case "Object":
          listOfSettings[i].objectValue = Converter.stringToSupportedObject(
            _splittedString[2],
            _splittedString[1],
          );
          break;
      }
    }
  }

  /// Deletes the [_settingsFile] and all content
  static void deleteSettings() {
    _settingsFile.deleteSync();
  }
}
