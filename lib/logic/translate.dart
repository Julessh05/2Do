library logic;

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
  /// ```dart
  /// {
  ///   const Locale("language Code", "country Code"): "Value"
  ///   const Locale("language Code", "country Code"): "Value"
  /// }
  /// ```
  static final List<Map<Locale, String>> _translations = [
    {
      const Locale("en", "US"): "2Do",
      const Locale("de", "DE"): "2Do",
    },
    {
      const Locale("en", "US"): "Open Settings",
      const Locale("de", "DE"): "Einstellungen öffnen"
    },
    {
      const Locale("en", "US"): "Search",
      const Locale("de", "DE"): "Suchen",
    },
    {
      const Locale("en", "US"): "Settings",
      const Locale("de", "DE"): "Einstellungen",
    },
    {
      const Locale("en", "US"): "Choose your Language",
      const Locale("de", "DE"): "Wähle deine Sprache",
    },
    {
      const Locale("en", "US"): "English",
      const Locale("de", "DE"): "Englisch",
    },
    {
      const Locale("en", "US"): "German",
      const Locale("de", "DE"): "Deutsch",
    },
    {
      const Locale("en", "US"): "Title",
      const Locale("de", "DE"): "Titel",
    },
    {
      const Locale("en", "US"): "Todo Title",
      const Locale("de", "DE"): "Todo Titel",
    },
    {
      const Locale("en", "US"): "Unknown Page",
      const Locale("de", "DE"): "Unbekannte Seite",
    },
    {
      const Locale("en", "US"):
          "Something went wrong while navigating to the page you wanted to see.",
      const Locale("de", "DE"):
          "Etwas ist schiefgegangen während wir versuchten diese Seite zu finden",
    },
    {
      const Locale("en", "US"): "Back to the Homescreen",
      const Locale("de", "DE"): "Zurück zum Startbildschirm",
    },
    {
      const Locale("en", "US"): "Name of the Setting",
      const Locale("de", "DE"): "Name der Einstellung",
    },
    {
      const Locale("en", "US"): "Value of the Setting",
      const Locale("de", "DE"): "Wert der Einstellung",
    },
    {
      const Locale("en", "US"): "Value of the Info",
      const Locale("de", "DE"): "Wert der Info",
    },
    {
      const Locale("en", "US"): "Choose your Theme Mode",
      const Locale("de", "DE"): "Wähle dein Farbthema",
    },
    {
      const Locale("en", "US"): "Add Todo",
      const Locale("de", "DE"): "Todo hinzufügen",
    }
  ];

  /// Translates the String to the [activeLocale]
  static String getTranslation(String input) {
    for (Map _map in _translations) {
      if (_map[const Locale("en", "US")] == input) {
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
