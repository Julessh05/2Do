library main;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:string_translate/string_translate.dart';
import 'package:todo/app_values/translated_strings.dart';
import 'package:todo/models/search_results.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/screens/add_todo_screen.dart';
import 'package:todo/screens/color_chooser.dart';
import 'package:todo/screens/homescreen.dart';
import 'package:todo/screens/search_screen.dart';
import 'package:todo/screens/settings_screens.dart';
import 'package:todo/screens/todo_detail_screen.dart';
import 'package:todo/screens/unknown_page.dart';
import 'package:todo/storage/storage.dart';
import 'package:todo/styles/themes.dart';

void main() async {
  await Hive.initFlutter();
  await Storage.init();
  Storage.loadSettings();
  Storage.loadTodos();
  runApp(const TodoApp());
}

class TodoApp extends StatefulWidget {
  const TodoApp({Key? key}) : super(key: key);

  static const routeName = "main";
  static final themeStream = StreamController<ThemeMode>();

  // This double App Version only has one digit after the .
  // So it just represents major and minor features.
  // Bugfixes are only seen in the app Version as String
  static const double appVersion = 1.1;
  static const String appVersionString = "1.1.3";

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  @override
  void initState() {
    /// The supported Locales
    final supportedLocales = <Locale>{
      TranslationLocales.english,
      TranslationLocales.german,
      TranslationLocales.french,
    };

    // Empty Translations Map
    final Map<String, Map<Locale, String>> _translations = {};

    // add Values
    _translations.addAll(TranslatedStrings.translationsMap);
    _translations.addAll(StandardTranslations.actions);
    _translations.addAll(StandardTranslations.error);

    // Init Translations Pacakge
    Translation.init(
      supportedLocales: supportedLocales,
      defaultLocale: TranslationLocales.english,
      translations: _translations,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _app = StreamBuilder(
      initialData: Themes.themeMode,
      stream: TodoApp.themeStream.stream,
      builder: (_, AsyncSnapshot snapshot) {
        return MaterialApp(
          /* Developer Section */
          showSemanticsDebugger: false,
          showPerformanceOverlay: false,
          debugShowMaterialGrid: false,
          debugShowCheckedModeBanner: true,
          checkerboardOffscreenLayers: false,
          checkerboardRasterCacheImages: false,
          /* App Section */
          title: "2Do App",

          /* Locale Section */
          localizationsDelegates: const <LocalizationsDelegate>[
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          /* localeListResolutionCallback: (_, __) {
            final localeName = Platform.localeName;
            if (localeName == "de_DE") {
              Translation.activeLocale = const Locale("de", "DE");
            } else if(localeName == "fr_FR") {
              Translation.activeLocale = const Locale("fr", "FR");
            } else {
              Translation.activeLocale = const Locale("en", "US");
            }
            return Translation.activeLocale;
          }, */
          supportedLocales: Translation.supportedLocales,
          useInheritedMediaQuery: false,
          scrollBehavior: const MaterialScrollBehavior(),

          /* Theme Section */
          themeMode: snapshot.data,
          theme: Themes.lightTheme,
          darkTheme: Themes.darkTheme,
          highContrastTheme: Themes.highContrastLightTheme,
          highContrastDarkTheme: Themes.highContrastDarkTheme,

          /* Routes Section */
          initialRoute: '/',
          routes: <String, WidgetBuilder>{
            // Homescreen
            Homescreen.routeName: (context) => const Homescreen(),

            // Settings Main Screen
            SettingsMainScreen.routeName: (context) =>
                const SettingsMainScreen(),

            // Add Todo Screen
            AddTodoScreen.routeName: (context) => const AddTodoScreen(),

            // Search Screen
            SearchScreen.routeName: (context) => const SearchScreen(),

            // Main Screen
            TodoApp.routeName: (context) => const TodoApp(),

            // Checked Todo Screen
            CheckedTodosScreen.routeName: (context) =>
                const CheckedTodosScreen(),

            // Color Chooser
            ColorChooser.routeName: (context) => const ColorChooser(),
          },
          onGenerateRoute: (RouteSettings settings) {
            // Todo Details Screen
            if (settings.name == TodoDetailScreen.routeName) {
              final _todo = settings.arguments as Todo;

              return MaterialPageRoute(
                builder: (_) {
                  return TodoDetailScreen(todo: _todo);
                },
              );

              // Settings Sub Screen
            } else if (settings.name == SettingsSubScreen.routeName) {
              final _arguments =
                  settings.arguments as SettingsSubScreenArguments;

              return MaterialPageRoute(
                builder: (_) {
                  return SettingsSubScreen(arguments: _arguments);
                },
              );

              // Search Results Screen
            } else if (settings.name == SearchResultScreen.routeName) {
              final _searchResults = settings.arguments as SearchResultsList;

              if (_searchResults.hasResults) {
                // Results Page
                return MaterialPageRoute(
                  builder: (_) {
                    return SearchResultScreen(
                        searchResultsList: _searchResults);
                  },
                );
              } else {
                // No Results Page
                return MaterialPageRoute(builder: (_) {
                  return const SearchResultScreen.noResults();
                });
              }

              // Edit Todo Screen
            } else if (settings.name == EditTodoScreen.routeName) {
              final _todo = settings.arguments as Todo;

              return MaterialPageRoute(
                builder: (_) {
                  return EditTodoScreen(todo: _todo);
                },
              );

              // Sub Color Screen
            } else if (settings.name == SubColorChooser.routeName) {
              final _color = settings.arguments as Color;

              return MaterialPageRoute(
                builder: (_) {
                  return SubColorChooser(color: _color);
                },
              );
            } else {
              // Do nothing
            }

            // null because nothing should be done
            return null;
          },
          onUnknownRoute: (_) {
            // If Route is unknown navigate to the UnknownPage()
            // This is a Page that says, Page not found
            return MaterialPageRoute(
              builder: (_) {
                return const UnknownPage();
              },
            );
          },
          onGenerateTitle: (_) {
            // Returns the Title of the App
            // Can be used to returns localized Titles
            String _title = "2Do App";
            return _title;
          },
        );
      },
    );

    return _app;
  }
}
