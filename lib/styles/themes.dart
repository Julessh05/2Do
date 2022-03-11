library styles;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo/logic/translate.dart';

/// Class with all styles
class Themes {
  static ThemeMode themeMode = ThemeMode.system;

  /// Light Theme of the App
  /// Default Theme
  static ThemeData get lightTheme {
    final _lightTheme = ThemeData(
      /* Global Values */
      brightness: Brightness.light,
      androidOverscrollIndicator: AndroidOverscrollIndicator.glow,
      scaffoldBackgroundColor: Colors.white,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      materialTapTargetSize: MaterialTapTargetSize.padded,

      /* Colors */
      errorColor: Colors.redAccent.shade700,
      disabledColor: Colors.grey.shade400,
      shadowColor: Colors.black87,
      primaryColor: Colors.blue.shade800,
      primaryColorDark: Colors.blue.shade800,
      primaryColorLight: Colors.blue.shade800,
      dividerColor: Colors.grey.shade800,
      backgroundColor: Colors.white,
      dialogBackgroundColor: Colors.white,
      bottomAppBarColor: Colors.blue.shade800,
      indicatorColor: Colors.blue.shade800,

      /* Color Scheme */
      // TODO: change to own Color Scheme
      colorScheme: ColorScheme.light(),

      /* Cupertino Override Theme */
      cupertinoOverrideTheme: NoDefaultCupertinoThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.blue.shade800,
      ),

      /* AppBar Theme */
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 5.0,
        // TODO: check on Device with Navigation Bar and find out what it does
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarColor: Colors.blue.shade900,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.light,
          systemNavigationBarDividerColor: Colors.red,
        ),
        backgroundColor: Colors.blue.shade800,
        iconTheme: const IconThemeData(
          color: Colors.white,
          opacity: 1.0,
        ),
        actionsIconTheme: const IconThemeData(
          opacity: 1.0,
          color: Colors.white,
        ),
        shadowColor: Colors.black87,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
          side: BorderSide(
            color: Colors.blue.shade600,
            style: BorderStyle.solid,
            width: 1.0,
          ),
        ),
      ),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.all<Color>(Colors.blue.shade800),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        materialTapTargetSize: MaterialTapTargetSize.padded,
      ),

      /* List Tile Theme */
      listTileTheme: ListTileThemeData(
        enableFeedback: true,
        style: ListTileStyle.list,
        dense: false,
        iconColor: Colors.black,
        textColor: Colors.black,
        tileColor: Colors.blue.shade800.withAlpha(1),
      ),

      /* Icon Themes */
      iconTheme: const IconThemeData(
        color: Colors.black,
        opacity: 1.0,
      ),
      primaryIconTheme: const IconThemeData(
        color: Colors.black,
        opacity: 1.0,
      ),

      /* Checkbox Theme */
      checkboxTheme: CheckboxThemeData(
        checkColor: MaterialStateProperty.all<Color>(Colors.white),
        fillColor: MaterialStateProperty.all<Color>(Colors.blue.shade800),
        materialTapTargetSize: MaterialTapTargetSize.padded,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
        ),
        side: BorderSide(
          color: Colors.blue.shade800,
          style: BorderStyle.solid,
          width: 0.7,
        ),
      ),

      /* === BUTTONS === */

      /* Text Button Theme */
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          tapTargetSize: MaterialTapTargetSize.padded,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.only(right: 10, left: 10),
          ),
          alignment: Alignment.center,
          elevation: MaterialStateProperty.all<double>(10.0),
          enableFeedback: true,
          backgroundColor: MaterialStateProperty.all<Color>(
            Colors.blue.shade800,
          ),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        ),
      ),

      /* Toggle Buttons Theme */
      toggleButtonsTheme: ToggleButtonsThemeData(
        disabledColor: Colors.grey.shade400,
        disabledBorderColor: Colors.grey,
        color: Colors.white,
        fillColor: Colors.blue.shade800,
      ),

      /* Elevated Button Theme */
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          alignment: Alignment.center,
          elevation: MaterialStateProperty.all<double>(10.0),
          enableFeedback: true,
          tapTargetSize: MaterialTapTargetSize.padded,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
      ),

      /* Outline Button Theme */
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          alignment: Alignment.center,
          elevation: MaterialStateProperty.all<double>(10.0),
          enableFeedback: true,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          tapTargetSize: MaterialTapTargetSize.padded,
        ),
      ),

      /* Button Theme */
      buttonTheme: const ButtonThemeData(
        materialTapTargetSize: MaterialTapTargetSize.padded,
      ),

      /* Floating Action Button Theme */
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.blue.shade800,
        disabledElevation: 10.0,
        elevation: 14.0,
        enableFeedback: true,
        foregroundColor: Colors.white,
        shape: CircleBorder(
          side: BorderSide(
            color: Colors.blue.shade600,
            style: BorderStyle.solid,
            width: 0.7,
          ),
        ),
      ),

      /* Switch Theme Data */
      switchTheme: const SwitchThemeData(
        materialTapTargetSize: MaterialTapTargetSize.padded,
      ),

      /* Bottom Sheet Theme */
      bottomSheetTheme: BottomSheetThemeData(
        modalBackgroundColor: Colors.green,
        modalElevation: 10.0,
        backgroundColor: Colors.white,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 10.0,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(30),
          ),
          side: BorderSide(
            color: Colors.blue.shade800,
            style: BorderStyle.solid,
            width: 0.2,
          ),
        ),
      ),

      /* Dialog Theme */
      dialogTheme: const DialogTheme(
        alignment: Alignment.center,
        backgroundColor: Colors.white,
        elevation: 20.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
      ),

      /* Input Decoration Theme */
      inputDecorationTheme: InputDecorationTheme(
        floatingLabelStyle: const TextStyle(color: Colors.grey),
        labelStyle: TextStyle(color: Colors.grey.shade400),
        helperMaxLines: 2,
        isDense: false,
        filled: false,
        floatingLabelAlignment: FloatingLabelAlignment.start,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        alignLabelWithHint: true,
        iconColor: Colors.black,
        fillColor: Colors.transparent,
        prefixIconColor: Colors.black,
        suffixIconColor: Colors.black,
        isCollapsed: false,
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(30),
          ),
          borderSide: BorderSide(
            color: Colors.blue.shade700,
            style: BorderStyle.solid,
            width: 1.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(35),
          ),
          borderSide: BorderSide(
            color: Colors.blue.shade800,
            style: BorderStyle.solid,
            width: 1.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
          borderSide: BorderSide(
            color: Colors.red.shade700,
            style: BorderStyle.solid,
            width: 0.9,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
          borderSide: BorderSide(
            color: Colors.purple.shade700,
            style: BorderStyle.solid,
            width: 0.7,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(17),
          ),
          borderSide: BorderSide(
            color: Colors.grey.shade400,
            style: BorderStyle.solid,
            width: 0.9,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(30),
          ),
          borderSide: BorderSide(
            color: Colors.red.shade800,
            style: BorderStyle.solid,
            width: 0.9,
          ),
        ),
        errorMaxLines: 1000,
        errorStyle: TextStyle(
          color: Colors.red.shade300,
          decoration: TextDecoration.underline,
          decorationColor: Colors.red.shade100,
          decorationThickness: 0.3,
          decorationStyle: TextDecorationStyle.wavy,
        ),
      ),

      /* Text Theme */
      textTheme: TextTheme(
        bodyLarge: TextStyle(
          color: Colors.black,
          overflow: TextOverflow.fade,
          locale: Translation.activeLocale,
          textBaseline: TextBaseline.alphabetic,
        ),
        bodyMedium: TextStyle(
          color: Colors.black,
          overflow: TextOverflow.fade,
          locale: Translation.activeLocale,
          textBaseline: TextBaseline.alphabetic,
        ),
        bodySmall: TextStyle(
          color: Colors.black,
          overflow: TextOverflow.fade,
          locale: Translation.activeLocale,
          textBaseline: TextBaseline.alphabetic,
        ),
        displayLarge: TextStyle(
          color: Colors.black,
          overflow: TextOverflow.fade,
          locale: Translation.activeLocale,
          textBaseline: TextBaseline.alphabetic,
        ),
        displayMedium: TextStyle(
          color: Colors.black,
          overflow: TextOverflow.fade,
          locale: Translation.activeLocale,
          textBaseline: TextBaseline.alphabetic,
        ),
        displaySmall: TextStyle(
          color: Colors.black,
          overflow: TextOverflow.fade,
          locale: Translation.activeLocale,
          textBaseline: TextBaseline.alphabetic,
        ),
        headlineLarge: TextStyle(
          color: Colors.black,
          overflow: TextOverflow.fade,
          locale: Translation.activeLocale,
          textBaseline: TextBaseline.alphabetic,
        ),
        headlineMedium: TextStyle(
          color: Colors.black,
          overflow: TextOverflow.fade,
          locale: Translation.activeLocale,
          textBaseline: TextBaseline.alphabetic,
        ),
        headlineSmall: TextStyle(
          color: Colors.black,
          overflow: TextOverflow.fade,
          locale: Translation.activeLocale,
          textBaseline: TextBaseline.alphabetic,
        ),
        labelLarge: TextStyle(
          color: Colors.black,
          overflow: TextOverflow.fade,
          locale: Translation.activeLocale,
          textBaseline: TextBaseline.alphabetic,
        ),
        labelMedium: TextStyle(
          color: Colors.black,
          overflow: TextOverflow.fade,
          locale: Translation.activeLocale,
          textBaseline: TextBaseline.alphabetic,
        ),
        labelSmall: TextStyle(
          color: Colors.black,
          overflow: TextOverflow.fade,
          locale: Translation.activeLocale,
          textBaseline: TextBaseline.alphabetic,
        ),
        titleLarge: TextStyle(
          color: Colors.black,
          overflow: TextOverflow.fade,
          locale: Translation.activeLocale,
          textBaseline: TextBaseline.alphabetic,
        ),
        titleMedium: TextStyle(
          color: Colors.black,
          overflow: TextOverflow.fade,
          locale: Translation.activeLocale,
          textBaseline: TextBaseline.alphabetic,
        ),
        titleSmall: TextStyle(
          color: Colors.black,
          overflow: TextOverflow.fade,
          locale: Translation.activeLocale,
          textBaseline: TextBaseline.alphabetic,
        ),
      ),

      /* Divider Theme */
      dividerTheme: DividerThemeData(
        color: Colors.grey.shade300,
      ),

      /* Progress Indicator Theme */
      progressIndicatorTheme: ProgressIndicatorThemeData(
        circularTrackColor: Colors.white,
        color: Colors.blue.shade800,
        refreshBackgroundColor: Colors.white,
      ),

      /* Drawer Theme */
      drawerTheme: const DrawerThemeData(
        backgroundColor: Colors.white70,
        elevation: 7.0,
      ),

      /* Typography */
      typography: Typography(),

      /* Scrollbar Theme */
      scrollbarTheme: const ScrollbarThemeData(
        interactive: true,
        showTrackOnHover: true,
        isAlwaysShown: false,
      ),
    );

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
