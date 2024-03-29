library logic;

import 'package:flutter/material.dart'
    show TimeOfDay, Locale, ThemeMode, MaterialColor, Color;
import 'package:string_translate/string_translate.dart'
    show Translate, Translation;

/// Holds every method to convert Object in another and the other way around
class Converter {
  /// Converts a [DateTime] to a [String] to use in a Text Widget
  /// or similar.
  /// Returns year.month.day - hour:minute
  static String dateToString(DateTime dateTime) {
    // Convert year
    final String year = dateTime.year.toString().padLeft(2, '0');

    // Convert Month
    final String month = dateTime.month.toString().padLeft(2, '0');

    // Convert Day
    final String day = dateTime.day.toString().padLeft(2, '0');

    // Convert Hour
    final String hour = dateTime.hour.toString().padLeft(2, '0');

    // Convert Minute
    final String minute = dateTime.minute.toString().padLeft(2, '0');

    // Returns the Value based on the activeLocale of the Ap
    if (Translation.activeLocale == const Locale('en', 'US')) {
      return '$day.$month.$year - $hour:$minute';
    } else if (Translation.activeLocale == const Locale('de', 'DE')) {
      return '$day.$month.$year - $hour:$minute Uhr';
    } else {
      return '$day.$month.$year - $hour:$minute';
    }
  }

  /// Converts a [String] to a [DateTime]
  static DateTime stringToDateTime(String string) {
    // TODO: correct Implementation
    return DateTime.parse(string);
  }

  /// Converts a [DateTime] to a [String] and returns the Time only
  /// Format:
  /// HH:MM
  static String onlyTime(DateTime dateTime) {
    // Convert Hour
    final String hour = dateTime.hour.toString().padLeft(2, '0');

    // Convert Minute
    final String minute = dateTime.minute.toString().padLeft(2, '0');

    return '$hour:$minute';
  }

  /// Converts a [DateTime] to a [String] and return only the Date
  /// Format:
  /// DD.MM.YYYY
  static String onlyDate(DateTime dateTime) {
    // Convert year
    final String year = dateTime.year.toString().padLeft(2, '0');

    // Convert Month
    final String month = dateTime.month.toString().padLeft(2, '0');

    // Convert Day
    final String day = dateTime.day.toString().padLeft(2, '0');

    return '$day.$month.$year';
  }

  /// Converts a [TimeOfDay] to a [String] and returns it in the
  /// following Format:
  /// HH:MM
  static String timeOfDayToString(TimeOfDay time) {
    // Convert Hour
    final String hour = time.hour.toString().padLeft(2, '0');

    // Convert Minute
    final String minute = time.minute.toString().padLeft(2, '0');

    return '$hour:$minute';
  }

  /// Parses an Settings Value of an supported Type to String
  /// so you can show it or store it
  /// Supported are:
  /// Locale and
  /// ThemeMode
  static String supportedObjectToDisplayableString(
    dynamic object,
    bool? translate,
  ) {
    final String output;
    switch (object.runtimeType) {
      case Locale:
        if (object == const Locale('de', 'DE')) {
          output = 'German';
        } else if (object == const Locale('fr', 'FR')) {
          output = 'French';
        } else {
          output = 'English';
        }
        break;
      case ThemeMode:
        if (object == ThemeMode.dark) {
          output = 'Dark';
        } else if (object == ThemeMode.light) {
          output = 'Light';
        } else {
          output = 'System';
        }
        break;
      case bool:
        if (object == true) {
          output = 'Active';
        } else {
          output = 'Inactive';
        }
        break;
      // Material Color and Color do the Same Thing
      // That's due to the reason that storing and displaying
      // are using dirretent Types of objects
      case MaterialColor:
        output = object.value.toRadixString(16);
        break;
      case Color:
        output = object.value.toRadixString(16);
        break;
      default:
        output = 'Error parsing String';
        break;
    }
    if (translate == true) {
      return output.tr();
    } else {
      return output;
    }
  }

  /// Returns the Type of a specific Value as a String
  /// This is used to store the Type. The Type then is needed again
  /// to load the Settings from the Storage
  static String supportedTypeToString(Type type) {
    final String localType;
    switch (type) {
      case Locale:
        localType = 'Locale';
        break;
      case ThemeMode:
        localType = 'ThemeMode';
        break;
      case Color:
        localType = 'Color';
        break;
      default:
        localType = 'Unsupported Type';
        break;
    }
    return localType;
  }

  /// Parses a String o an Object which is supported and used in
  /// the App. Returns this Object.
  /// Used to get a ObjectValue from a Setting while reading it from
  /// the Storage
  /// Supported are:
  /// Locale,
  /// ThemeMode and
  /// Color
  static Object stringToSupportedObject(String string, String type) {
    final Object object;
    switch (type) {
      case 'Locale':
        if (string == 'German') {
          object = const Locale('de', 'DE');
        } else if (string == 'French') {
          object = const Locale('fr', 'FR');
        } else {
          object = const Locale('en', 'US');
        }
        break;
      case 'ThemeMode':
        if (string == 'Dark') {
          object = ThemeMode.dark;
        } else if (string == 'Light') {
          object = ThemeMode.light;
        } else {
          object = ThemeMode.system;
        }
        break;
      case 'Color':
        object = Color(int.parse(string, radix: 16));
        break;
      default:
        object = Error;
        break;
    }
    return object;
  }
}

/// Parse String to Bool
extension BoolParse on String {
  /// Parses String to Boolean and returns either true or false
  /// null isn't possible
  bool parseBool() {
    return toLowerCase() == 'true';
  }
}
