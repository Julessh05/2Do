library main;

import 'package:flutter/material.dart';
import 'package:todo/logic/translate.dart';
import 'package:todo/models/search_results.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/screens/add_todo_screen.dart';
import 'package:todo/screens/homescreen.dart';
import 'package:todo/screens/search_screen.dart';
import 'package:todo/screens/settings_screens.dart';
import 'package:todo/screens/todo_detail_screen.dart';
import 'package:todo/screens/unknow_page.dart';
import 'package:todo/styles/themes.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _app = MaterialApp(
      /* Developer Section */
      showSemanticsDebugger: false,
      showPerformanceOverlay: false,
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: true,
      checkerboardOffscreenLayers: false,
      checkerboardRasterCacheImages: false,

      /* App Section */
      title: "2Do App",
      supportedLocales: Translation.supportedLocales,
      locale: Translation.activeLocale,
      useInheritedMediaQuery: false,
      scrollBehavior: const MaterialScrollBehavior(),

      /* Theme Section */
      themeMode: Themes.themeMode,
      theme: Themes.lightTheme,
      darkTheme: Themes.darkTheme,
      highContrastTheme: Themes.highContrastLightTheme,
      highContrastDarkTheme: Themes.highContrastDarkTheme,

      /* Routes Section */
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        Homescreen.routeName: (context) => const Homescreen(),
        SettingsMainScreen.routeName: (context) => const SettingsMainScreen(),
        AddTodoScreen.routeName: (context) => const AddTodoScreen(),
        SearchScreen.routeName: (context) => const SearchScreen(),
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
          final _arguments = settings.arguments as SettingsSubScreenArguments;

          return MaterialPageRoute(
            builder: (_) {
              return SettingsSubScreen(arguments: _arguments);
            },
          );

          // Search Results Screen
        } else if (settings.name == SearchResultScreen.routeName) {
          final _searchResults = settings.arguments as SearchResultsList;

          if (_searchResults.hasResults) {
            return MaterialPageRoute(
              builder: (_) {
                return SearchResultScreen(searchResultsList: _searchResults);
              },
            );
          } else {
            return MaterialPageRoute(builder: (_) {
              return const SearchResultScreen.noResults();
            });
          }
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
      key: const GlobalObjectKey("2Do App"),
      onGenerateTitle: (_) {
        // Returns the Title of the App
        // Can be used to returns localized Titles
        String _title = "2Do App";
        return _title;
      },
    );

    return _app;
  }
}
