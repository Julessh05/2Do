library logic;

import 'dart:collection';

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

  /// The Translations as a [HashMap].
  /// HashMap is used, because it has a constant time
  /// when searching in it.
  static final HashMap<String, Map<Locale, String>> _translations =
      HashMap.from(_translationsMap);

  /// The Translations as a Map
  /// Pattern:
  /// ```dart
  /// "Value in English": {
  ///   const Locale("language Code", "country Code"): "Value"
  ///   const Locale("language Code", "country Code"): "Value"
  /// }
  /// ```
  static final _translationsMap = <String, Map<Locale, String>>{
    "2Do": {
      const Locale("de", "DE"): "2Do",
    },
    "Open Settings": {
      const Locale("de", "DE"): "Einstellungen öffnen",
    },
    "Search": {
      const Locale("de", "DE"): "Suchen",
    },
    "Settings": {
      const Locale("de", "DE"): "Einstellungen",
    },
    "Choose your Language": {
      const Locale("de", "DE"): "Wähle deine Sprache",
    },
    "English": {
      const Locale("de", "DE"): "Englisch",
    },
    "German": {
      const Locale("de", "DE"): "Deutsch",
    },
    "Title": {
      const Locale("de", "DE"): "Titel",
    },
    "Todo Title": {
      const Locale("de", "DE"): "Todo Titel",
    },
    "Todo Time": {
      const Locale("de", "DE"): "Todo Zeit",
    },
    "Unknown Page": {
      const Locale("de", "DE"): "Unbekannte Seite",
    },
    "Something went wrong while navigating to the page you wanted to see": {
      const Locale("de", "DE"):
          "Etwas ist schiefgegangen während wir versuchten diese Seite zu finden",
    },
    "Back to the Homescreen": {
      const Locale("de", "DE"): "Zurück zum Startbildschirm",
    },
    "Name of the Setting": {
      const Locale("de", "DE"): "Name der Einstellung",
    },
    "Value of the Setting": {
      const Locale("de", "DE"): "Wert der Einstellung",
    },
    "Value of the Info": {
      const Locale("de", "DE"): "Wert der Info",
    },
    "Choose your Theme Mode": {
      const Locale("de", "DE"): "Wähle dein Farbthema",
    },
    "Add Todo": {
      const Locale("de", "DE"): "Todo hinzufügen",
    },
    "Set a Date": {
      const Locale("de", "DE"): "Setze das Datum",
    },
    "Date": {
      const Locale("de", "DE"): "Datum",
    },
    "Set a Time": {
      const Locale("de", "DE"): "Setze die Zeit",
    },
    "Time": {
      const Locale("de", "DE"): "Zeit",
    },
    "Cancel": {
      const Locale("de", "DE"): "Abbrechen",
    },
    "Confirm": {
      const Locale("de", "DE"): "Bestätigen",
    },
    "Insert Title": {
      const Locale("de", "DE"): "Titel einfügen",
    },
    "Insert Content": {
      const Locale("de", "DE"): "Inhalt einfügen",
    },
    "is missing": {
      const Locale("de", "DE"): "fehlt",
    },
    "Some Values missing": {
      const Locale("de", "DE"): "Einige Informationen fehlen",
    },
    "The following Value is missing:": {
      const Locale("de", "DE"): "Die folgende Information fehlt:"
    },
    "The following Values are missing:": {
      const Locale("de", "DE"): "Die folgenden Informationen fehlen:",
    },
    "OK": {
      const Locale("de", "DE"): "OK",
    },
    "Edit Title": {
      const Locale("de", "DE"): "Titel bearbeiten",
    },
    "Edit": {
      const Locale("de", "DE"): "Bearbeiten",
    },
    "Language": {
      const Locale("de", "DE"): "Sprache",
    },
    "Thememode": {
      const Locale("de", "DE"): "Helligkeitsmodus",
    },
    "Notifications": {
      const Locale("de", "DE"): "Benachrichtigungen",
    },
    "Search Results": {
      const Locale("de", "DE"): "Suchergebnisse",
    },
    "No Results": {
      const Locale("de", "DE"): "Keine Ergebnisse",
    },
    "No Results were found": {
      const Locale("de", "DE"): "Es wurden keine Ergebnisse gefunden",
    },
    "Todo": {
      const Locale("de", "DE"): "Todo",
    },
    "Setting": {
      const Locale("de", "DE"): "Einstellung",
    },
    "Choose an Standard Importance": {
      const Locale("de", "DE"): "Wähle die Standard Dringlichkeit"
    },
    "Set an Importance": {
      const Locale("de", "DE"): "Setze die Dringlichkeit",
    },
    "Importance": {
      const Locale("de", "DE"): "Dringlichkeit",
    },
    "Todo Content": {
      const Locale("de", "DE"): "Todo Inhalt",
    },
    "Edit Todo": {
      const Locale("de", "DE"): "Todo Bearbeiten",
    },
    "Edit Content": {
      const Locale("de", "DE"): "Inhalt bearbeiten",
    },
    "Light": {
      const Locale("de", "DE"): "Hell",
    },
    "Dark": {
      const Locale("de", "DE"): "Dunkel",
    },
    "Search something...": {
      const Locale("de", "DE"): "Suche etwas...",
    },
    "You don't have any Todos": {
      const Locale("de", "DE"): "Du hast keine Todos",
    },
    "Add one": {
      const Locale("de", "DE"): "Eines hinzufügen",
    },
    "Checked Todos": {
      const Locale("de", "DE"): "Erledigte Todos",
    },
    "Show Checked Todos": {
      const Locale("de", "DE"): "Erledigte Todos anzeigen",
    },
    "None of your Todos are checked": {
      const Locale("de", "DE"): "Keines deiner Todos ist erledigt",
    },
    "Title:": {
      const Locale("de", "DE"): "Titel",
    },
    "Content:": {
      const Locale("de", "DE"): "Inhalt:",
    },
    "Checked:": {
      const Locale("de", "DE"): "Erledigt:",
    },
    "About": {
      const Locale("de", "DE"): "Über",
    },
    "Everything about the App": {
      const Locale("de", "DE"): "Alles über die App",
    },
    "Active": {
      const Locale("de", "DE"): "Aktiv",
    },
    "Inactive": {
      const Locale("de", "DE"): "Inaktiv",
    },
    "Delete Todo": {
      const Locale("de", "DE"): "Todo löschen",
    },
  };

  /// Translates the String to the [activeLocale]
  static String getTranslation(String input) {
    final _translation = _translations[input];
    if (_translation != null) {
      return _translation[Translation.activeLocale]!;
    } else {
      return input;
    }
  }
}

/// Extension to translate a String
extension Translate on String {
  /// Translates the String to the Language used in the App
  String translate() {
    if (Translation.activeLocale == const Locale("en", "US")) {
      return this;
    } else {
      final _translation = Translation.getTranslation(this);
      return _translation;
    }
  }
}
