library storage;

import 'dart:io';

import 'package:todo/models/setting.dart';
import 'package:todo/models/todo.dart';

/// The List of Todos used in the App
final List<Todo> listOfTodos = [];

/// Class that contains everything in interaction with the
/// File System
class Storage {
  /// The File where the Todos are stored
  static final File _todoFile = File("${Directory.systemTemp}/Todos.txt");

  /// The File where all Settings are stored
  static final File _settingsFile =
      File("${Directory.systemTemp}/Settings.txt");

  /// Stores the Todos to the File System
  static void storeTodos() {}

  /// Loads the Todos and sets it to the [listOfTodos]
  static void loadTodos() {}

  /// Deletes the [_todoFile] and all content
  static void deleteTodos() {
    _todoFile.deleteSync();
  }

  /// Stores the Settings to the File System
  static void storeSettings() {}

  /// Loads the Settings and sets it to the [listOfSettings]
  /// Only loads the Values
  static void loadSettings() {}

  /// Deletes the [_settingsFile] and all content
  static void deleteSettings() {
    _settingsFile.deleteSync();
  }
}
