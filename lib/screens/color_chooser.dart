library screens;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:todo/logic/translate.dart';
import 'package:todo/screens/components/color_grid_tile.dart';

class ColorChooser extends StatefulWidget {
  const ColorChooser({Key? key}) : super(key: key);

  static const routeName = "/settings/color_chooser";

  @override
  State<ColorChooser> createState() => _ColorChooserState();
}

class _ColorChooserState extends State<ColorChooser> {
  /// All the colors to choose from
  final List<Color> _colors = [
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

  @override
  Widget build(BuildContext context) {
    final _scaffold = Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          "Choose a Color".translate(),
          semanticsLabel: "Choose a Color".translate(),
        ),
      ),
      body: GridView.count(
        crossAxisCount: 3,
        addAutomaticKeepAlives: true,
        addRepaintBoundaries: true,
        addSemanticIndexes: true,
        dragStartBehavior: DragStartBehavior.start,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        children: _colorTiles,
      ),
    );

    return _scaffold;
  }

  List<ColorGridTile> get _colorTiles {
    final List<ColorGridTile> _tiles = [];
    for (Color color in _colors) {
      final _tile = ColorGridTile(color: color);
      _tiles.add(_tile);
    }
    return _tiles;
  }
}
