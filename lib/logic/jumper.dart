library logic;

import 'package:flutter/material.dart' show Navigator, BuildContext, Color;
import 'package:todo/models/search_results.dart';
import 'package:todo/models/setting.dart' show Setting;
import 'package:todo/screens/color_chooser.dart';
import 'package:todo/screens/components/settings_sub_tile.dart';
import 'package:todo/screens/homescreen.dart';
import 'package:todo/screens/search_screen.dart';
import 'package:todo/screens/settings_screens.dart';

/// This class contains a part of Jumps and Navigating
/// Actions done in the App
/// It does not contain everything. This is because sometimes it
/// is necessary to call setState(() {}) after navigating to a Widget
/// or after popping the Widget. setState(() {}) can't be called in a static
/// reference, so these Methods are implemented into the Widget directly
class Jumper {
  /// Navigate back to the Homescreen and Remove every
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

  /// Jumps to the Settings Sub Screen to show
  /// the Subtiles of a Setting
  static Future<void> openSettingsSubScreen(
    BuildContext context,
    List<SettingsSubTile> subtiles,
    Setting setting,
  ) async {
    await Navigator.pushNamed(
      context,
      SettingsSubScreen.routeName,
      arguments: SettingsSubScreenArguments(
        subtiles: subtiles,
        folder: setting,
      ),
    );
  }

  /// Opens a Named Settings new Screen like [ColorChooser]
  /// for example
  static Future<void> openNamedSettingsNewScreen(
    BuildContext context,
    String routeName,
    dynamic arguments,
  ) async {
    await Navigator.pushNamed(
      context,
      routeName,
      arguments: arguments,
    );
  }

  static void openSubColorScreen(BuildContext context, Color color) {
    Navigator.pushNamed(
      context,
      SubColorChooser.routeName,
      arguments: color,
    );
  }

  /// goes back one Route.
  /// Is the Same thing as [Navigator.pop(context)].
  /// Is just here to make the Code cleaner
  static void back(BuildContext context) {
    Navigator.pop(context);
  }
}
