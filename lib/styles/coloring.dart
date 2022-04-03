library styles;

import 'package:flutter/material.dart';

/// Every Color used in the App
class Coloring {
  /// Main Color used to display most elements in the App
  static Color _mainColor = Colors.blue.shade800;

  /// Accent Color used for Text for example
  static Color _accentColor = Colors.white;

  static Color get mainColor {
    return _mainColor;
  }

  static set mainColor(Color color) {
    _mainColor = color;
    if (color.isLight()) {
      _accentColor = Colors.black;
    } else {
      _accentColor = Colors.white;
    }
  }

  static Color get accentColor => _accentColor;

  /// All the colors to choose from
  static final List<Color> colors = [
    Colors.amber,
    Colors.blue,
    Colors.cyan,
    Colors.orange,
    Colors.green,
    Colors.purple,
    Colors.indigo,
    Colors.lime,
    Colors.teal,
    Colors.yellow,
    Colors.red,
  ];

  /// The Amber Color Shades
  static final amberColors = [
    Colors.amber,
    Colors.amber.shade50,
    Colors.amber.shade100,
    Colors.amber.shade200,
    Colors.amber.shade300,
    Colors.amber.shade400,
    Colors.amber.shade500,
    Colors.amber.shade600,
    Colors.amber.shade700,
    Colors.amber.shade800,
    Colors.amber.shade900,
    Colors.amberAccent,
    Colors.amberAccent.shade100,
    Colors.amberAccent.shade200,
    Colors.amberAccent.shade400,
    Colors.amberAccent.shade700,
  ];

  /// The Blue Color Shades
  static final blueColors = [
    Colors.blue,
    Colors.blue.shade50,
    Colors.blue.shade100,
    Colors.blue.shade200,
    Colors.blue.shade300,
    Colors.blue.shade400,
    Colors.blue.shade500,
    Colors.blue.shade600,
    Colors.blue.shade700,
    Colors.blue.shade800,
    Colors.blue.shade900,
    Colors.blueAccent,
    Colors.blueAccent.shade100,
    Colors.blueAccent.shade200,
    Colors.blueAccent.shade400,
    Colors.blueAccent.shade700,
    Colors.lightBlue,
    Colors.lightBlue.shade100,
    Colors.lightBlue.shade200,
    Colors.lightBlue.shade300,
    Colors.lightBlue.shade400,
    Colors.lightBlue.shade500,
    Colors.lightBlue.shade600,
    Colors.lightBlue.shade700,
    Colors.lightBlue.shade800,
    Colors.lightBlue.shade900,
  ];

  /// The Cyan Color Shades
  static final cyanColors = [
    Colors.cyan,
    Colors.cyan.shade50,
    Colors.cyan.shade100,
    Colors.cyan.shade200,
    Colors.cyan.shade300,
    Colors.cyan.shade400,
    Colors.cyan.shade500,
    Colors.cyan.shade600,
    Colors.cyan.shade700,
    Colors.cyan.shade800,
    Colors.cyan.shade900,
    Colors.cyanAccent,
    Colors.cyanAccent.shade100,
    Colors.cyanAccent.shade200,
    Colors.cyanAccent.shade400,
    Colors.cyanAccent.shade700,
  ];

  /// The Orange Color Shades
  static final orangeColors = [
    Colors.orange,
    Colors.orange.shade100,
    Colors.orange.shade200,
    Colors.orange.shade300,
    Colors.orange.shade400,
    Colors.orange.shade500,
    Colors.orange.shade600,
    Colors.orange.shade700,
    Colors.orange.shade800,
    Colors.orange.shade900,
    Colors.orangeAccent,
    Colors.orangeAccent.shade100,
    Colors.orangeAccent.shade200,
    Colors.orangeAccent.shade400,
    Colors.orangeAccent.shade700,
    Colors.deepOrange,
    Colors.deepOrange.shade100,
    Colors.deepOrange.shade200,
    Colors.deepOrange.shade300,
    Colors.deepOrange.shade400,
    Colors.deepOrange.shade500,
    Colors.deepOrange.shade600,
    Colors.deepOrange.shade700,
    Colors.deepOrange.shade800,
    Colors.deepOrange.shade900,
    Colors.deepOrangeAccent,
    Colors.deepOrangeAccent.shade100,
    Colors.deepOrangeAccent.shade200,
    Colors.deepOrangeAccent.shade400,
    Colors.deepOrangeAccent.shade700,
  ];

