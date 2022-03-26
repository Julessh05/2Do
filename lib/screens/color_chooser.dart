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
        children: const <ColorGridTile>[
          ColorGridTile(
            color: Colors.red,
          )
        ],
      ),
    );

    return _scaffold;
  }
}
