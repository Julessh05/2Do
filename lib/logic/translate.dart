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
  static Locale activeLocale = supportedLocales.first;

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
      const Locale("en", "US"): "Todo Time",
      const Locale("de", "DE"): "Todo Zeit",
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
    },
    {
      const Locale("en", "US"): "Set a Date",
      const Locale("de", "DE"): "Setze das Datum",
    },
    {
      const Locale("en", "US"): "Date",
      const Locale("de", "DE"): "Datum",
    },
    {
      const Locale("en", "US"): "Set a Time",
      const Locale("de", "DE"): "Setze die Zeit",
    },
    {
      const Locale("en", "US"): "Time",
      const Locale("de", "DE"): "Zeit",
    },
    {
      const Locale("en", "US"): "Cancel",
      const Locale("de", "DE"): "Abbrechen",
    },
    {
      const Locale("en", "US"): "Confirm",
      const Locale("de", "DE"): "Bestätigen",
    },
    {
      const Locale("en", "US"): "Insert Title",
      const Locale("de", "DE"): "Titel einfügen",
    },
    {
      const Locale("en", "US"): "Insert Content",
      const Locale("de", "DE"): "Inhalt einfügen",
    },
    {
      const Locale("en", "US"): "is missing",
      const Locale("de", "DE"): "fehlt",
    },
    {
      const Locale("en", "US"): "Some Values missing",
      const Locale("de", "DE"): "Einige Informationen fehlen",
    },
    {
      const Locale("en", "US"): "The following Value is missing:",
      const Locale("de", "DE"): "Die folgende Information fehlt:",
    },
    {
      const Locale("en", "US"): "The following Values are missing:",
      const Locale("de", "DE"): "Die folgenden Informationen fehlen:",
    },
    {
      const Locale("en", "US"): "OK",
      const Locale("de", "DE"): "OK",
    },
    {
      const Locale("en", "US"): "Edit Title",
      const Locale("de", "DE"): "Titel bearbeiten",
    },
    {
      const Locale("en", "US"): "Edit",
      const Locale("de", "DE"): "Bearbeiten",
    },
    {
      const Locale("en", "US"): "Language",
      const Locale("de", "DE"): "Sprache",
    },
    {
      const Locale("en", "US"): "Thememode",
      const Locale("de", "DE"): "Helligkeitsmodus",
    },
    {
      const Locale("en", "US"): "Notifications",
      const Locale("de", "DE"): "Benachrichtigungen",
    },
    {
      const Locale("en", "US"): "Search Results",
      const Locale("de", "DE"): "Suchergebnisse",
    },
    {
      const Locale("en", "US"): "No Results",
      const Locale("de", "DE"): "Keine Ergebnisse",
    },
    {
      const Locale("en", "US"): "No Results were found",
      const Locale("de", "DE"): "Es wurden keine Ergebnisse gefunden",
    },
    {
      const Locale("en", "US"): "Todo",
      const Locale("de", "DE"): "Todo",
    },
    {
      const Locale("en", "US"): "Setting",
      const Locale("de", "DE"): "Einstellung",
    },
    {
      const Locale("en", "US"): "Choose an Standard Importance",
      const Locale("de", "DE"): "Wähle die Standard Dringlichkeit",
    },
    {
      const Locale("en", "US"): "Set an Importance",
      const Locale("de", "DE"): "Setze die Dringlichkeit"
    },
    {
      const Locale("en", "US"): "Importance",
      const Locale("de", "DE"): "Dringlichkeit",
    },
    {
      const Locale("en", "US"): "Todo Content",
      const Locale("de", "DE"): "Todo Inhalt",
    },
    {
      const Locale("en", "US"): "Edit Todo",
      const Locale("de", "DE"): "Todo bearbeiten",
    },
    {
      const Locale("en", "US"): "Edit Title",
      const Locale("de", "DE"): "Titel bearbeiten",
    },
    {
      const Locale("en", "US"): "Edit Content",
      const Locale("de", "DE"): "Inhalt bearbeiten",
    },
    {
      const Locale("en", "US"): "Light",
      const Locale("de", "DE"): "Hell",
    },
    {
      const Locale("en", "US"): "Dark",
      const Locale("de", "DE"): "Dunkel",
    },
    {
      const Locale("en", "US"): "Search something...",
      const Locale("de", "DE"): "Suche etwas...",
    },
    {
      const Locale("en", "US"): "You don't have any Todos",
      const Locale("de", "DE"): "Du hast keine Todos",
    },
    {
      const Locale("en", "US"): "Add one",
      const Locale("de", "DE"): "Eines hinzufügen",
    },
    {
      const Locale("en", "US"): "Checked Todos",
      const Locale("de", "DE"): "Erledigte Todos",
    },
    {
      const Locale("en", "US"): "Show Checked Todos",
      const Locale("de", "DE"): "Erledigte Todos anzeigen",
    },
    {
      const Locale("en", "US"): "None of your Todos are checked",
      const Locale("de", "DE"): "Keines deiner Todos ist erledigt",
    },
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
