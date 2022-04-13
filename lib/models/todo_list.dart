library models;

import 'dart:collection' show UnmodifiableListView;

import 'package:todo/models/todo.dart' show Todo;
import 'package:todo/storage/storage.dart';

/// Object which holds all 3 different Todo-Lists
/// The List which are returned trough the getters
/// [listOfTodos], [listOfCheckedTodos] and [combinedListOfTodos]
/// are unmodifiable and so you can't add or remove values from it
///
/// For that you should use the Methods [addTodo] and [deleteTodo]
/// which do it for you and also update the [combinedListOfTodos]
///
/// Also there are 2 Methods with which you can either can check or
/// uncheck a Todo.
/// This Methods also update the [combinedListOfTodos]
class TodoList {
  /// The private file intern List of Todos used in the App
  static List<Todo> _listOfTodos = [];

  /// The Key for the [listOfTodos]
  static const listOfTodosKEY = 'List Of Todos';

  /// The private file intern List where checked Todos are stored
  static List<Todo> _listOfCheckedTodos = [];

  /// The Key for the [listOfCheckedTodos]
  static const listOfCheckedTodosKEY = 'List Of Checked Todos';

  /// This private file intern List combines the [listOfCheckedTodos] and the [listOfTodos]
  static List<Todo> _combinedListOfTodos = [];

  static List<String> _tags = ['All_Todos'];

  static UnmodifiableListView get tags => UnmodifiableListView(_tags);

  /// The List where all unchecked Todos are stored
  /// This List is unmodifiable
  static UnmodifiableListView<Todo> get listOfTodos =>
      UnmodifiableListView(_listOfTodos);

  /// Setter for the [_listOfTodos]
  static set listOfTodos(List<Todo> list) => _listOfTodos = list;

  /// The List where all checked Todos are stored
  /// This List is unmodifiable
  static UnmodifiableListView<Todo> get listOfCheckedTodos =>
      UnmodifiableListView(_listOfCheckedTodos);

  /// Setter for the [_listOfCheckedTodos]
  static set listOfCheckedTodos(List<Todo> list) => _listOfCheckedTodos = list;

  /// The List where all Todos are stored
  /// This List is unmodifiable
  static UnmodifiableListView<Todo> get combinedListOfTodos =>
      UnmodifiableListView(_combinedListOfTodos);

  /// Adds a Todo to the [listOfTodos]
  /// This is used when a new Todo is created, because the Todo is unchecked
  static void addTodo(Todo todo) {
    _listOfTodos.add(todo);
    _updateCombinedList();
    Storage.storeTodos();
  }

  /// Adds a Checked Todo to the [listOfCheckedTodos]
  /// This is used when loading a Todo from the File, which is already checked
  static void addCheckedTodo(Todo todo) {
    _listOfCheckedTodos.add(todo);
    _updateCombinedList();
    Storage.storeTodos();
  }

  /// Deletes a Todo
  /// Removes the [todo] from [listOfTodos] and [listOfCheckedTodos]
  static void deleteTodo(Todo todo) {
    _listOfTodos.remove(todo);
    _listOfCheckedTodos.remove(todo);
    _updateCombinedList();
    Storage.storeTodos();
  }

  /// Removes the [todo] from the [listOfTodos] and adds it to the
  /// [listOfCheckedTodos] so it can be handled as a checked Todo
  static void checkTodo(Todo todo) {
    _listOfTodos.remove(todo);
    _listOfCheckedTodos.add(todo);
    _updateCombinedList();
    Storage.storeTodos();
  }

  /// Removes the [todo] from the [listOfCheckedTodos] and add it
  /// to the [listOfTodos] so it can be handled as a unchecked Todo
  static void uncheckTodo(Todo todo) {
    _listOfCheckedTodos.remove(todo);
    _listOfTodos.add(todo);
    _updateCombinedList();
    Storage.storeTodos();
  }

  /// Updates the [_combinedListOfTodos] so this List is always up-to-date
  static void _updateCombinedList() {
    _combinedListOfTodos = _listOfTodos + _listOfCheckedTodos;
  }

  static bool get todoMarked {
    for (Todo todo in _combinedListOfTodos) {
      if (todo.selected) {
        return true;
      } else {
        continue;
      }
    }
    return false;
  }

  static void addTag(String tag) {
    _tags.add(', $tag');
  }

  static void deleteTag(String tag) {
    _tags.remove(', $tag');
  }
}
