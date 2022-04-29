library main;

import 'dart:async' show StreamController;

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart'
    show
        GlobalCupertinoLocalizations,
        GlobalMaterialLocalizations,
        GlobalWidgetsLocalizations;
import 'package:hive_flutter/hive_flutter.dart' show Hive, HiveX;
import 'package:string_translate/string_translate.dart' show Translation;
import 'package:todo/app_values/translated_strings.dart';
import 'package:todo/models/brainstorm_note.dart' show BrainstormNote;
import 'package:todo/models/search_results.dart' show SearchResultsList;
import 'package:todo/models/todo.dart' show Todo;
import 'package:todo/screens/add_brainstorm_note_screen.dart';
import 'package:todo/screens/add_todo_screen.dart';
import 'package:todo/screens/brainstorm_screen.dart';
import 'package:todo/screens/color_chooser.dart';
import 'package:todo/screens/edit_note_screen.dart';
import 'package:todo/screens/homescreen.dart';
import 'package:todo/screens/notes_details_screen.dart';
import 'package:todo/screens/search_screen.dart';
import 'package:todo/screens/settings_screens.dart';
import 'package:todo/screens/todo_detail_screen.dart';
import 'package:todo/screens/unknown_page.dart';
import 'package:todo/storage/storage.dart';
import 'package:todo/styles/themes.dart';

void main() async {
  await Hive.initFlutter();
  await Storage.init();
  Storage.loadTodos();
  Storage.loadBrainstormNotes();
  runApp(const TodoApp());
}

class TodoApp extends StatefulWidget {
  const TodoApp({Key? key}) : super(key: key);

  static const routeName = 'main';
  static final themeStream = StreamController<ThemeMode>();

  // This double App Version only has one digit after the .
  // So it just represents major and minor features.
  // Bugfixes are only seen in the app Version as String
  static const double appVersion = 2.0;
  static const String appVersionString = '2.0.1';

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  @override
  void initState() {
    Storage.loadSettings(context);
    // Init Translations Pacakge
    Translation.init(
      supportedLocales: TranslatedStrings.supportedLocales,
      defaultLocale: TranslatedStrings.supportedLocales.first,
      translations: TranslatedStrings.translations,
    );
    super.initState();
  }

  @override
  void dispose() {
    TodoApp.themeStream.close();
    super.dispose();
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
          title: '2Do App',

          /* Locale Section */
          localizationsDelegates: const <LocalizationsDelegate>[
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
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

            // Brainstorm Screen
            BrainstormScreen.routeName: (context) => const BrainstormScreen(),

            // Add Brainstorm Note Screen
            AddBrainstormNoteScreen.routeName: (context) =>
                const AddBrainstormNoteScreen(),

            // Settings Main Screen
            SettingsMainScreen.routeName: (context) =>
                const SettingsMainScreen(),

            // Add Todo Screen
            AddTodoScreen.routeName: (context) => const AddTodoScreen(),

            // Search Screen
            SearchScreen.routeName: (context) => const SearchScreen(),

            // Main Screen
            TodoApp.routeName: (context) => const TodoApp(),

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

              // Notes Details Screen
            } else if (settings.name == NotesDetailsScreen.routeName) {
              final _note = settings.arguments as BrainstormNote;

              return MaterialPageRoute(builder: (_) {
                return NotesDetailsScreen(note: _note);
              });

              // Edit Note Screen
            } else if (settings.name == EditNoteScreen.routeName) {
              final _note = settings.arguments as BrainstormNote;

              return MaterialPageRoute(builder: (_) {
                return EditNoteScreen(note: _note);
              });
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
            String _title = '2Do App';
            return _title;
          },
        );
      },
    );

    return _app;
  }
}
