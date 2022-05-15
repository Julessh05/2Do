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
  /// The Tag to tell the Program, the user wants all Tags
  static const allTodosTag = '#<All>#';

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

  /// The private List of Tags that are created and used in this App
  static final List<String> _tags = [];

  /// Getter for the Tag List. It's an unmodifiable List
  static UnmodifiableListView<String> get tags => UnmodifiableListView(_tags);

  /// The List where all unchecked Todos are stored
  /// This List is unmodifiable List, so you can only add Tags through the
  /// corresponding Method.
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
  }

  /// Adds a Checked Todo to the [listOfCheckedTodos]
  /// This is used when loading a Todo from the File, which is already checked
  static void addCheckedTodo(Todo todo) {
    _listOfCheckedTodos.add(todo);
    _updateCombinedList();
  }

  /// Deletes a Todo
  /// Removes the [todo] from [listOfTodos] and [listOfCheckedTodos]
  static void deleteTodo(Todo todo) {
    _listOfTodos.remove(todo);
    _listOfCheckedTodos.remove(todo);
    _updateCombinedList();
  }

  /// Removes the [todo] from the [listOfTodos] and adds it to the
  /// [listOfCheckedTodos] so it can be handled as a checked Todo
  static void checkTodo(Todo todo) {
    _listOfTodos.remove(todo);
    _listOfCheckedTodos.add(todo);
    _updateCombinedList();
  }

  /// Removes the [todo] from the [listOfCheckedTodos] and add it
  /// to the [listOfTodos] so it can be handled as a unchecked Todo
  static void uncheckTodo(Todo todo) {
    _listOfCheckedTodos.remove(todo);
    _listOfTodos.add(todo);
    _updateCombinedList();
  }

  /// Updates the [_combinedListOfTodos] so this List is always up-to-date
  /// The Todos are also stored, so the Box with the Todos is always updated too,
  static void _updateCombinedList() {
    _combinedListOfTodos = _listOfTodos + _listOfCheckedTodos;
    Storage.storeTodos();
  }

  /// Returns if any Todo in any List is marked
  static bool get todoMarked {
    // Iterate over the combined List of Todos
    for (Todo todo in _combinedListOfTodos) {
      if (todo.selected) {
        // Todo is selected
        return true;
      } else {
        // Todo isn't selected, therefore continue to search
        continue;
      }
    }
    // Return false, if no Todo is marked
    return false;
  }

  /// Adds a Tag to the Tags List
  static void addTag(String tag) {
    if (tag.isEmpty) {
      // Do nothing
    } else if (_tags.contains(tag)) {
      // Also do nothing
    } else {
      _tags.add(tag);
      Storage.storeTodos();
    }
  }

  /// Delete a Tag from the Tags List
  static void deleteTag(String tag) {
    _tags.remove(tag);
    Storage.storeTodos();
  }

  /// Checks all the Todos and if a
  /// specific Tag isn't used, deletes it.
  static void checkTags() {
    final List<String> tagsToDelete = [];
    for (String tag in _tags) {
      if (tagIsUsed(tag)) {
        continue;
      } else {
        tagsToDelete.add(tag);
      }
    }
    for (String tag in tagsToDelete) {
      deleteTag(tag);
    }
  }

  /// Returns if a specific [tag] is used.
  static bool tagIsUsed(String tag) {
    for (Todo todo in _combinedListOfTodos) {
      if (todo.tagsAsList.contains(tag)) {
        return true;
      } else {
        continue;
      }
    }
    return false;
  }

  static List<Todo> allTodosWithSpecificTag(String? tag) {
    if (tag == null) {
      return combinedListOfTodos;
    }
    final List<Todo> list = [];
    for (Todo todo in _combinedListOfTodos) {
      if (todo.tagsAsList.contains(tag)) {
        list.add(todo);
      } else {
        continue;
      }
    }
    return list;
  }
}
