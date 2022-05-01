library components;

import 'package:flutter/material.dart';
import 'package:todo/logic/jumper.dart';
import 'package:string_translate/string_translate.dart' show Translate;
import 'package:todo/models/setting.dart' show Setting;
import 'package:todo/screens/components/settings_sub_tile.dart';

/// Represents one Setting.
/// There are several Widgets you can pass to the Tile
/// The [subtiles] create a new Screen and shows the Subtiles
/// The other options show an Dialog or are Options you see directly in the Tile.
/// [newScreenRouteName] is the Route Name of a new Screen if you whish to
/// redirect to a new Screen when pressing the Tile.
/// If you define [newScreenRouteName] you have to pass [newScreenArguments], even
/// if it is null. Then just pass null
class SettingsTile extends StatefulWidget {
  const SettingsTile({
    required this.setting,
    this.uiSwitch,
    this.simpleDialog,
    this.simpleDialogFunc,
    this.alertDialog,
    this.subtiles,
    this.aboutDialog,
    this.icon,
    this.newScreenRouteName,
    this.newScreenArguments,
    Key? key,
  })  : assert(
          uiSwitch == null &&
                  simpleDialog != null &&
                  subtiles == null &&
                  alertDialog == null &&
                  aboutDialog == null &&
                  newScreenRouteName == null &&
                  newScreenArguments == null &&
                  simpleDialogFunc == null ||
              uiSwitch != null &&
                  simpleDialog == null &&
                  subtiles == null &&
                  alertDialog == null &&
                  aboutDialog == null &&
                  newScreenRouteName == null &&
                  newScreenArguments == null &&
                  simpleDialogFunc == null ||
              uiSwitch == null &&
                  simpleDialog == null &&
                  subtiles != null &&
                  alertDialog == null &&
                  aboutDialog == null &&
                  newScreenRouteName == null &&
                  newScreenArguments == null &&
                  simpleDialogFunc == null ||
              uiSwitch == null &&
                  simpleDialog == null &&
                  subtiles == null &&
                  alertDialog != null &&
                  aboutDialog == null &&
                  newScreenRouteName == null &&
                  newScreenArguments == null &&
                  simpleDialogFunc == null ||
              uiSwitch == null &&
                  simpleDialog == null &&
                  subtiles == null &&
                  alertDialog == null &&
                  aboutDialog != null &&
                  newScreenRouteName == null &&
                  newScreenArguments == null &&
                  simpleDialogFunc == null ||
              uiSwitch == null &&
                  simpleDialog == null &&
                  subtiles == null &&
                  alertDialog == null &&
                  aboutDialog == null &&
                  newScreenRouteName != null &&
                  simpleDialogFunc == null ||
              uiSwitch == null &&
                  simpleDialog == null &&
                  subtiles == null &&
                  alertDialog == null &&
                  aboutDialog == null &&
                  newScreenRouteName == null &&
                  simpleDialogFunc != null,
          'You have to define exactly one Widget, not more and not less',
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
    this.newScreenRouteName,
    this.newScreenArguments,
    this.simpleDialogFunc,
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
    this.newScreenRouteName,
    this.newScreenArguments,
    this.simpleDialogFunc,
    Key? key,
  }) : super(key: key);

  final Setting setting;
  final Switch? uiSwitch;
  final SimpleDialog? simpleDialog;
  final AlertDialog? alertDialog;
  final List<SettingsSubTile>? subtiles;
  final Icon? icon;
  final AboutDialog? aboutDialog;
  final String? newScreenRouteName;

  /// Function that can be passed to create a simple Dialog.
  /// The [simpleDialog] is created once and cached so sometimes there
  /// are some problems with calling setState() or changing Values while
  /// this dialog is cached.
  final SimpleDialog Function()? simpleDialogFunc;
  final dynamic newScreenArguments;

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
        widget.setting.name.tr(),
        semanticsLabel: 'Name of the Setting'.tr(),
      ),
      subtitle: Text(
        widget.setting.valueToDisplay.tr(),
        semanticsLabel: 'Value of the Setting'.tr(),
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
          ).then(
            (value) => setState(() {}),
          );
        } else if (widget.aboutDialog != null) {
          // Show About Dialog
          showDialog(
              barrierDismissible: true,
              context: context,
              builder: (_) {
                return widget.aboutDialog!;
              });
        } else if (widget.newScreenRouteName != null) {
          // Create New Screen
          Jumper.openNamedSettingsNewScreen(
            context,
            widget.newScreenRouteName!,
            widget.newScreenArguments,
          ).then(
            (value) => setState(() {}),
          );
        } else if (widget.simpleDialogFunc != null) {
          showDialog(
            context: context,
            builder: (_) {
              return widget.simpleDialogFunc!();
            },
          );
        }
      },
      trailing: widget.uiSwitch,
    );

    return _tile;
  }
}
