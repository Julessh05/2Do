library models;

import 'package:todo/models/todo.dart';

class TodoList {
  /// The List of Todos used in the App
  static final List<Todo> _listOfTodos = [];

  /// The List where checked Todos are stored
  static final List<Todo> _listOfCheckedTodos = [];

  /// This List combines the [listOfCheckedTodos] and the [listOfTodos]
  static List<Todo> _combinedListOfTodos = [];

  static List<Todo> get listOfTodos => _listOfTodos;

  static List<Todo> get listOfCheckedTodos => _listOfCheckedTodos;

  static List<Todo> get combinedListOfTodos => _combinedListOfTodos;

  static void addTodo(Todo todo) {
    _listOfTodos.add(todo);
    _updateCobinedList();
  }

  static void deleteTodo(Todo todo) {
    _listOfTodos.remove(todo);
    _listOfCheckedTodos.remove(todo);
    _updateCobinedList();
  }

  static void checkTodo(Todo todo) {
    _listOfTodos.remove(todo);
    _listOfCheckedTodos.add(todo);
    _updateCobinedList();
  }

  static void uncheckTodo(Todo todo) {
    _listOfCheckedTodos.remove(todo);
    listOfTodos.add(todo);
    _updateCobinedList();
  }

  static void _updateCobinedList() {
    _combinedListOfTodos = _listOfTodos + _listOfCheckedTodos;
  }
}
