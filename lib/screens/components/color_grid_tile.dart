library components;

import 'package:flutter/material.dart';
import 'package:todo/logic/jumper.dart';
import 'package:todo/main.dart';
import 'package:todo/models/setting.dart' show AllSettings;
import 'package:todo/screens/color_chooser.dart';
import 'package:todo/storage/storage.dart';
import 'package:todo/styles/coloring.dart';
import 'package:todo/styles/themes.dart';

/// Enum to determine the position of the ColorGridTile in the Row
enum ColorGridPosition {
  left,
  middle,
  right,
}

/// Tile used in the [ColorChooser] which represents a single Color
/// [color] is the Color represented
class ColorGridTile extends StatefulWidget {
  const ColorGridTile({
    required this.firstColor,
    required this.secondColor,
    required this.isSubTile,
    required this.position,
    Key? key,
  }) : super(key: key);

  final Color firstColor;
  final Color secondColor;
  final bool isSubTile;
  final ColorGridPosition position;

  @override
  State<ColorGridTile> createState() => _ColorGridTileState();
}

class _ColorGridTileState extends State<ColorGridTile> {
  @override
  Widget build(BuildContext context) {
    final _tile = SizedBox(
      height: MediaQuery.of(context).size.width / 3,
      width: MediaQuery.of(context).size.width / 3,
      child: GestureDetector(
        onTap: _onTap,
        child: GridTile(
          footer: Text(
            widget.firstColor.value.toRadixString(16).padLeft(11, ' '),
          ),
          child: Container(
            alignment: Alignment.center,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                stops: [
                  1,
                ],
                tileMode: TileMode.clamp,
                transform: GradientRotation(20),
              ),
              color: widget.firstColor,
              shape: BoxShape.rectangle,
              borderRadius: _borderRadius,
            ),
          ),
        ),
      ),
    );

    return _tile;
  }

  BorderRadius get _borderRadius {
    switch (widget.position) {
      case ColorGridPosition.left:
        return const BorderRadius.only(
          topLeft: Radius.circular(25),
          bottomLeft: Radius.circular(25),
        );
      case ColorGridPosition.middle:
        return const BorderRadius.all(Radius.zero);
      case ColorGridPosition.right:
        return const BorderRadius.only(
          topRight: Radius.circular(25),
          bottomRight: Radius.circular(25),
        );
      default:
        return const BorderRadius.all(Radius.zero);
    }
  }

  void _onTap() {
    if (widget.isSubTile) {
      setState(() {
        Coloring.mainColor = widget.firstColor;
        TodoApp.themeStream.sink.add(Themes.themeMode);
        AllSettings.updateSettings();
        Storage.storeSettings();
      });
      Jumper.back(context);
      Jumper.back(context);
    } else {
      Jumper.openSubColorScreen(
        context,
        widget.firstColor,
      );
    }
  }
}
