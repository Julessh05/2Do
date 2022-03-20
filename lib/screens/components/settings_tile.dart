library components;

import 'package:flutter/material.dart';
import 'package:todo/logic/jumper.dart';
import 'package:todo/logic/translate.dart';
import 'package:todo/models/setting.dart';
import 'package:todo/screens/components/settings_sub_tile.dart';

/// Represents one Setting.
/// There are several Widgets you can pass to the Tile
/// The [subtiles] create a new Screen and shows the Subtiles
/// The other options show an Dialog or are Options you see directly in the Tile.
class SettingsTile extends StatefulWidget {
  const SettingsTile({
    required this.setting,
    this.uiSwitch,
    this.simpleDialog,
    this.alertDialog,
    this.subtiles,
    this.aboutDialog,
    this.icon,
    Key? key,
  })  : assert(
          uiSwitch == null &&
                  simpleDialog != null &&
                  subtiles == null &&
                  alertDialog == null &&
                  aboutDialog == null ||
              uiSwitch != null &&
                  simpleDialog == null &&
                  subtiles == null &&
                  alertDialog == null &&
                  aboutDialog == null ||
              uiSwitch == null &&
                  simpleDialog == null &&
                  subtiles != null &&
                  alertDialog == null &&
                  aboutDialog == null ||
              uiSwitch == null &&
                  simpleDialog == null &&
                  subtiles == null &&
                  alertDialog != null &&
                  aboutDialog == null ||
              uiSwitch == null &&
                  simpleDialog == null &&
                  subtiles == null &&
                  alertDialog == null &&
                  aboutDialog != null,
          "You have to define exactly one Widget, not more and not less",
        ),
        super(key: key);

  /// Settings Tile without any Action.
  /// This can be used to have an About Tile or some
  /// other kind of information
  const SettingsTile.withoutAction({
    required this.setting,
    this.icon,
    this.alertDialog,
    this.simpleDialog,
    this.subtiles,
    this.uiSwitch,
    this.aboutDialog,
    Key? key,
  }) : super(key: key);

  const SettingsTile.folder({
    required this.setting,
    this.alertDialog,
    this.icon,
    this.simpleDialog,
    required this.subtiles,
    this.uiSwitch,
    this.aboutDialog,
    Key? key,
  }) : super(key: key);

  final Setting setting;
  final Switch? uiSwitch;
  final SimpleDialog? simpleDialog;
  final AlertDialog? alertDialog;
  final List<SettingsSubTile>? subtiles;
  final Icon? icon;
  final AboutDialog? aboutDialog;

  /// Returns if the Tile has subtiles
  /// and so creates a new Screen
  bool get hasSubtiles {
    if (subtiles != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  _SettingsTileState createState() => _SettingsTileState();
}

class _SettingsTileState extends State<SettingsTile> {
  @override
  Widget build(BuildContext context) {
    final _tile = ListTile(
      autofocus: false,
      enabled: true,
      isThreeLine: false,
      title: Text(
        widget.setting.name.translate(),
        semanticsLabel: "Name of the Setting".translate(),
      ),
      subtitle: Text(
        widget.setting.valueToDisplay,
        semanticsLabel: "Value of the Setting".translate(),
      ),
      leading: widget.icon,
      onTap: () {
        if (widget.uiSwitch != null) {
          // Nothing done when you have a Switch
        } else if (widget.simpleDialog != null) {
          // Show Simple Dialog
          showDialog(
            barrierDismissible: true,
            context: context,
            builder: (_) {
              return widget.simpleDialog!;
            },
          );
        } else if (widget.alertDialog != null) {
          // Show Alert Dialog
          showDialog(
            barrierDismissible: true,
            context: context,
            builder: (_) {
              return widget.alertDialog!;
            },
          );
        } else if (widget.subtiles != null) {
          // Navigate to new Screen with Subtiles
          Jumper.openSettingsSubScreen(
            context,
            widget.subtiles!,
            widget.setting,
          );
        } else if (widget.aboutDialog != null) {
          // Show About Dialog
          showDialog(
              barrierDismissible: true,
              context: context,
              builder: (_) {
                return widget.aboutDialog!;
              });
        }
      },
      trailing: widget.uiSwitch,
    );

    return _tile;
  }
}
