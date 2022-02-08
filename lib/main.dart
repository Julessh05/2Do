import 'package:flutter/material.dart';
import 'package:todo/logic/translate.dart';
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
      color: ,
    );

    return _app;
  }
}
