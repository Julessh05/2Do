library styles;

import 'package:flutter/material.dart' show Color, Colors;

/// Every Color used in the App
class Coloring {
  /// Main Color used to display most elements in the App
  static Color _mainColor = Colors.blue.shade800;

  /// Accent Color used for Text for example
  static Color _accentColor = Colors.white;

  static Color backgroundColor = Colors.white;

  /// Getter for the Main Color Variable
  static Color get mainColor {
    return _mainColor;
  }

  /// Setter for the Main Color Variable
  static set mainColor(Color color) {
    _mainColor = color;
    if (color.isLight()) {
      _accentColor = Colors.black;
    } else {
      _accentColor = Colors.white;
    }
  }

  /// Getter for the Accent Color Variable.
  /// This Variable can only be read and not written from
  /// outside of the Class
  static Color get accentColor => _accentColor;

  /// All the colors to choose from
  static final List<Color> colors = [
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.yellow,
    Colors.amber,
    Colors.orange,
    Colors.lime,
    Colors.green,
    Colors.teal,
    Colors.indigo,
    Colors.blue,
    Colors.cyan,
    Colors.brown,
    Colors.brown.shade800,
    Colors.black,
  ];

  /// The Red Color Shades
  static final redColors = [
    Colors.red.shade100,
    Colors.red.shade200,
    Colors.redAccent.shade100,
    Colors.red.shade300,
    Colors.redAccent.shade200,
    Colors.red.shade400,
    Colors.redAccent,
    Colors.red,
    Colors.red.shade500,
    Colors.red.shade600,
    Colors.redAccent.shade400,
    Colors.red.shade700,
    Colors.red.shade800,
    Colors.redAccent.shade700,
    Colors.red.shade900,
  ];

  /// The Pink Colors
  static final pinkColors = [
    Colors.pink.shade100,
    Colors.pink.shade200,
    Colors.pink.shade300,
    Colors.pinkAccent.shade100,
    Colors.pinkAccent.shade200,
    Colors.pinkAccent,
    Colors.pinkAccent.shade400,
    Colors.pinkAccent.shade700,
    Colors.pink.shade400,
    Colors.pink,
    Colors.pink.shade500,
    Colors.pink.shade600,
    Colors.pink.shade700,
    Colors.pink.shade800,
    Colors.pink.shade900,
  ];

  /// The Purple Color Shades
  static final purpeColors = [
    Colors.purple.shade100,
    Colors.purple.shade200,
    Colors.purple.shade300,
    Colors.purpleAccent.shade100,
    Colors.purpleAccent.shade200,
    Colors.purpleAccent,
    Colors.purpleAccent.shade400,
    Colors.purpleAccent.shade700,
    Colors.purple.shade400,
    Colors.purple,
    Colors.purple.shade500,
    Colors.purple.shade600,
    Colors.purple.shade700,
    Colors.purple.shade800,
    Colors.purple.shade900,
  ];

  /// The Yellow Color Shades
  static final yellowColors = [
    Colors.yellow.shade100,
    Colors.yellow.shade200,
    Colors.yellow.shade300,
    Colors.yellowAccent.shade100,
    Colors.yellowAccent.shade200,
    Colors.yellowAccent,
    Colors.yellowAccent.shade400,
    Colors.yellowAccent.shade700,
    Colors.yellow.shade400,
    Colors.yellow,
    Colors.yellow.shade500,
    Colors.yellow.shade600,
    Colors.yellow.shade700,
    Colors.yellow.shade800,
    Colors.yellow.shade900,
  ];

  /// The Amber Color Shades
  static final amberColors = [
    Colors.amber.shade100,
    Colors.amber.shade200,
    Colors.amber.shade300,
    Colors.amberAccent.shade100,
    Colors.amberAccent.shade200,
    Colors.amberAccent,
    Colors.amberAccent.shade400,
    Colors.amberAccent.shade700,
    Colors.amber.shade400,
    Colors.amber,
    Colors.amber.shade500,
    Colors.amber.shade600,
    Colors.amber.shade700,
    Colors.amber.shade800,
    Colors.amber.shade900,
  ];

  /// The Orange Color Shades
  static final orangeColors = [
    Colors.orange.shade100,
    Colors.orange.shade200,
    Colors.orange.shade300,
    Colors.deepOrange.shade100,
    Colors.deepOrange.shade200,
    Colors.deepOrange.shade300,
    Colors.orangeAccent.shade100,
    Colors.orangeAccent.shade200,
    Colors.orangeAccent,
    Colors.orangeAccent.shade400,
    Colors.orangeAccent.shade700,
    Colors.orange.shade400,
    Colors.orange,
    Colors.orange.shade500,
    Colors.orange.shade600,
    Colors.orange.shade700,
    Colors.orange.shade800,
    Colors.orange.shade900,
    Colors.deepOrangeAccent.shade100,
    Colors.deepOrangeAccent.shade200,
    Colors.deepOrangeAccent,
    Colors.deepOrangeAccent.shade400,
    Colors.deepOrangeAccent.shade700,
    Colors.deepOrange,
    Colors.deepOrange.shade400,
    Colors.deepOrange.shade500,
    Colors.deepOrange.shade600,
    Colors.deepOrange.shade700,
    Colors.deepOrange.shade800,
    Colors.deepOrange.shade900,
  ];

