library components;

import 'package:flutter/material.dart';
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
    this.icon,
    Key? key,
  })  : assert(
          uiSwitch == null &&
                  simpleDialog != null &&
                  subtiles == null &&
                  alertDialog == null ||
              uiSwitch != null &&
                  simpleDialog == null &&
                  subtiles == null &&
                  alertDialog == null ||
              uiSwitch == null &&
                  simpleDialog == null &&
                  subtiles != null &&
                  alertDialog == null ||
              uiSwitch == null &&
                  simpleDialog == null &&
                  subtiles == null &&
                  alertDialog != null,
          "You have to define exactly one Widget, not more and not less",
        ),
        super(key: key);

  final Setting setting;
  final Switch? uiSwitch;
  final SimpleDialog? simpleDialog;
  final AlertDialog? alertDialog;
  final List<SettingsSubTile>? subtiles;
  final Icon? icon;

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
        widget.setting.name,
        semanticsLabel: "Name of the Setting".translate(),
      ),
      subtitle: Text(
        widget.setting.value,
        semanticsLabel: "Value of the Setting".translate(),
      ),
      leading: widget.icon,
      onTap: () {
        if (widget.uiSwitch != null) {
        } else if (widget.simpleDialog != null) {
          showDialog(
            context: context,
            builder: (_) {
              return widget.simpleDialog!;
            },
          );
        } else if (widget.alertDialog != null) {
          showDialog(
            context: context,
            builder: (_) {
              return widget.alertDialog!;
            },
          );
        }
      },
      trailing: widget.uiSwitch,
    );

    return _tile;
  }
}
