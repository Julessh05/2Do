library models;

import 'dart:collection';

import 'package:todo/models/todo.dart';

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
  /// The private fileintern List of Todos used in the App
  static final List<Todo> _listOfTodos = [];

  /// The private fileintern List where checked Todos are stored
  static final List<Todo> _listOfCheckedTodos = [];

  /// This private fileintern List combines the [listOfCheckedTodos] and the [listOfTodos]
  static List<Todo> _combinedListOfTodos = [];

  /// The List where all unchecked Todos are stored
  /// This List is unmodifiable
  static UnmodifiableListView<Todo> get listOfTodos =>
      UnmodifiableListView(_listOfTodos);

  /// The List where all checked Todos are stored
  /// This List is unmodifiable
  static UnmodifiableListView<Todo> get listOfCheckedTodos =>
      UnmodifiableListView(_listOfCheckedTodos);

  /// The List where all Todos are stored
  /// This List is unmodifiable
  static UnmodifiableListView<Todo> get combinedListOfTodos =>
      UnmodifiableListView(_combinedListOfTodos);

  /// Adds a Todo to the [listOfTodos]
  /// This is used when a new Todo is created, because the Todo is unchecked
  static void addTodo(Todo todo) {
    _listOfTodos.add(todo);
    _updateCobinedList();
  }

  /// Deletes a Todo
  /// Removes the [todo] from [listOfTodos] and [listOfCheckedTodos]
  static void deleteTodo(Todo todo) {
    _listOfTodos.remove(todo);
    _listOfCheckedTodos.remove(todo);
    _updateCobinedList();
  }

  /// Removes the [todo] from the [listOfTodos] and adds it to the
  /// [listOfCheckedTodos] so it can be handled as a checked Todo
  static void checkTodo(Todo todo) {
    _listOfTodos.remove(todo);
    _listOfCheckedTodos.add(todo);
    _updateCobinedList();
  }

  /// Removes the [todo] from the [listOfCheckedTodos] and add it
  /// to the [listOfTodos] so it can be handled as a unchecked Todo
  static void uncheckTodo(Todo todo) {
    _listOfCheckedTodos.remove(todo);
    _listOfTodos.add(todo);
    _updateCobinedList();
  }

  /// Updates the [_combinedListOfTodos] so this List is always up-to-date
  static void _updateCobinedList() {
    _combinedListOfTodos = _listOfTodos + _listOfCheckedTodos;
  }
}
