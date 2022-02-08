import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Holds everything needed to translate stuff
class Translation {
  /// The supported Locales
  static final supportedLocales = {
    const Locale("en", "US"),
    const Locale("de", "DE"),
  };

  /// The active locale (at the Moment)
  static final activeLocale = supportedLocales.first;

  /// The Translations
  /// Pattern:
  /// {
  ///   const Locale("language Code", "country Code"): "Value"
  ///   const Locale("language Code", "country Code"): "Value"
  static final List<Map<Locale, String>> _translations = [
    {
      const Locale("en", "US"): "2Do",
      const Locale("de", "DE"): "2Do",
    },
  ];

  /// Translates the String to the [activeLocale]
  static String getTranslation(String input) {
    for (Map _map in _translations) {
      if (_map[const Locale("en", "US")].contains(input)) {
        return _map[activeLocale];
      } else {
        continue;
      }
    }
    return input;
  }
}

/// Extension to translate a String
extension Translate on String {
  /// Translates the String
  String translate() {
    final _translation = Translation.getTranslation(this);

    return _translation;
  }
}
