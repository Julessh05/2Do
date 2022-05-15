library screens;

import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';
import 'package:string_translate/string_translate.dart' show Translate;
import 'package:todo/main.dart' show TodoApp;
import 'package:todo/screens/components/color_grid_tile.dart';
import 'package:todo/styles/coloring.dart' show Coloring;

/// The Screen to choose the Color for the App
/// This is the first Screen.
/// The real Color is chosen in the [SubColorChooser]
class ColorChooser extends StatefulWidget {
  const ColorChooser({Key? key}) : super(key: key);

  /// The Name of the Route for this Screen.
  /// Is used to navigate trough the App.
  /// These Values are set in the [MaterialApp] of the [TodoApp]
  static const routeName = '/settings/color_chooser';

  @override
  State<ColorChooser> createState() => _ColorChooserState();
}

class _ColorChooserState extends State<ColorChooser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          'Choose a Color'.tr(),
          semanticsLabel: 'Choose a Color'.tr(),
        ),
      ),
      body: ListView(
        addAutomaticKeepAlives: true,
        addRepaintBoundaries: true,
        addSemanticIndexes: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        dragStartBehavior: DragStartBehavior.start,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        children: _colorList,
      ),
    );
  }

  /// List of Widgets to display the different Colors.
  List<IntrinsicHeight> get _colorList {
    final List<IntrinsicHeight> list = [];
    for (int counter = 0; counter < Coloring.colors.length - 2; counter++) {
      list.add(
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            textBaseline: TextBaseline.alphabetic,
            textDirection: TextDirection.ltr,
            verticalDirection: VerticalDirection.down,
            children: <ColorGridTile>[
              ColorGridTile(
                color: Coloring.colors[counter],
                colorBehind: Coloring.colors[counter + 1],
                isSubTile: false,
                position: ColorGridPosition.left,
              ),
              ColorGridTile(
                color: Coloring.colors[++counter],
                isSubTile: false,
                position: ColorGridPosition.middle,
              ),
              ColorGridTile(
                color: Coloring.colors[++counter],
                colorInfront: Coloring.colors[counter - 1],
                isSubTile: false,
                position: ColorGridPosition.right,
              ),
            ],
          ),
        ),
      );
    }
    return list;
  }
}

/// The Screen to choose the Color for the App
/// This screen changes it's Look depending on the [color]
class SubColorChooser extends StatefulWidget {
  const SubColorChooser({
    required this.color,
    Key? key,
  }) : super(key: key);

  /// The Name of the Route for this Screen.
  /// Is used to navigate trough the App.
  /// These Values are set in the [MaterialApp] of the [TodoApp]
  static const routeName = '/settings/color_chooser/sub_color_chooser';

  final Color color;

  @override
  State<SubColorChooser> createState() => _SubColorChooserState();
}

class _SubColorChooserState extends State<SubColorChooser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          'Choose a Color'.tr(),
          semanticsLabel: 'Choose a Color'.tr(),
        ),
      ),
      body: ListView(
        addAutomaticKeepAlives: true,
        addRepaintBoundaries: true,
        addSemanticIndexes: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        dragStartBehavior: DragStartBehavior.start,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        children: _colorTiles,
      ),
    );
  }

  /// List of the Colors.
  /// Depending on the [widget.color]
  List<IntrinsicHeight> get _colorTiles {
    final List<IntrinsicHeight> tiles = [];
    final List<Color> colors;
    if (widget.color == Colors.amber) {
      colors = Coloring.amberColors;
    } else if (widget.color == Colors.blue) {
      colors = Coloring.blueColors;
    } else if (widget.color == Colors.cyan) {
      colors = Coloring.cyanColors;
    } else if (widget.color == Colors.orange) {
      colors = Coloring.orangeColors;
    } else if (widget.color == Colors.green) {
      colors = Coloring.greenColors;
    } else if (widget.color == Colors.purple) {
      colors = Coloring.purpleColors;
    } else if (widget.color == Colors.indigo) {
      colors = Coloring.indigoColors;
    } else if (widget.color == Colors.lime) {
      colors = Coloring.limeColors;
    } else if (widget.color == Colors.teal) {
      colors = Coloring.tealColors;
    } else if (widget.color == Colors.yellow) {
      colors = Coloring.yellowColors;
    } else if (widget.color == Colors.red) {
      colors = Coloring.redColors;
    } else if (widget.color == Colors.brown ||
        widget.color == Colors.brown.shade800 ||
        widget.color == Colors.black) {
      colors = Coloring.brownColors;
    } else if (widget.color == Colors.pink) {
      colors = Coloring.pinkColors;
    } else {
      colors = [widget.color];
    }
    for (int counter = 0; counter < colors.length - 2; counter++) {
      tiles.add(
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            textBaseline: TextBaseline.alphabetic,
            textDirection: TextDirection.ltr,
            verticalDirection: VerticalDirection.down,
            children: <ColorGridTile>[
              ColorGridTile(
                color: colors[counter],
                colorBehind: colors[counter + 1],
                isSubTile: true,
                position: ColorGridPosition.left,
              ),
              ColorGridTile(
                color: colors[++counter],
                isSubTile: true,
                position: ColorGridPosition.middle,
              ),
              ColorGridTile(
                color: colors[++counter],
                colorInfront: colors[counter - 1],
                isSubTile: true,
                position: ColorGridPosition.right,
              ),
            ],
          ),
        ),
      );
    }
    return tiles;
  }
}
