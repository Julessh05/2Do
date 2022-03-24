library components;

import 'package:flutter/material.dart';
import 'package:todo/logic/translate.dart';
import 'package:todo/models/setting.dart';
import 'package:todo/screens/components/settings_tile.dart';

/// Is used to show new SettingsTiles from one SettingsTile above them
/// They have nearly the same options as a [SettingsTile], without the option
/// to have Subtiles
class SettingsSubTile extends StatefulWidget {
  const SettingsSubTile({
    required this.setting,
    this.simpleDialog,
    this.alertDialog,
    this.uiSwitch,
    this.icon,
    this.aboutDialog,
    Key? key,
  })  : assert(
          uiSwitch == null &&
                  simpleDialog != null &&
                  alertDialog == null &&
                  aboutDialog == null ||
              uiSwitch != null &&
                  simpleDialog == null &&
                  alertDialog == null &&
                  aboutDialog == null ||
              uiSwitch == null &&
                  simpleDialog == null &&
                  alertDialog != null &&
                  aboutDialog == null ||
              uiSwitch == null &&
                  simpleDialog == null &&
                  alertDialog == null &&
                  aboutDialog != null,
          "You have to define exactly one Widget, not more and not less",
        ),
        super(key: key);

  /// Settings Sub Tile without any Action.
  /// This can be used to have an About Tile or some
  /// other kind of information
  const SettingsSubTile.withoutAction(
    this.setting, [
    this.icon,
    this.alertDialog,
    this.simpleDialog,
    this.uiSwitch,
    Key? key,
    this.aboutDialog,
  ]) : super(key: key);

  final Setting setting;
  final Switch? uiSwitch;
  final SimpleDialog? simpleDialog;
  final AlertDialog? alertDialog;
  final AboutDialog? aboutDialog;
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
        widget.setting.valueAsString,
        semanticsLabel: "Value of the Setting".translate(),
      ),
      enabled: true,
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
        } else if (widget.aboutDialog != null) {
          showAboutDialog(
            context: context,
          );
        } else {
          // Do nothing
        }
      },
    );

    return _tile;
  }
}
