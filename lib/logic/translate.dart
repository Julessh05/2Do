library logic;

import 'dart:collection';

import 'package:flutter/material.dart';

/// Holds everything needed to translate stuff
class Translation {
  /// The supported Locales
  static final supportedLocales = {
    _english,
    _german,
    _french,
  };

  // English Language
  static const _english = Locale("en", "US");

  // German Language
  static const _german = Locale("de", "DE");

  // French Language
  static const _french = Locale("fr", "FR");

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
      _german: "2Do",
      _french: "2Do",
    },
    "Open Settings": {
      _german: "Einstellungen öffnen",
      _french: "Ouvrir les paramètres"
    },
    "Search": {
      _german: "Suchen",
      _french: "Chercher",
    },
    "Settings": {
      _german: "Einstellungen",
      _french: "Réglages",
    },
    "Choose your Language": {
      _german: "Wähle deine Sprache",
      _french: "Choisissez votre langue"
    },
    "English": {
      _german: "Englisch",
      _french: "Anglais",
    },
    "German": {
      _german: "Deutsch",
      _french: "Allemand",
    },
    "Title": {
      _german: "Titel",
      _french: "Titre",
    },
    "Todo Title": {
      _german: "Todo Titel",
      _french: "Titre de la tâche",
    },
    "Todo Time": {
      _german: "Todo Zeit",
      _french: "Temps de travail",
    },
    "Unknown Page": {
      _german: "Unbekannte Seite",
      _french: "page inconnue",
    },
    "Something went wrong while navigating to the page you wanted to see": {
      _german:
          "Etwas ist schiefgegangen während wir versuchten diese Seite zu finden",
      _french:
          "Une erreur s'est produite lors de la navigation vers la page que vous vouliez voir",
    },
    "Back to the Homescreen": {
      _german: "Zurück zum Startbildschirm",
      _french: "Retour à l'écran d'accueil"
    },
    "Name of the Setting": {
      _german: "Name der Einstellung",
      _french: "Nom du paramètre"
    },
    "Value of the Setting": {
      _german: "Wert der Einstellung",
      _french: "Valeur du paramètre"
    },
    "Value of the Info": {
      _german: "Wert der Info",
      _french: "Valeur de l'info"
    },
    "Choose your Theme Mode": {
      _german: "Wähle dein Farbthema",
      _french: "Choisissez votre mode thématique"
    },
    "Add Todo": {
      _german: "Todo hinzufügen",
      _french: "Ajouter une tâche",
    },
    "Set a Date": {
      _german: "Setze das Datum",
      _french: "Choisir une date",
    },
    "Date": {
      _german: "Datum",
      _french: "Date",
    },
    "Set a Time": {
      _german: "Setze die Zeit",
      _french: "Définir une heure",
    },
    "Time": {
      _german: "Zeit",
      _french: "Temps",
    },
    "Cancel": {
      _german: "Abbrechen",
      _french: "Annuler",
    },
    "Confirm": {
      _german: "Bestätigen",
      _french: "Confirmer",
    },
    "Insert Title": {
      _german: "Titel einfügen",
      _french: "Insérer un titre",
    },
    "Insert Content": {
      _german: "Inhalt einfügen",
      _french: "Insérer du contenu",
    },
    "is missing": {
      _german: "fehlt",
      _french: "est manquant",
    },
    "Some Values missing": {
      _german: "Einige Informationen fehlen",
      _french: "Certaines valeurs manquent",
    },
    "The following Value is missing:": {
      _german: "Die folgende Information fehlt:",
      _french: "La valeur suivante est manquante:",
    },
    "The following Values are missing:": {
      _german: "Die folgenden Informationen fehlen:",
      _french: "Les valeurs suivantes sont manquantes:",
    },
    "OK": {
      _german: "OK",
      _french: "d'accord",
    },
    "Edit Title": {
      _german: "Titel bearbeiten",
      _french: "Modifier le titre",
    },
    "Edit": {
      _german: "Bearbeiten",
      _french: "Éditer",
    },
    "Language": {
      _german: "Sprache",
      _french: "Langue",
    },
    "Thememode": {
      _german: "Helligkeitsmodus",
      _french: "Mode thématique",
    },
    "Notifications": {
      _german: "Benachrichtigungen",
      _french: "Avis",
    },
    "Search Results": {
      _german: "Suchergebnisse",
      _french: "Résultats de recherche",
    },
    "No Results": {
      _german: "Keine Ergebnisse",
      _french: "Aucun résultat",
    },
    "No Results were found": {
      _german: "Es wurden keine Ergebnisse gefunden",
      _french: "Aucun resultat n'a été trouvé",
    },
    "Todo": {
      _german: "Todo",
      _french: "À faire",
    },
    "Setting": {
      _german: "Einstellung",
      _french: "Réglage",
    },
    "Choose an Standard Importance": {
      _german: "Wähle die Standard Dringlichkeit",
      _french: "Choisissez une importance standard",
    },
    "Set an Importance": {
      _german: "Setze die Dringlichkeit",
      _french: "Définir une importance",
    },
    "Importance": {
      _german: "Dringlichkeit",
      _french: "Importance",
    },
    "Todo Content": {
      _german: "Todo Inhalt",
      _french: "Contenu de la tâche",
    },
    "Edit Todo": {
      _german: "Todo Bearbeiten",
      _french: "Modifier la tâche",
    },
    "Edit Content": {
      _german: "Inhalt bearbeiten",
      _french: "Modifier le contenu"
    },
    "Light": {
      _german: "Hell",
      _french: "Léger",
    },
    "Dark": {
      _german: "Dunkel",
      _french: "Sombre",
    },
    "Search something...": {
      _german: "Suche etwas...",
      _french: "Rechercher quelque chose...",
    },
    "You don't have any Todos": {
      _german: "Du hast keine Todos",
      _french: "Vous n'avez pas de Todos",
    },
    "Add one": {
      _german: "Eines hinzufügen",
      _french: "Ajoute un",
    },
    "Checked Todos": {
      _german: "Erledigte Todos",
      _french: "Tâches cochées",
    },
    "Show Checked Todos": {
      _german: "Erledigte Todos anzeigen",
      _french: "Afficher les tâches cochées",
    },
    "None of your Todos are checked": {
      _german: "Keines deiner Todos ist erledigt",
      _french: "Aucune de vos tâches n'est cochée",
    },
    "Title:": {
      _german: "Titel:",
      _french: "Titre:",
    },
    "Content:": {
      _german: "Inhalt:",
      _french: "Contenu:",
    },
    "Checked:": {
      _german: "Erledigt:",
      _french: "Vérifié:",
    },
    "Checked": {
      _german: "Erledigt",
      _french: "Vérifié",
    },
    "Not yet": {
      _german: "Noch nicht",
      _french: "Pas encore",
    },
    "About": {
      _german: "Über",
      _french: "Sur",
    },
    "Everything about the App": {
      _german: "Alles über die App",
      _french: "Tout sur l'application",
    },
    "Active": {
      _german: "Aktiv",
      _french: "Actif",
    },
    "Inactive": {
      _german: "Inaktiv",
      _french: "Inactif",
    },
    "Delete Todo": {
      _german: "Todo löschen",
      _french: "Supprimer la tâche",
    },
    "French": {
      _german: "Französisch",
      _french: "français",
    },
    "Choose a Color": {
      _german: "Wähle eine Farbe",
      _french: "Choisir une couleur",
    },
    "Color": {
      _german: "Farbe",
      _french: "Couleur",
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
