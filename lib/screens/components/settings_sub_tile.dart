library components;

import 'package:flutter/material.dart';
import 'package:todo/logic/translate.dart';
import 'package:todo/models/setting.dart';
import 'package:todo/screens/components/settings_tile.dart';

/// Is used to show new SettingsTiles from one SettingsTile above them
/// They have nearly the same options as a [SettingsTile], withour the option
/// to have Subtiles
class SettingsSubTile extends StatefulWidget {
  const SettingsSubTile({
    required this.setting,
    this.simpleDialog,
    this.alertDialog,
    this.uiSwitch,
    this.icon,
    Key? key,
  })  : assert(
          uiSwitch == null && simpleDialog != null && alertDialog == null ||
              uiSwitch != null && simpleDialog == null && alertDialog == null ||
              uiSwitch == null && simpleDialog == null && alertDialog != null,
          "You have to define exactly one Widget, not more and not less",
        ),
        super(key: key);

  final Setting setting;
  final Switch? uiSwitch;
  final SimpleDialog? simpleDialog;
  final AlertDialog? alertDialog;
  final Icon? icon;

  @override
  State<SettingsSubTile> createState() => _SettingsSubTileState();
}

class _SettingsSubTileState extends State<SettingsSubTile> {
  @override
  Widget build(BuildContext context) {
    final _tile = ListTile(
      autofocus: false,
      isThreeLine: false,
      title: Text(
        widget.setting.name,
        semanticsLabel: "Name of the Setting".translate(),
      ),
      subtitle: Text(
        widget.setting.value,
        semanticsLabel: "Value of the Setting".translate(),
      ),
      enabled: true,
      leading: widget.icon,
    );

    return _tile;
  }
}
