library main;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/logic/translate.dart';
import 'package:todo/models/search_results.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/screens/add_todo_screen.dart';
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
  static const double appVersion = 1.0;
  static const String appVersionString = "1.0.0";

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
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
            Homescreen.routeName: (context) => const Homescreen(),
            SettingsMainScreen.routeName: (context) =>
                const SettingsMainScreen(),
            AddTodoScreen.routeName: (context) => const AddTodoScreen(),
            SearchScreen.routeName: (context) => const SearchScreen(),
            TodoApp.routeName: (context) => const TodoApp(),
            CheckedTodosScreen.routeName: (context) =>
                const CheckedTodosScreen(),
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
