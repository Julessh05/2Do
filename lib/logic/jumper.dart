library logic;

import 'package:flutter/material.dart';
import 'package:todo/main.dart';
import 'package:todo/models/search_results.dart';
import 'package:todo/models/setting.dart';
import 'package:todo/screens/components/settings_sub_tile.dart';
import 'package:todo/screens/homescreen.dart';
import 'package:todo/screens/search_screen.dart';
import 'package:todo/screens/settings_screens.dart';

/// This class contains a part of Jumps and Navigating
/// Actions done in the App
/// It does not contain everything. This is because sometimes it
/// is nessecary to call setState(() {}) after navigating to a Widget
/// or after poping the Widget. setState(() {}) can't be called in a static
/// reference, so these Methods are implemented into the Widget directly
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
    Navigator.pushReplacementNamed(
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

  /// goes back one Route.
  /// Is the Same thing as [Navigator.pop(context)].
  /// Is just here to make the Code cleaner
  static void back(BuildContext context) {
    Navigator.pop(context);
  }

  static void reloadApp(BuildContext context) {
    // Navigator.pushReplacementNamed(context, TodoApp.routeName);
    Navigator.pushNamed(context, TodoApp.routeName);
  }
}
