library components;

import 'package:flutter/material.dart';
import 'package:todo/screens/color_chooser.dart';
import 'package:todo/styles/coloring.dart';

/// Tile used in the [ColorChooser] which represents a single Color
/// [color] is the Color represented
class ColorGridTile extends StatefulWidget {
  const ColorGridTile({
    required this.color,
    Key? key,
  }) : super(key: key);

  final Color color;

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
    setState(() {
      Coloring.mainColor = widget.color;
    });
  }
}
