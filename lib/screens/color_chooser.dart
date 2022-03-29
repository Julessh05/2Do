library screens;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:todo/logic/translate.dart';
import 'package:todo/screens/components/color_grid_tile.dart';
import 'package:todo/styles/coloring.dart';

class ColorChooser extends StatefulWidget {
  const ColorChooser({Key? key}) : super(key: key);

  static const routeName = "/settings/color_chooser";

  @override
  State<ColorChooser> createState() => _ColorChooserState();
}

class _ColorChooserState extends State<ColorChooser> {
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
    for (Color color in Coloring.colors) {
      final _tile = ColorGridTile(
        color: color,
        isSubTile: false,
      );
      _tiles.add(_tile);
    }
    return _tiles;
  }
}

class SubColorChooser extends StatefulWidget {
  const SubColorChooser({
    required this.color,
    Key? key,
  }) : super(key: key);

  static const routeName = "/settings/color_chooser/sub_color_chooser";

  final Color color;

  @override
  State<SubColorChooser> createState() => _SubColorChooserState();
}

class _SubColorChooserState extends State<SubColorChooser> {
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
    final List<Color> _colors;
    if (widget.color == Colors.amber) {
      _colors = Coloring.amberColors;
    } else if (widget.color == Colors.blue) {
      _colors = Coloring.blueColors;
    } else if (widget.color == Colors.cyan) {
      _colors = Coloring.cyanColors;
    } else if (widget.color == Colors.orange) {
      _colors = Coloring.orangeColors;
    } else if (widget.color == Colors.green) {
      _colors = Coloring.greenColors;
    } else if (widget.color == Colors.purple) {
      _colors = Coloring.purpeColors;
    } else if (widget.color == Colors.indigo) {
      _colors = Coloring.indigoColors;
    } else if (widget.color == Colors.lime) {
      _colors = Coloring.limeColors;
    } else if (widget.color == Colors.teal) {
      _colors = Coloring.tealColors;
    } else if (widget.color == Colors.yellow) {
      _colors = Coloring.yellowColors;
    } else if (widget.color == Colors.red) {
      _colors = Coloring.redColors;
    } else {
      _colors = [widget.color];
    }
    for (Color color in _colors) {
      final _tile = ColorGridTile(
        color: color,
        isSubTile: true,
      );
      _tiles.add(_tile);
    }
    return _tiles;
  }
}
