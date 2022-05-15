library components;

import 'package:flutter/material.dart';
import 'package:todo/logic/jumper.dart';
import 'package:todo/main.dart' show TodoApp;
import 'package:todo/models/setting.dart' show AllSettings;
import 'package:todo/screens/color_chooser.dart' show ColorChooser;
import 'package:todo/storage/storage.dart';
import 'package:todo/styles/coloring.dart' show Coloring;
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
    required this.color,
    this.colorInfront,
    this.colorBehind,
    required this.isSubTile,
    required this.position,
    Key? key,
  })  : assert(
          position == ColorGridPosition.left && colorBehind != null ||
              position == ColorGridPosition.middle &&
                  colorInfront == null &&
                  colorBehind == null ||
              position == ColorGridPosition.right && colorInfront != null,
          'You need to specify the right amount of Colors to your Position',
        ),
        super(key: key);

  final Color color;
  final Color? colorInfront;
  final Color? colorBehind;
  final bool isSubTile;
  final ColorGridPosition position;

  @override
  State<ColorGridTile> createState() => _ColorGridTileState();
}

class _ColorGridTileState extends State<ColorGridTile> {
  @override
  Widget build(BuildContext context) {
    final tile = SizedBox(
      height: MediaQuery.of(context).size.width / 3,
      width: MediaQuery.of(context).size.width / 3,
      child: GestureDetector(
        onTap: _onTap,
        child: GridTile(
          footer: widget.color != Coloring.backgroundColor
              ? Text(
                  widget.color.value.toRadixString(16).padLeft(11, ' '),
                )
              : null,
          child: Container(
            alignment: Alignment.center,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              gradient: _gradient,
              color: widget.color,
              shape: BoxShape.rectangle,
              borderRadius: _borderRadius,
            ),
          ),
        ),
      ),
    );

    return tile;
  }

  /// Getter for the Gradient
  /// depending on the [ColorGridPosition].
  Gradient? get _gradient {
    switch (widget.position) {
      case ColorGridPosition.left:
        if (widget.color == Coloring.backgroundColor) {
          return null;
        } else {
          return LinearGradient(
            colors: [
              widget.color,
              widget.colorBehind!,
            ],
            stops: const <double>[
              0.45,
              1.0,
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            tileMode: TileMode.clamp,
          );
        }
      case ColorGridPosition.middle:
        return null;
      case ColorGridPosition.right:
        if (widget.color == Coloring.backgroundColor) {
          return null;
        } else {
          return LinearGradient(
            colors: [
              widget.colorInfront!,
              widget.color,
            ],
            stops: const <double>[
              0.1,
              1,
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            tileMode: TileMode.clamp,
          );
        }
      default:
        return LinearGradient(
          colors: [
            widget.colorInfront!,
            widget.color,
            widget.colorBehind!,
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          tileMode: TileMode.clamp,
        );
    }
  }

  /// Getter for the Border Radius
  /// depending on the [ColorGridPosition].
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
