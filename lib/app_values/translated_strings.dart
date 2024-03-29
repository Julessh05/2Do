library app_values;

import 'dart:ui' show Locale;

import 'package:string_translate/string_translate.dart'
    show TranslationLocales, StandardTranslations;

class TranslatedStrings {
  /// The Locales that are supported in this App
  static final supportedLocales = {
    TranslationLocales.english,
    TranslationLocales.german,
    TranslationLocales.french,
  };

  /// The Translations as a Map
  /// Pattern:
  /// ```dart
  /// 'Value in English': {
  ///   const Locale('language Code', 'country Code'): 'Value'
  ///   const Locale('language Code', 'country Code'): 'Value'
  /// }
  /// ```
  static final _translationsMap = <String, Map<Locale, String>>{
    '2Do': {
      TranslationLocales.german: '2Do',
      TranslationLocales.french: '2Do',
    },
    'Open Settings': {
      TranslationLocales.german: 'Einstellungen öffnen',
      TranslationLocales.french: 'Ouvrir les paramètres'
    },
    'Search': {
      TranslationLocales.german: 'Suchen',
      TranslationLocales.french: 'Chercher',
    },
    'Settings': {
      TranslationLocales.german: 'Einstellungen',
      TranslationLocales.french: 'Réglages',
    },
    'Choose your Language': {
      TranslationLocales.german: 'Wähle deine Sprache',
      TranslationLocales.french: 'Choisissez votre langue'
    },
    'English': {
      TranslationLocales.german: 'Englisch',
      TranslationLocales.french: 'Anglais',
    },
    'German': {
      TranslationLocales.german: 'Deutsch',
      TranslationLocales.french: 'Allemand',
    },
    'Title': {
      TranslationLocales.german: 'Titel',
      TranslationLocales.french: 'Titre',
    },
    'Todo Title': {
      TranslationLocales.german: 'Todo Titel',
      TranslationLocales.french: 'Titre de la tâche',
    },
    'Todo Time': {
      TranslationLocales.german: 'Todo Zeit',
      TranslationLocales.french: 'Temps de travail',
    },
    'Unknown Page': {
      TranslationLocales.german: 'Unbekannte Seite',
      TranslationLocales.french: 'page inconnue',
    },
    'Something went wrong while navigating to the page you wanted to see': {
      TranslationLocales.german:
          'Etwas ist schiefgegangen während wir versuchten diese Seite zu finden',
      TranslationLocales.french:
          'Une erreur s\'est produite lors de la navigation vers la page que vous vouliez voir',
    },
    'Back to the Homescreen': {
      TranslationLocales.german: 'Zurück zum Startbildschirm',
      TranslationLocales.french: 'Retour à l\'écran d\'accueil'
    },
    'Name of the Setting': {
      TranslationLocales.german: 'Name der Einstellung',
      TranslationLocales.french: 'Nom du paramètre'
    },
    'Value of the Setting': {
      TranslationLocales.german: 'Wert der Einstellung',
      TranslationLocales.french: 'Valeur du paramètre'
    },
    'Value of the Info': {
      TranslationLocales.german: 'Wert der Info',
      TranslationLocales.french: 'Valeur de l\'info'
    },
    'Choose your Theme Mode': {
      TranslationLocales.german: 'Wähle dein Farbthema',
      TranslationLocales.french: 'Choisissez votre mode thématique'
    },
    'Add Todo': {
      TranslationLocales.german: 'Todo hinzufügen',
      TranslationLocales.french: 'Ajouter une tâche',
    },
    'Set a Date': {
      TranslationLocales.german: 'Setze das Datum',
      TranslationLocales.french: 'Choisir une date',
    },
    'Date': {
      TranslationLocales.german: 'Datum',
      TranslationLocales.french: 'Date',
    },
    'Set a Time': {
      TranslationLocales.german: 'Setze die Zeit',
      TranslationLocales.french: 'Définir une heure',
    },
    'Time': {
      TranslationLocales.german: 'Zeit',
      TranslationLocales.french: 'Temps',
    },
    'Confirm': {
      TranslationLocales.german: 'Bestätigen',
      TranslationLocales.french: 'Confirmer',
    },
    'Insert Title': {
      TranslationLocales.german: 'Titel einfügen',
      TranslationLocales.french: 'Insérer un titre',
    },
    'Insert Content': {
      TranslationLocales.german: 'Inhalt einfügen',
      TranslationLocales.french: 'Insérer du contenu',
    },
    'is missing': {
      TranslationLocales.german: 'fehlt',
      TranslationLocales.french: 'est manquant',
    },
    'Some Values missing': {
      TranslationLocales.german: 'Einige Informationen fehlen',
      TranslationLocales.french: 'Certaines valeurs manquent',
    },
    'The following Value is missing:': {
      TranslationLocales.german: 'Die folgende Information fehlt:',
      TranslationLocales.french: 'La valeur suivante est manquante:',
    },
    'The following Values are missing:': {
      TranslationLocales.german: 'Die folgenden Informationen fehlen:',
      TranslationLocales.french: 'Les valeurs suivantes sont manquantes:',
    },
    'OK': {
      TranslationLocales.german: 'OK',
      TranslationLocales.french: 'd\'accord',
    },
    'Edit Title': {
      TranslationLocales.german: 'Titel bearbeiten',
      TranslationLocales.french: 'Modifier le titre',
    },
    'Edit': {
      TranslationLocales.german: 'Bearbeiten',
      TranslationLocales.french: 'Éditer',
    },
    'Language': {
      TranslationLocales.german: 'Sprache',
      TranslationLocales.french: 'Langue',
    },
    'Thememode': {
      TranslationLocales.german: 'Helligkeitsmodus',
      TranslationLocales.french: 'Mode thématique',
    },
    'Notifications': {
      TranslationLocales.german: 'Benachrichtigungen',
      TranslationLocales.french: 'Avis',
    },
    'Search Results': {
      TranslationLocales.german: 'Suchergebnisse',
      TranslationLocales.french: 'Résultats de recherche',
    },
    'No Results': {
      TranslationLocales.german: 'Keine Ergebnisse',
      TranslationLocales.french: 'Aucun résultat',
    },
    'No Results were found': {
      TranslationLocales.german: 'Es wurden keine Ergebnisse gefunden',
      TranslationLocales.french: 'Aucun resultat n\'a été trouvé',
    },
    'Todo': {
      TranslationLocales.german: 'Todo',
      TranslationLocales.french: 'À faire',
    },
    'Setting': {
      TranslationLocales.german: 'Einstellung',
      TranslationLocales.french: 'Réglage',
    },
    'Choose an Standard Importance': {
      TranslationLocales.german: 'Wähle die Standard Dringlichkeit',
      TranslationLocales.french: 'Choisissez une importance standard',
    },
    'Set an Importance': {
      TranslationLocales.german: 'Setze die Dringlichkeit',
      TranslationLocales.french: 'Définir une importance',
    },
    'Importance': {
      TranslationLocales.german: 'Dringlichkeit',
      TranslationLocales.french: 'Importance',
    },
    'Todo Content': {
      TranslationLocales.german: 'Todo Inhalt',
      TranslationLocales.french: 'Contenu de la tâche',
    },
    'Edit Todo': {
      TranslationLocales.german: 'Todo Bearbeiten',
      TranslationLocales.french: 'Modifier la tâche',
    },
    'Edit Content': {
      TranslationLocales.german: 'Inhalt bearbeiten',
      TranslationLocales.french: 'Modifier le contenu'
    },
    'Light': {
      TranslationLocales.german: 'Hell',
      TranslationLocales.french: 'Léger',
    },
    'Dark': {
      TranslationLocales.german: 'Dunkel',
      TranslationLocales.french: 'Sombre',
    },
    'Search something...': {
      TranslationLocales.german: 'Suche etwas...',
      TranslationLocales.french: 'Rechercher quelque chose...',
    },
    'You don\'t have any Todos': {
      TranslationLocales.german: 'Du hast keine Todos',
      TranslationLocales.french: 'Vous n\'avez pas de Todos',
    },
    'You don\'t have any Notes': {
      TranslationLocales.german: 'Du hast keine Notizen',
      TranslationLocales.french: 'Vous n\'avez pas de Remarques',
    },
    'Add one': {
      TranslationLocales.german: 'Neu hinzufügen',
      TranslationLocales.french: 'Ajoute un',
    },
    'Checked Todos': {
      TranslationLocales.german: 'Erledigte Todos',
      TranslationLocales.french: 'Tâches cochées',
    },
    'Checked Todos:': {
      TranslationLocales.german: 'Erledigte Todos:',
      TranslationLocales.french: 'Tâches cochées:',
    },
    'Show Checked Todos': {
      TranslationLocales.german: 'Erledigte Todos anzeigen',
      TranslationLocales.french: 'Afficher les tâches cochées',
    },
    'None of your Todos are checked': {
      TranslationLocales.german: 'Keines deiner Todos ist erledigt',
      TranslationLocales.french: 'Aucune de vos tâches n\'est cochée',
    },
    'Title:': {
      TranslationLocales.german: 'Titel:',
      TranslationLocales.french: 'Titre:',
    },
    'Content:': {
      TranslationLocales.german: 'Inhalt:',
      TranslationLocales.french: 'Contenu:',
    },
    'Checked:': {
      TranslationLocales.german: 'Erledigt:',
      TranslationLocales.french: 'Vérifié:',
    },
    'Checked': {
      TranslationLocales.german: 'Erledigt',
      TranslationLocales.french: 'Vérifié',
    },
    'Not yet': {
      TranslationLocales.german: 'Noch nicht',
      TranslationLocales.french: 'Pas encore',
    },
    'About': {
      TranslationLocales.german: 'Über',
      TranslationLocales.french: 'Sur',
    },
    'Everything about the App': {
      TranslationLocales.german: 'Alles über die App',
      TranslationLocales.french: 'Tout sur l\'application',
    },
    'Active': {
      TranslationLocales.german: 'Aktiv',
      TranslationLocales.french: 'Actif',
    },
    'Inactive': {
      TranslationLocales.german: 'Inaktiv',
      TranslationLocales.french: 'Inactif',
    },
    'Delete Todo': {
      TranslationLocales.german: 'Todo löschen',
      TranslationLocales.french: 'Supprimer la tâche',
    },
    'French': {
      TranslationLocales.german: 'Französisch',
      TranslationLocales.french: 'français',
    },
    'Choose a Color': {
      TranslationLocales.german: 'Wähle eine Farbe',
      TranslationLocales.french: 'Choisir une couleur',
    },
    'Color': {
      TranslationLocales.german: 'Farbe',
      TranslationLocales.french: 'Couleur',
    },
    'Brainstorm': {
      TranslationLocales.german: 'Brainstorm',
      TranslationLocales.french: 'Brainstorm',
    },
    'Add Brainstorm Todo': {
      TranslationLocales.german: 'Brainstorm Todo hinzufügen',
      TranslationLocales.french: 'Ajouter une tâche de Brainstorm',
    },
    'Checked Notes:': {
      TranslationLocales.german: 'Erledigte Notizen:',
      TranslationLocales.french: 'Billets cochés',
    },
    'Edit Note': {
      TranslationLocales.german: 'Notiz bearbeiten',
      TranslationLocales.french: 'Note éditée',
    },
    'Add Note': {
      TranslationLocales.german: 'Notiz hinzufügen',
      TranslationLocales.french: 'Ajouter une note',
    },
    'Customize your Brainstorm Settings': {
      TranslationLocales.german: 'Passe deine Brainstorms Einstellungen an',
      TranslationLocales.french: 'Personnalisez vos paramètres de Brainstorm',
    },
    'Flying Mode': {
      TranslationLocales.german: 'Flying Modus',
      TranslationLocales.french: 'Mode Flying',
    },
    'All': {
      TranslationLocales.german: 'Alle',
      TranslationLocales.french: 'Toute',
    },
    'Add Tag': {
      TranslationLocales.german: 'Tag hinzufügen',
      TranslationLocales.french: 'Ajouter une étiquette',
    },
    'Active Tags:': {
      TranslationLocales.german: 'Aktive Tags:',
      TranslationLocales.french: 'Balises actives',
    },
    'Insert Tag': {
      TranslationLocales.german: 'Tag einfügen',
      TranslationLocales.french: 'Insérer une balise',
    },
    'A Tag can\'t contains a Comma': {
      TranslationLocales.german: 'Ein Tag kann keine Kommas enthalten',
      TranslationLocales.french: 'Une balise ne peut pas contenir de virgule',
    },
    'Tags:': {
      TranslationLocales.german: 'Kategorien',
      TranslationLocales.french: 'Mots clés',
    },
    'Tag': {
      TranslationLocales.german: 'Kategorie',
      TranslationLocales.french: 'Étiqueter',
    },
    '2Do App': {
      TranslationLocales.german: '2Do App',
      TranslationLocales.french: '2Do App',
    },
    'All Todos': {
      TranslationLocales.german: 'Alle Todos',
      TranslationLocales.french: 'Toutes les tâches',
    },
    'Show all Todos': {
      TranslationLocales.german: 'Alle Todos anzeigen',
      TranslationLocales.french: 'Afficher toutes les tâches',
    },
    'Open Brainstorm Mode': {
      TranslationLocales.german: 'Brainstorm Modus öffnen',
      TranslationLocales.french: 'Ouvrir le mode brainstorm',
    },
    'You don\'t have any Todos with this Tag': {
      TranslationLocales.german: 'Du hast keine Todos in dieser Kategorie',
      TranslationLocales.french: 'vous n\'avez aucune tâche avec ce tag',
    },
  };

  static Map<String, Map<Locale, String>> get translations {
    // Empty Translations Map
    final Map<String, Map<Locale, String>> translations = {};

    // add Values
    translations.addAll(_translationsMap);
    translations.addAll(StandardTranslations.all);

    return translations;
  }
}
