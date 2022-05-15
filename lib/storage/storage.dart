library storage;

import 'package:flutter/material.dart' show BuildContext;
import 'package:hive_flutter/hive_flutter.dart' show Box, Hive;
import 'package:todo/logic/converter.dart' show Converter;
import 'package:todo/models/brainstorm_list.dart';
import 'package:todo/models/brainstorm_note.dart';
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
  static const todoBoxKEY = 'Todo Box';

  /// The Box where all Settings are stored
  /// These Settings are stored as [listOfSettings]
  static Box<Setting>? _settingsBox;

  /// The Key / Name for the [_settingsBox]
  static const settingsBoxKEY = 'Settings Box';

  static Box<BrainstormNote>? _brainstormBox;

  static const brainstormBoxKEY = 'Brainstorm Box';

  /// Init Method which initializes everything and is responsible
  /// for registering the Adapters
  /// Also the Boxes are opened here
  static Future<void> init() async {
    Hive.registerAdapter(SettingAdapter());
    Hive.registerAdapter(TodoAdapter());
    Hive.registerAdapter(BrainstormNoteAdapter());
    _todoBox = await Hive.openBox<Todo>(todoBoxKEY);
    _settingsBox = await Hive.openBox<Setting>(settingsBoxKEY);
    _brainstormBox = await Hive.openBox<BrainstormNote>(brainstormBoxKEY);
    // Check if Box has the list Of Settings
    if (_settingsBox!.containsKey(AllSettings.languageSetting.hiveKey)) {
      // Do nothing
    } else {
      storeSettings();
    }

    _settingsBox = await Hive.openBox('Settings Box');

    if (_todoBox!.isNotEmpty) {
      // Do nothing
    } else {
      storeTodos();
    }

    if (_brainstormBox!.isNotEmpty) {
      // Do nothing
    } else {
      storeBrainstormNotes();
    }
  }

  /// Stores the Todos to the File System.
  /// Stored as one String in the matching File
  static void storeTodos() {
    _todoBox!.deleteAll(_todoBox!.keys);
    for (int i = 0; i < TodoList.listOfTodos.length; i++) {
      final key = 'Unchecked $i';
      _todoBox!.put(key, TodoList.listOfTodos[i]);
    }

    for (int i = 0; i < TodoList.listOfCheckedTodos.length; i++) {
      final key = 'Checked $i';
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
      for (String tag in todo.tagsAsList) {
        if (TodoList.tags.contains(tag)) {
          continue;
        } else {
          TodoList.addTag(tag);
        }
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
    final List<Setting> list = [];
    for (Setting setting in listOfSettings) {
      final Setting localSetting;
      if (setting.objectValue != null) {
        localSetting = Setting(
          name: setting.name,
          stringValue: Converter.supportedObjectToDisplayableString(
            setting.objectValue,
            false,
          ),
          isObject: true,
          isObjectType: setting.isObjectType,
        );
      } else {
        localSetting = setting;
      }
      list.add(localSetting);
    }
    for (Setting setting in list) {
      _settingsBox!.put(setting.hiveKey, setting);
    }
  }

  /// Loads the Settings and sets it to the [listOfSettings]
  /// Only loads the Values
  static void loadSettings(BuildContext context) {
    final listOfSettingsStorage = _settingsBox!.values;
    final List<Setting> list = [];
    for (Setting setting in listOfSettingsStorage) {
      if (setting.isObject != null) {
        if (setting.isObject == true) {
          final dynamic objectValue = Converter.stringToSupportedObject(
            setting.stringValue!,
            setting.isObjectType!,
          );
          final localSetting = Setting(
            name: setting.name,
            objectValue: objectValue,
            isObject: setting.isObject,
            isObjectType: setting.isObjectType,
          );
          list.add(localSetting);
        } else {
          // Do nothing
        }
      } else {
        list.add(setting);
        continue;
      }
    }
    listOfSettings = list;
    AllSettings.setAllSettings(context);
  }

  /// Stores all the Brainstorm Notes
  static void storeBrainstormNotes() {
    _brainstormBox!.deleteAll(_brainstormBox!.keys);
    for (int i = 0; i < BrainstormList.listOfNotes.length; i++) {
      final key = 'Unchecked $i';
      _brainstormBox!.put(key, BrainstormList.listOfNotes[i]);
    }

    for (int i = 0; i < BrainstormList.listOfCheckedNotes.length; i++) {
      final key = 'Checked $i';
      _brainstormBox!.put(key, BrainstormList.listOfCheckedNotes[i]);
    }
  }

  /// Loads the Brainstorm Notes
  static void loadBrainstormNotes() {
    final listOfAllNotesStorage = _brainstormBox!.values;
    for (BrainstormNote note in listOfAllNotesStorage) {
      if (note.checked) {
        BrainstormList.addCheckedNote(note);
      } else {
        BrainstormList.addNote(note);
      }
    }
  }

  /// Deletes the Box with the Settings from the File System
  static void deleteSettings() {
    _settingsBox!.deleteFromDisk();
  }
}
