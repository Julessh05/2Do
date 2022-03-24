library logic;

import 'dart:collection';

import 'package:flutter/material.dart';

/// Holds everything needed to translate stuff
class Translation {
  /// The supported Locales
  static final supportedLocales = {
    const Locale("en", "US"),
    const Locale("de", "DE"),
    const Locale("fr", "FR"),
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
      const Locale("fr", "FR"): "2Do",
    },
    "Open Settings": {
      const Locale("de", "DE"): "Einstellungen öffnen",
      const Locale("fr", "FR"): "Ouvrir les paramètres"
    },
    "Search": {
      const Locale("de", "DE"): "Suchen",
      const Locale("fr", "FR"): "Chercher"
    },
    "Settings": {
      const Locale("de", "DE"): "Einstellungen",
      const Locale("fr", "FR"): "Réglages"
    },
    "Choose your Language": {
      const Locale("de", "DE"): "Wähle deine Sprache",
      const Locale("fr", "FR"): "Choisissez votre langue"
    },
    "English": {
      const Locale("de", "DE"): "Englisch",
      const Locale("fr", "FR"): "Anglais"
    },
    "German": {
      const Locale("de", "DE"): "Deutsch",
      const Locale("fr", "FR"): "Allemand"
    },
    "Title": {
      const Locale("de", "DE"): "Titel",
      const Locale("fr", "FR"): "Titre"
    },
    "Todo Title": {
      const Locale("de", "DE"): "Todo Titel",
      const Locale("fr", "FR"): "Titre de la tâche"
    },
    "Todo Time": {
      const Locale("de", "DE"): "Todo Zeit",
      const Locale("fr", "FR"): "Temps de travail"
    },
    "Unknown Page": {
      const Locale("de", "DE"): "Unbekannte Seite",
      const Locale("fr", "FR"): "page inconnue"
    },
    "Something went wrong while navigating to the page you wanted to see": {
      const Locale("de", "DE"):
          "Etwas ist schiefgegangen während wir versuchten diese Seite zu finden",
      const Locale("fr", "FR"):
          "Une erreur s'est produite lors de la navigation vers la page que vous vouliez voir",
    },
    "Back to the Homescreen": {
      const Locale("de", "DE"): "Zurück zum Startbildschirm",
      const Locale("fr", "FR"): "Retour à l'écran d'accueil"
    },
    "Name of the Setting": {
      const Locale("de", "DE"): "Name der Einstellung",
      const Locale("fr", "FR"): "Nom du paramètre"
    },
    "Value of the Setting": {
      const Locale("de", "DE"): "Wert der Einstellung",
      const Locale("fr", "FR"): "Valeur du paramètre"
    },
    "Value of the Info": {
      const Locale("de", "DE"): "Wert der Info",
      const Locale("fr", "FR"): "Valeur de l'info"
    },
    "Choose your Theme Mode": {
      const Locale("de", "DE"): "Wähle dein Farbthema",
      const Locale("fr", "FR"): "Choisissez votre mode thématique"
    },
    "Add Todo": {
      const Locale("de", "DE"): "Todo hinzufügen",
      const Locale("fr", "FR"): "Ajouter une tâche"
    },
    "Set a Date": {
      const Locale("de", "DE"): "Setze das Datum",
      const Locale("fr", "FR"): "Choisir une date"
    },
    "Date": {
      const Locale("de", "DE"): "Datum",
      const Locale("fr", "FR"): "Date",
    },
    "Set a Time": {
      const Locale("de", "DE"): "Setze die Zeit",
      const Locale("fr", "FR"): "Définir une heure",
    },
    "Time": {
      const Locale("de", "DE"): "Zeit",
      const Locale("fr", "FR"): "Temps",
    },
    "Cancel": {
      const Locale("de", "DE"): "Abbrechen",
      const Locale("fr", "FR"): "Annuler",
    },
    "Confirm": {
      const Locale("de", "DE"): "Bestätigen",
      const Locale("fr", "FR"): "Confirmer",
    },
    "Insert Title": {
      const Locale("de", "DE"): "Titel einfügen",
      const Locale("fr", "FR"): "Insérer un titre",
    },
    "Insert Content": {
      const Locale("de", "DE"): "Inhalt einfügen",
      const Locale("fr", "FR"): "Insérer du contenu",
    },
    "is missing": {
      const Locale("de", "DE"): "fehlt",
      const Locale("fr", "FR"): "est manquant",
    },
    "Some Values missing": {
      const Locale("de", "DE"): "Einige Informationen fehlen",
      const Locale("fr", "FR"): "Certaines valeurs manquent",
    },
    "The following Value is missing:": {
      const Locale("de", "DE"): "Die folgende Information fehlt:",
      const Locale("fr", "FR"): "La valeur suivante est manquante:",
    },
    "The following Values are missing:": {
      const Locale("de", "DE"): "Die folgenden Informationen fehlen:",
      const Locale("fr", "FR"): "Les valeurs suivantes sont manquantes:",
    },
    "OK": {
      const Locale("de", "DE"): "OK",
      const Locale("fr", "FR"): "d'accord",
    },
    "Edit Title": {
      const Locale("de", "DE"): "Titel bearbeiten",
      const Locale("fr", "FR"): "Modifier le titre",
    },
    "Edit": {
      const Locale("de", "DE"): "Bearbeiten",
      const Locale("fr", "FR"): "Éditer",
    },
    "Language": {
      const Locale("de", "DE"): "Sprache",
      const Locale("fr", "FR"): "Langue",
    },
    "Thememode": {
      const Locale("de", "DE"): "Helligkeitsmodus",
      const Locale("fr", "FR"): "Mode thématique",
    },
    "Notifications": {
      const Locale("de", "DE"): "Benachrichtigungen",
      const Locale("fr", "FR"): "Avis",
    },
    "Search Results": {
      const Locale("de", "DE"): "Suchergebnisse",
      const Locale("fr", "FR"): "Résultats de recherche",
    },
    "No Results": {
      const Locale("de", "DE"): "Keine Ergebnisse",
      const Locale("fr", "FR"): "Aucun résultat",
    },
    "No Results were found": {
      const Locale("de", "DE"): "Es wurden keine Ergebnisse gefunden",
      const Locale("fr", "FR"): "Aucun resultat n'a été trouvé",
    },
    "Todo": {
      const Locale("de", "DE"): "Todo",
      const Locale("fr", "FR"): "À faire",
    },
    "Setting": {
      const Locale("de", "DE"): "Einstellung",
      const Locale("fr", "FR"): "Réglage",
    },
    "Choose an Standard Importance": {
      const Locale("de", "DE"): "Wähle die Standard Dringlichkeit",
      const Locale("fr", "FR"): "Choisissez une importance standard",
    },
    "Set an Importance": {
      const Locale("de", "DE"): "Setze die Dringlichkeit",
      const Locale("fr", "FR"): "Définir une importance",
    },
    "Importance": {
      const Locale("de", "DE"): "Dringlichkeit",
      const Locale("fr", "FR"): "Importance",
    },
    "Todo Content": {
      const Locale("de", "DE"): "Todo Inhalt",
      const Locale("fr", "FR"): "Contenu de la tâche",
    },
    "Edit Todo": {
      const Locale("de", "DE"): "Todo Bearbeiten",
      const Locale("fr", "FR"): "Modifier la tâche",
    },
    "Edit Content": {
      const Locale("de", "DE"): "Inhalt bearbeiten",
      const Locale("fr", "FR"): "Modifier le contenu"
    },
    "Light": {
      const Locale("de", "DE"): "Hell",
      const Locale("fr", "FR"): "Léger",
    },
    "Dark": {
      const Locale("de", "DE"): "Dunkel",
      const Locale("fr", "FR"): "Sombre",
    },
    "Search something...": {
      const Locale("de", "DE"): "Suche etwas...",
      const Locale("fr", "FR"): "Rechercher quelque chose...",
    },
    "You don't have any Todos": {
      const Locale("de", "DE"): "Du hast keine Todos",
      const Locale("fr", "FR"): "Vous n'avez pas de Todos",
    },
    "Add one": {
      const Locale("de", "DE"): "Eines hinzufügen",
      const Locale("fr", "FR"): "Ajoute un",
    },
    "Checked Todos": {
      const Locale("de", "DE"): "Erledigte Todos",
      const Locale("fr", "FR"): "Tâches cochées",
    },
    "Show Checked Todos": {
      const Locale("de", "DE"): "Erledigte Todos anzeigen",
      const Locale("fr", "FR"): "Afficher les tâches cochées",
    },
    "None of your Todos are checked": {
      const Locale("de", "DE"): "Keines deiner Todos ist erledigt",
      const Locale("fr", "FR"): "Aucune de vos tâches n'est cochée",
    },
    "Title:": {
      const Locale("de", "DE"): "Titel:",
      const Locale("fr", "FR"): "Titre:",
    },
    "Content:": {
      const Locale("de", "DE"): "Inhalt:",
      const Locale("fr", "FR"): "Contenu:",
    },
    "Checked:": {
      const Locale("de", "DE"): "Erledigt:",
      const Locale("fr", "FR"): "Vérifié:",
    },
    "Checked": {
      const Locale("de", "DE"): "Erledigt",
      const Locale("fr", "FR"): "Vérifié",
    },
    "Not yet": {
      const Locale("de", "DE"): "Noch nicht",
      const Locale("fr", "FR"): "Pas encore",
    },
    "About": {
      const Locale("de", "DE"): "Über",
      const Locale("fr", "FR"): "Sur",
    },
    "Everything about the App": {
      const Locale("de", "DE"): "Alles über die App",
      const Locale("fr", "FR"): "Tout sur l'application",
    },
    "Active": {
      const Locale("de", "DE"): "Aktiv",
      const Locale("fr", "FR"): "Actif",
    },
    "Inactive": {
      const Locale("de", "DE"): "Inaktiv",
    },
    "Delete Todo": {
      const Locale("de", "DE"): "Todo löschen",
      const Locale("fr", "FR"): "Inactif",
    },
    "French": {
      const Locale("de", "DE"): "Französisch",
      const Locale("fr", "FR"): "français",
    }
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