  /// The Lime Color Shades
  static final limeColors = [
    Colors.lime.shade100,
    Colors.lime.shade200,
    Colors.limeAccent.shade100,
    Colors.lime.shade300,
    Colors.lime.shade400,
    Colors.limeAccent,
    Colors.limeAccent.shade200,
    Colors.limeAccent.shade400,
    Colors.limeAccent.shade700,
    Colors.lime,
    Colors.lime.shade500,
    Colors.lime.shade600,
    Colors.lime.shade700,
    Colors.lime.shade800,
    Colors.lime.shade900,
  ];

  /// The Green Color Shades
  static final greenColors = [
    Colors.green.shade100,
    Colors.green.shade200,
    Colors.green.shade300,
    Colors.lightGreen.shade100,
    Colors.lightGreen.shade200,
    Colors.lightGreen.shade300,
    Colors.greenAccent.shade100,
    Colors.greenAccent.shade200,
    Colors.greenAccent,
    Colors.greenAccent.shade400,
    Colors.greenAccent.shade700,
    Colors.green.shade400,
    Colors.green,
    Colors.green.shade500,
    Colors.green.shade600,
    Colors.green.shade700,
    Colors.green.shade800,
    Colors.green.shade900,
    Colors.lightGreenAccent.shade100,
    Colors.lightGreenAccent.shade200,
    Colors.lightGreenAccent,
    Colors.lightGreenAccent.shade400,
    Colors.lightGreenAccent.shade700,
    Colors.lightGreen.shade400,
    Colors.lightGreen,
    Colors.lightGreen.shade500,
    Colors.lightGreen.shade600,
    Colors.lightGreen.shade700,
    Colors.lightGreen.shade800,
    Colors.lightGreen.shade900,
  ];

  /// The Teal Color Shades
  static final tealColors = [
    Colors.teal.shade100,
    Colors.tealAccent.shade100,
    Colors.teal.shade200,
    Colors.tealAccent,
    Colors.tealAccent.shade200,
    Colors.tealAccent.shade400,
    Colors.tealAccent.shade700,
    Colors.teal.shade300,
    Colors.teal.shade400,
    Colors.teal,
    Colors.teal.shade500,
    Colors.teal.shade600,
    Colors.teal.shade700,
    Colors.teal.shade800,
    Colors.teal.shade900,
  ];

  /// The Indigo Color Shades
  static final indigoColors = [
    Colors.indigo.shade100,
    Colors.indigo.shade200,
    Colors.indigo.shade300,
    Colors.indigoAccent.shade100,
    Colors.indigoAccent.shade200,
    Colors.indigoAccent,
    Colors.indigoAccent.shade400,
    Colors.indigoAccent.shade700,
    Colors.indigo.shade400,
    Colors.indigo,
    Colors.indigo.shade500,
    Colors.indigo.shade600,
    Colors.indigo.shade700,
    Colors.indigo.shade800,
    Colors.indigo.shade900,
  ];

  /// The Blue Color Shades
  static final blueColors = [
    Colors.blue.shade50,
    Colors.blue.shade100,
    Colors.lightBlue.shade100,
    Colors.blue.shade200,
    Colors.lightBlue.shade200,
    Colors.blueAccent.shade100,
    Colors.blue.shade300,
    Colors.lightBlue.shade300,
    Colors.lightBlue.shade400,
    Colors.lightBlue,
    Colors.lightBlue.shade500,
    Colors.blue.shade400,
    Colors.lightBlue.shade600,
    Colors.blue,
    Colors.blueAccent.shade200,
    Colors.blueAccent,
    Colors.blue.shade500,
    Colors.blueAccent,
    Colors.blue.shade600,
    Colors.lightBlue.shade700,
    Colors.lightBlue.shade800,
    Colors.blue.shade700,
    Colors.blueAccent.shade400,
    Colors.blueAccent.shade700,
    Colors.blue.shade800,
    Colors.lightBlue.shade900,
    Colors.blue.shade900,
  ];

  /// The Cyan Color Shades
  static final cyanColors = [
    Colors.cyan.shade100,
    Colors.cyan.shade200,
    Colors.cyanAccent.shade100,
    Colors.cyan.shade300,
    Colors.cyanAccent,
    Colors.cyanAccent.shade400,
    Colors.cyan.shade400,
    Colors.cyan,
    Colors.cyanAccent.shade700,
    Colors.cyan.shade500,
    Colors.cyan.shade600,
    Colors.cyan.shade700,
    Colors.cyan.shade800,
    Colors.cyan.shade900,
  ];

  /// Brown Colors
  static final brownColors = [
    Colors.brown.shade50,
    Colors.brown.shade100,
    Colors.brown.shade200,
    Colors.brown.shade300,
    Colors.brown.shade400,
    Colors.brown,
    Colors.brown.shade500,
    Colors.brown.shade600,
    Colors.brown.shade700,
    Colors.brown.shade800,
    Colors.brown.shade900,
    backgroundColor,
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
