library main;

import 'dart:async' show StreamController;

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart'
    show
        GlobalCupertinoLocalizations,
        GlobalMaterialLocalizations,
        GlobalWidgetsLocalizations;
import 'package:hive_flutter/hive_flutter.dart' show Hive, HiveX;
import 'package:string_translate/string_translate.dart'
    show Translate, Translation;
import 'package:todo/app_values/translated_strings.dart';
import 'package:todo/models/brainstorm_note.dart' show BrainstormNote;
import 'package:todo/models/search_results.dart' show SearchResultsList;
import 'package:todo/models/todo.dart' show Todo;
import 'package:todo/screens/add_brainstorm_note_screen.dart';
import 'package:todo/screens/add_tag_screen.dart';
import 'package:todo/screens/add_todo_screen.dart';
import 'package:todo/screens/brainstorm_screen.dart';
import 'package:todo/screens/color_chooser.dart';
import 'package:todo/screens/edit_note_screen.dart';
import 'package:todo/screens/edit_todo_screen.dart';
import 'package:todo/screens/homescreen.dart';
import 'package:todo/screens/notes_details_screen.dart';
import 'package:todo/screens/search_screen.dart';
import 'package:todo/screens/settings_screens.dart';
import 'package:todo/screens/todo_detail_screen.dart';
import 'package:todo/screens/unknown_page.dart';
import 'package:todo/storage/storage.dart';
import 'package:todo/styles/coloring.dart' show Coloring;
import 'package:todo/styles/themes.dart';

void main() async {
  // Init Hive Store Package
  await Hive.initFlutter();
  // Init Storage Class
  await Storage.init();
  // Load Data
  Storage.loadTodos();
  Storage.loadBrainstormNotes();
  // Start the App
  runApp(const TodoApp());
}

/// The Main Class in which the Main State and
/// the initial Material App is created
class TodoApp extends StatefulWidget {
  const TodoApp({Key? key}) : super(key: key);

  /// The Name of the Route for this Screen.
  /// Is used to navigate trough the App.
  /// These Values are set in the [MaterialApp] of the [TodoApp]
  static const routeName = 'main';

  /// The Stream that controlls the ThemeMode
  static final themeStream = StreamController<ThemeMode>();

  // This double App Version only has one digit after the .
  // So it just represents major and minor features.
  // Bugfixes are only seen in the app Version as String
  static const double appVersion = 2.1;
  static const String appVersionString = '2.1.0';

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  @override
  void initState() {
    // Load Settings is done here, because it needs a BuildContext
    Storage.loadSettings(context);
    // Init Translations Package
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
    /// This String is used as App Title, Global App Key
    /// and restorationScopeId for Widget restauration
    const String _title = '2Do App';

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

          // Keys / IDs
          scaffoldMessengerKey: GlobalKey<ScaffoldMessengerState>(
            debugLabel: 'Scaffold_Messenger_KEY',
          ),
          navigatorKey: GlobalKey(debugLabel: 'Navigator_KEY'),
          key: const GlobalObjectKey(_title),
          restorationScopeId: _title,

          // Title Section
          title: _title,
          onGenerateTitle: (_) {
            // Returns the Title of the App
            // Can be used to returns localized Titles
            return _title.tr();
          },

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
          color: Coloring.mainColor,

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

            // Add Tag
            AddTagScreen.routeName: (context) => const AddTagScreen(),
          },

          // On Generate Routes
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
                return MaterialPageRoute(
                  builder: (_) {
                    return const SearchResultScreen.noResults();
                  },
                );
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

              return MaterialPageRoute(
                builder: (_) {
                  return NotesDetailsScreen(note: _note);
                },
              );

              // Edit Note Screen
            } else if (settings.name == EditNoteScreen.routeName) {
              final _note = settings.arguments as BrainstormNote;

              return MaterialPageRoute(
                builder: (_) {
                  return EditNoteScreen(note: _note);
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
        );
      },
    );

    return _app;
  }
}
