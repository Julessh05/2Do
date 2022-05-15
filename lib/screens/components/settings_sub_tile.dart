library components;

import 'package:flutter/material.dart';
import 'package:string_translate/string_translate.dart' show Translate;
import 'package:todo/models/setting.dart' show Setting;
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
          'You have to define exactly one Widget, not more and not less',
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
    this.aboutDialog,
    Key? key,
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
    final tile = ListTile(
      autofocus: false,
      isThreeLine: false,
      title: Text(
        widget.setting.name.tr(),
        semanticsLabel: 'Name of the Setting'.tr(),
      ),
      subtitle: Text(
        widget.setting.valueAsString.tr(),
        semanticsLabel: 'Value of the Setting'.tr(),
      ),
      enabled: true,
      leading: widget.icon,
      trailing: widget.uiSwitch != null
          ? Switch(
              onChanged: (value) {
                widget.uiSwitch!.onChanged!(value);
                setState(() {});
              },
              value: widget.setting.boolValue!,
            )
          : null,
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

    return tile;
  }
}
