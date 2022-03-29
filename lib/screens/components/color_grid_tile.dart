library components;

import 'package:flutter/material.dart';
import 'package:todo/logic/jumper.dart';
import 'package:todo/main.dart';
import 'package:todo/models/setting.dart';
import 'package:todo/screens/color_chooser.dart';
import 'package:todo/storage/storage.dart';
import 'package:todo/styles/coloring.dart';
import 'package:todo/styles/themes.dart';

/// Tile used in the [ColorChooser] which represents a single Color
/// [color] is the Color represented
class ColorGridTile extends StatefulWidget {
  const ColorGridTile({
    required this.color,
    required this.isSubTile,
    Key? key,
  }) : super(key: key);

  final Color color;
  final bool isSubTile;

  @override
  State<ColorGridTile> createState() => _ColorGridTileState();
}

class _ColorGridTileState extends State<ColorGridTile> {
  @override
  Widget build(BuildContext context) {
    final _tile = GestureDetector(
      onTap: _onTap,
      child: GridTile(
        footer: Text(
          widget.color.value.toRadixString(16).padLeft(11, " "),
        ),
        child: Container(
          alignment: Alignment.center,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            color: widget.color,
            shape: BoxShape.rectangle,
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
          ),
        ),
      ),
    );

    return _tile;
  }

  void _onTap() {
    if (widget.isSubTile) {
      setState(() {
        Coloring.mainColor = widget.color;
        TodoApp.themeStream.sink.add(Themes.themeMode);
        AllSettings.updateSettings();
        Storage.storeSettings();
      });
      Jumper.back(context);
      Jumper.back(context);
    } else {
      Jumper.openSubColorScreen(
        context,
        widget.color,
      );
    }
  }
}
