library storage;

import 'package:hive_flutter/hive_flutter.dart' show Box, Hive;
import 'package:todo/logic/converter.dart';
import 'package:todo/models/setting.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/models/todo_list.dart';

/// Class that contains everything in interaction with the
/// File System
class Storage {
  /// The Box where all Todos are stored
  /// In this Box there are Stored list of Todos
  /// 1. List Of Todos
  /// 2. List Of Checked Todos
  static Box<Todo>? _todoBox;

  /// The Key / Name for the [_todoBox]
  static const todoBoxKEY = "Todo Box";

  /// The Box where all Settings are stored
  /// These Settings are stored as [listOfSettings]
  static Box<Setting>? _settingsBox;

  /// The Key / Name for the [_settingsBox]
  static const settingsBoxKey = "Settings Box";

  /// Init Method which initializes everything and is responsible
  /// for registering the Adapters
  /// Also the Boxes are opened here
  static Future<void> init() async {
    Hive.registerAdapter(SettingAdapter());
    Hive.registerAdapter(TodoAdapter());
    _todoBox = await Hive.openBox<Todo>(todoBoxKEY);
    _settingsBox = await Hive.openBox<Setting>(settingsBoxKey);
    // Check if Box has the list Of Settings
    if (_settingsBox!.containsKey(AllSettings.languageSetting.hiveKey)) {
      // Do nothing
    } else {
      storeSettings();
    }

    _settingsBox = await Hive.openBox("Settings Box");

    if (_todoBox!.isNotEmpty) {
      // Do nothing
    } else {
      storeTodos();
    }
  }

  /// Stores the Todos to the File System.
  /// Stored as one String in the matching File
  static void storeTodos() {
    _todoBox!.deleteAll(_todoBox!.keys);
    for (int i = 0; i < TodoList.listOfTodos.length; i++) {
      final key = "Unchecked $i";
      _todoBox!.put(key, TodoList.listOfTodos[i]);
    }

    for (int i = 0; i < TodoList.listOfCheckedTodos.length; i++) {
      final key = "Checked $i";
      _todoBox!.put(key, TodoList.listOfCheckedTodos[i]);
    }
  }

  /// Loads the Todos and sets it to the [TodoList.listOfTodos]
  /// Parsing the one String to all of the Todos
  static void loadTodos() {
    final listOfAllTodosStorage = _todoBox!.values;
    for (Todo todo in listOfAllTodosStorage) {
      if (todo.checked) {
        TodoList.addCheckedTodo(todo);
      } else {
        TodoList.addTodo(todo);
      }
    }
  }

  /// Deletes the Box with Todos from the File System
  static void deleteTodos() {
    _todoBox!.deleteFromDisk();
  }

  /// Stores the Settings to the File System.
  /// Stored as one String in the matching File.
  static void storeSettings() {
    final List<Setting> _list = [];
    for (Setting setting in listOfSettings) {
      final Setting _setting;
      if (setting.objectValue != null) {
        _setting = Setting(
          name: setting.name,
          stringValue: Converter.supportedObjectToDisplayableString(
            setting.objectValue,
            false,
          ),
          isObject: true,
          isObjectType: setting.isObjectType,
        );
      } else {
        _setting = setting;
      }
      _list.add(_setting);
    }
    for (Setting setting in _list) {
      _settingsBox!.put(setting.hiveKey, setting);
    }
  }

  /// Loads the Settings and sets it to the [listOfSettings]
  /// Only loads the Values
  static void loadSettings() {
    final listOfSettingsStorage = _settingsBox!.values;
    final List<Setting> _list = [];
    for (Setting setting in listOfSettingsStorage) {
      if (setting.isObject != null) {
        if (setting.isObject == true) {
          final dynamic objectValue = Converter.stringToSupportedObject(
            setting.stringValue!,
            setting.isObjectType!,
          );
          final _setting = Setting(
            name: setting.name,
            objectValue: objectValue,
            isObject: setting.isObject,
            isObjectType: setting.isObjectType,
          );
          _list.add(_setting);
        } else {
          // Do nothing
        }
      } else {
        _list.add(setting);
        continue;
      }
    }
    listOfSettings = _list;
    AllSettings.setAllSettings();
  }

  /// Deletes the Box with the Settings from the File System
  static void deleteSettings() {
    _settingsBox!.deleteFromDisk();
  }
}
