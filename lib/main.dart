library main;

import 'package:flutter/material.dart';
import 'package:todo/logic/translate.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/screens/add_todo_screen.dart';
import 'package:todo/screens/homescreen.dart';
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
      themeMode: Themes.themeMode,
      theme: Themes.lightTheme,
      darkTheme: Themes.darkTheme,
      highContrastTheme: Themes.highContrastLightTheme,
      highContrastDarkTheme: Themes.highContrastDarkTheme,
      useInheritedMediaQuery: false,
      scrollBehavior: const MaterialScrollBehavior(),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        Homescreen.routeName: (context) => const Homescreen(),
        SettingsMainScreen.routeName: (context) => const SettingsMainScreen(),
        AddTodoScreen.routeName: (context) => const AddTodoScreen(),
      },
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name == TodoDetailScreen.routeName) {
          final _todo = settings.arguments as Todo;

          return MaterialPageRoute(
            builder: (_) {
              return TodoDetailScreen(todo: _todo);
            },
          );
        } else {}
        return null;
      },
      onUnknownRoute: (_) {
        return MaterialPageRoute(
          builder: (_) {
            return const UnknownPage();
          },
        );
      },
      key: const GlobalObjectKey("2Do App"),
      onGenerateTitle: (_) {
        String _title = "2Do App";
        return _title;
      },
    );

    return _app;
  }
}
