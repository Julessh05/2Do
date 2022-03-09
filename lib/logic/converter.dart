library logic;

import 'package:flutter/material.dart';
import 'package:todo/logic/translate.dart';

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
    if (Translation.activeLocale == const Locale("en", "US")) {
      return "$day.$month.$year - $hour:$minute";
    } else if (Translation.activeLocale == const Locale("de", "DE")) {
      return "$day.$month.$year - $hour:$minute Uhr";
    } else {
      return "$day.$month.$year - $hour:$minute";
    }
  }

  /// Converts a [String] to a [DateTime]
  static DateTime stringToDateTime(String string) {
    // TODO: correct Implementation
    return DateTime.parse(string);
  }

  /// Converts a [DateTime] to a [String] and rerturns the Time only
  /// Format:
  /// HH:MM
  static String onlyTime(DateTime dateTime) {
    // Convert Hour
    final String hour = dateTime.hour.toString().padLeft(2, '0');

    // Convert Minute
    final String minute = dateTime.minute.toString().padLeft(2, '0');

    return "$hour:$minute";
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

    return "$day.$month.$year";
  }

  /// Converts a [TimeOfDay] to a [String] and returns it in the
  /// following Format:
  /// HH:MM
  static String timeOfDaytoString(TimeOfDay time) {
    // Convert Hour
    final String hour = time.hour.toString().padLeft(2, '0');

    // Convert Minute
    final String minute = time.minute.toString().padLeft(2, '0');

    return "$hour:$minute";
  }

  /// Parses an Settings Value of an supported Type to String
  /// so you can show it or store it
  static String supportedObjectToString() {
    return "";
  }

  /// Parses a String o an Object which is supported and used in
  /// the App. Returns this Object.
  /// Used to get a ObjectValue from a Setting while reading it from
  /// the Storage
  static Object stringToSupportedObject(String string) {
    return Object;
  }
}

/// Parse String to Bool
extension BoolParse on String {
  /// Parses String to Boolean and returns eigther true or false
  /// null isn't possible
  bool parseBool() {
    return toLowerCase() == "true";
  }
}
