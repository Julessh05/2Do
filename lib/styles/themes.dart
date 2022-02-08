import 'package:flutter/material.dart';

/// Class with all styles
class Themes {
  static ThemeMode? _themeMode;

  static ThemeMode get themeMode => _themeMode ?? ThemeMode.system;

  static set themeMode(ThemeMode value) {
    _themeMode = value;
  }

  /// Light Theme of the App
  static ThemeData get lightTheme {
    final _lightTheme = ThemeData();

    return _lightTheme;
  }

  /// Dark Theme of the App
  static ThemeData get darkTheme {
    final _darkTheme = ThemeData();

    return _darkTheme;
  }

  /// High Contrast Light Theme of the App
  static ThemeData get highContrastLightTheme {
    final _highContrastLightTheme = ThemeData();

    return _highContrastLightTheme;
  }

  /// High Contrast Dark Theme of the App
  static ThemeData get highContrastDarkTheme {
    final _highContrastDarkTheme = ThemeData();

    return _highContrastDarkTheme;
  }
}
