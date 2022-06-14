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
import 'package:todo/screens/sorted_todo_screen.dart';
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

  /// The Stream to control the Theme Mode used in this App
  static final themeStream = StreamController<ThemeMode>();

  // This double App Version only has one digit after the .
  // So it just represents major and minor features.
  // Bugfixes are only seen in the app Version as String
  static const double appVersion = 2.2;
  static const String appVersionString = '2.2.0';

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
    // Call Super
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
    const String title = '2Do App';

    return StreamBuilder<ThemeMode>(
      initialData: ThemeMode.system,
      stream: TodoApp.themeStream.stream,
      builder: (context, snapshot) {
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
          key: const GlobalObjectKey(title),
          restorationScopeId: title,

          // Title Section
          title: title,
          onGenerateTitle: (_) {
            // Returns the Title of the App
            // Can be used to returns localized Titles
            return title.tr();
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
          //  then((value) => ),
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
              final todo = settings.arguments as Todo;

              return MaterialPageRoute(
                builder: (_) {
                  return TodoDetailScreen(todo: todo);
                },
              );

              // Settings Sub Screen
            } else if (settings.name == SettingsSubScreen.routeName) {
              final arguments =
                  settings.arguments as SettingsSubScreenArguments;

              return MaterialPageRoute(
                builder: (_) {
                  return SettingsSubScreen(arguments: arguments);
                },
              );

              // Search Results Screen
            } else if (settings.name == SearchResultScreen.routeName) {
              final searchResults = settings.arguments as SearchResultsList;

              if (searchResults.hasResults) {
                // Results Page
                return MaterialPageRoute(
                  builder: (_) {
                    return SearchResultScreen(searchResultsList: searchResults);
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
              final todo = settings.arguments as Todo;

              return MaterialPageRoute(
                builder: (_) {
                  return EditTodoScreen(todo: todo);
                },
              );

              // Sub Color Screen
            } else if (settings.name == SubColorChooser.routeName) {
              final color = settings.arguments as Color;

              return MaterialPageRoute(
                builder: (_) {
                  return SubColorChooser(color: color);
                },
              );

              // Notes Details Screen
            } else if (settings.name == NotesDetailsScreen.routeName) {
              final note = settings.arguments as BrainstormNote;

              return MaterialPageRoute(
                builder: (_) {
                  return NotesDetailsScreen(note: note);
                },
              );

              // Edit Note Screen
            } else if (settings.name == EditNoteScreen.routeName) {
              final note = settings.arguments as BrainstormNote;

              return MaterialPageRoute(
                builder: (_) {
                  return EditNoteScreen(note: note);
                },
              );

              // Sorted Todo Screen
            } else if (settings.name == SortedTodoScreen.routeName) {
              final tag = settings.arguments as String?;

              return MaterialPageRoute(
                builder: (_) {
                  return SortedTodoScreen(tag: tag);
                },
              );

              // Add Todo Screen
            } else if (settings.name == AddTodoScreen.routeName) {
              final tag = settings.arguments as String?;

              return MaterialPageRoute(
                builder: (_) {
                  return AddTodoScreen(
                    tag: tag,
                  );
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
  }
}