  /// The Green Color Shades
  static final greenColors = [
    Colors.green,
    Colors.green.shade50,
    Colors.green.shade100,
    Colors.green.shade200,
    Colors.green.shade300,
    Colors.green.shade400,
    Colors.green.shade500,
    Colors.green.shade600,
    Colors.green.shade700,
    Colors.green.shade800,
    Colors.green.shade900,
    Colors.greenAccent,
    Colors.greenAccent.shade100,
    Colors.greenAccent.shade200,
    Colors.greenAccent.shade400,
    Colors.greenAccent.shade700,
    Colors.lightGreen,
    Colors.lightGreen.shade50,
    Colors.lightGreen.shade100,
    Colors.lightGreen.shade200,
    Colors.lightGreen.shade300,
    Colors.lightGreen.shade400,
    Colors.lightGreen.shade500,
    Colors.lightGreen.shade600,
    Colors.lightGreen.shade700,
    Colors.lightGreen.shade800,
    Colors.lightGreen.shade900,
    Colors.lightGreenAccent,
    Colors.lightGreenAccent.shade100,
    Colors.lightGreenAccent.shade200,
    Colors.lightGreenAccent.shade400,
    Colors.lightGreenAccent.shade700,
  ];

  /// The Purple Color Shades
  static final purpeColors = [
    Colors.purple,
    Colors.purple.shade50,
    Colors.purple.shade100,
    Colors.purple.shade200,
    Colors.purple.shade300,
    Colors.purple.shade400,
    Colors.purple.shade500,
    Colors.purple.shade600,
    Colors.purple.shade700,
    Colors.purple.shade800,
    Colors.purple.shade900,
    Colors.purpleAccent,
    Colors.purpleAccent.shade100,
    Colors.purpleAccent.shade200,
    Colors.purpleAccent.shade400,
    Colors.purpleAccent.shade700,
  ];

  /// The Indigo Color Shades
  static final indigoColors = [
    Colors.indigo,
    Colors.indigo.shade50,
    Colors.indigo.shade100,
    Colors.indigo.shade200,
    Colors.indigo.shade300,
    Colors.indigo.shade400,
    Colors.indigo.shade500,
    Colors.indigo.shade600,
    Colors.indigo.shade700,
    Colors.indigo.shade800,
    Colors.indigo.shade900,
    Colors.indigoAccent,
    Colors.indigoAccent.shade100,
    Colors.indigoAccent.shade200,
    Colors.indigoAccent.shade400,
    Colors.indigoAccent.shade700,
  ];

  /// The Lime Color Shades
  static final limeColors = [
    Colors.lime,
    Colors.lime.shade50,
    Colors.lime.shade100,
    Colors.lime.shade200,
    Colors.lime.shade300,
    Colors.lime.shade400,
    Colors.lime.shade500,
    Colors.lime.shade600,
    Colors.lime.shade700,
    Colors.lime.shade800,
    Colors.lime.shade900,
    Colors.limeAccent,
    Colors.limeAccent.shade100,
    Colors.limeAccent.shade200,
    Colors.limeAccent.shade400,
    Colors.limeAccent.shade700,
  ];

  /// The Teal Color Shades
  static final tealColors = [
    Colors.teal,
    Colors.teal.shade50,
    Colors.teal.shade100,
    Colors.teal.shade200,
    Colors.teal.shade300,
    Colors.teal.shade400,
    Colors.teal.shade500,
    Colors.teal.shade600,
    Colors.teal.shade700,
    Colors.teal.shade800,
    Colors.teal.shade900,
    Colors.tealAccent,
    Colors.tealAccent.shade100,
    Colors.tealAccent.shade200,
    Colors.tealAccent.shade400,
    Colors.tealAccent.shade700,
  ];

  /// The Yellow Color Shades
  static final yellowColors = [
    Colors.yellow,
    Colors.yellow.shade50,
    Colors.yellow.shade100,
    Colors.yellow.shade200,
    Colors.yellow.shade300,
    Colors.yellow.shade400,
    Colors.yellow.shade500,
    Colors.yellow.shade600,
    Colors.yellow.shade700,
    Colors.yellow.shade800,
    Colors.yellow.shade900,
    Colors.yellowAccent,
    Colors.yellowAccent.shade100,
    Colors.yellowAccent.shade200,
    Colors.yellowAccent.shade400,
    Colors.yellowAccent.shade700,
  ];

  /// The Red C0lor Shades
  static final redColors = [
    Colors.red,
    Colors.red.shade50,
    Colors.red.shade100,
    Colors.red.shade200,
    Colors.red.shade300,
    Colors.red.shade400,
    Colors.red.shade500,
    Colors.red.shade600,
    Colors.red.shade700,
    Colors.red.shade800,
    Colors.red.shade900,
    Colors.redAccent,
    Colors.redAccent.shade100,
    Colors.redAccent.shade200,
    Colors.redAccent.shade400,
    Colors.redAccent.shade700,
  ];
}

/// Extension on Color to determine if they
/// are dark or light
extension ColorMapping on Color {
  /// Returns if the Color is dark
  bool isDark() {
    return (red * 0.299) + (green * 0.587) + (blue * 0.114) < 186;
  }

  /// Returns if the Color is light
  bool isLight() {
    return (red * 0.299) + (green * 0.587) + (blue * 0.114) > 186;
  }
}
