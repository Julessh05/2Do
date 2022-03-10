library logic;

import 'package:flutter/material.dart';
import 'package:todo/models/search_results.dart';
import 'package:todo/models/setting.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/screens/add_todo_screen.dart';
import 'package:todo/screens/components/settings_sub_tile.dart';
import 'package:todo/screens/homescreen.dart';
import 'package:todo/screens/search_screen.dart';
import 'package:todo/screens/settings_screens.dart';
import 'package:todo/screens/todo_detail_screen.dart';

/// This class contains all Jumps and Navigating
/// Actions done in the App
class Jumper {
  /// Navigate back to the Homescreen and Renove every
  /// other Screen on the Stack
  static void backToTheHomescreen(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      Homescreen.routeName,
      (route) => false,
    );
  }

  /// Pushed the [SettingsMainScreen] on Top of the current Route
  static void openSettings(BuildContext context) {
    Navigator.pushNamed(context, SettingsMainScreen.routeName);
  }

  /// Pushes the [AddTodoScreen] on Top of the current Route
  static void openAddTodo(BuildContext context) {
    Navigator.pushNamed(context, AddTodoScreen.routeName);
  }

  /// Pushes the [SearchScreen] on Top of the current Route
  static void openSearch(BuildContext context) {
    Navigator.pushNamed(context, SearchScreen.routeName);
  }

  /// Opens the [SearchResultScreen].
  /// The [results] is a [SearchResultsList] which represents the Results
  static void openSearchResultsScreen(
    BuildContext context,
    SearchResultsList results,
  ) {
    Navigator.pushNamed(
      context,
      SearchResultScreen.routeName,
      arguments: results,
    );
  }

  static void openSettingsSubScreen(
    BuildContext context,
    List<SettingsSubTile> subtiles,
    Setting setting,
  ) {
    Navigator.pushNamed(
      context,
      SettingsSubScreen.routeName,
      arguments: SettingsSubScreenArguments(
        subtiles: subtiles,
        folder: setting,
      ),
    );
  }

  /// Pushes the [TodoDetailScreen] on Top of the current Route.
  /// Passes a Todo, which is used in the TodoDetailsScreen to show the Todo
  /// and get the Information needed.
  static void openTodoDetails(BuildContext context, Todo todo) {
    Navigator.pushNamed(
      context,
      TodoDetailScreen.routeName,
      arguments: todo,
    );
  }

  /// goes back one Route.
  /// Is the Same thing as [Navigator.pop(context)].
  /// Is just here to make the Code cleaner
  static void back(BuildContext context) {
    Navigator.pop(context);
  }
}
