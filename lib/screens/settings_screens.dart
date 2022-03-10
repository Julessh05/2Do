library screens;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:todo/logic/jumper.dart';
import 'package:todo/logic/translate.dart';
import 'package:todo/models/setting.dart';
import 'package:todo/screens/components/settings_sub_tile.dart';
import 'package:todo/screens/components/settings_tile.dart';
import 'package:todo/styles/themes.dart';

/// The Main Settings Screen from which you can navigate
/// to the other Settings Screens and can set the Value of the Settings
class SettingsMainScreen extends StatefulWidget {
  const SettingsMainScreen({Key? key}) : super(key: key);

  static const routeName = "/settings";

  @override
  State<SettingsMainScreen> createState() => _SettingsMainScreenState();
}

class _SettingsMainScreenState extends State<SettingsMainScreen> {
  @override
  Widget build(BuildContext context) {
    final _scaffold = Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          "Settings".translate(),
          semanticsLabel: "Title".translate(),
        ),
      ),
      body: ListView(
        addAutomaticKeepAlives: true,
        addRepaintBoundaries: true,
        addSemanticIndexes: true,
        dragStartBehavior: DragStartBehavior.start,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        children: <SettingsTile>[
          // Language Setting
          SettingsTile(
            setting: AllSettings.languageSetting,
            icon: const Icon(Icons.language_rounded),
            simpleDialog: _languageDialog,
          ),

          // Theme Mode Setting
          SettingsTile(
            setting: AllSettings.themeModeSetting,
            icon: const Icon(Icons.color_lens),
            simpleDialog: _themeModeDialog,
          ),

          // Notifiaction Settings
          SettingsTile.folder(
            setting: Setting.folder(name: "Notifications".translate()),
            icon: const Icon(Icons.notifications),
            subtiles: <SettingsSubTile>[
              // Notifiations Active
              SettingsSubTile(
                setting: AllSettings.notificationActiveSetting,
                icon: AllSettings.notificationActiveSetting.boolValue!
                    ? const Icon(Icons.notifications_active_rounded)
                    : const Icon(Icons.notifications_rounded),
                uiSwitch: Switch.adaptive(
                  value: AllSettings.notificationActiveSetting.boolValue!,
                  onChanged: (_) {
                    setState(() {});
                  },
                ),
              ),
              SettingsSubTile(
                setting: AllSettings.notificationImportanceSetting,
                icon: const Icon(Icons.notification_important_rounded),
                simpleDialog: _notificationImportanceDialog,
              )
            ],
          ),
        ],
      ),
    );

    return _scaffold;
  }

  /// The Simple Dialog shown to choose your Language
  SimpleDialog get _languageDialog {
    final _dialog = SimpleDialog(
      elevation: 20.0,
      alignment: Alignment.center,
      backgroundColor: Colors.white,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      semanticLabel: "Choose your Language".translate(),
      title: Text("Choose your Language".translate()),
      children: <SimpleDialogOption>[
        // Option English
        SimpleDialogOption(
          onPressed: () {},
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blue.shade800,
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Text(
              "English".translate(),
              semanticsLabel: "English".translate(),
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),

        // Option German
        SimpleDialogOption(
          onPressed: () {},
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blue.shade800,
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Text(
              "German".translate(),
              semanticsLabel: "German".translate(),
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),

        // Cancel Button
        SimpleDialogOption(
          child: Center(
            child: Text(
              "Cancel".translate(),
              semanticsLabel: "Cancel".translate(),
              style: const TextStyle(
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          onPressed: () => Jumper.back(context),
        )
      ],
    );

    return _dialog;
  }

  /// The Simple Dialog to choose your Theme Mode
  /// This uses Radio Buttons to choose
  SimpleDialog get _themeModeDialog {
    final _dialog = SimpleDialog(
      title: Text("Choose your Theme Mode".translate()),
      semanticLabel: "Choose your Theme Mode".translate(),
      alignment: Alignment.center,
      children: <SimpleDialogOption>[
        SimpleDialogOption(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text(
                "System",
                semanticsLabel: "System",
              ),
              Radio(
                value: ThemeMode.system,
                groupValue: Themes.themeMode,
                onChanged: (_) {
                  setState(() {
                    Themes.themeMode = ThemeMode.system;
                  });
                },
              ),
            ],
          ),
        ),
        SimpleDialogOption(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Light".translate(),
                semanticsLabel: "Light".translate(),
              ),
              Radio(
                value: ThemeMode.light,
                groupValue: Themes.themeMode,
                onChanged: (_) {
                  setState(() {
                    Themes.themeMode = ThemeMode.light;
                  });
                },
              ),
            ],
          ),
        ),
        SimpleDialogOption(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Dark".translate(),
                semanticsLabel: "Dark".translate(),
              ),
              Radio(
                value: ThemeMode.dark,
                groupValue: Themes.themeMode,
                onChanged: (_) {
                  setState(() {
                    Themes.themeMode = ThemeMode.dark;
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );

    return _dialog;
  }

  SimpleDialog get _notificationImportanceDialog {
    final _dialog = SimpleDialog();

    return _dialog;
  }
}

/// Class that represents the SettingsSubScreen Arguments as a single Object
/// This can be used to extract the Arguments using the Named NAvigator
/// and routes
class SettingsSubScreenArguments {
  const SettingsSubScreenArguments({
    required this.subtiles,
    required this.folder,
  });

  final List<SettingsSubTile> subtiles;
  final Setting folder;
}

class SettingsSubScreen extends StatefulWidget {
  const SettingsSubScreen({
    required this.arguments,
    Key? key,
  }) : super(key: key);

  final SettingsSubScreenArguments arguments;

  static const routeName = "/settings/subSettings";

  @override
  State<SettingsSubScreen> createState() => _SettingsSubScreenState();
}

class _SettingsSubScreenState extends State<SettingsSubScreen> {
  @override
  Widget build(BuildContext context) {
    final _scaffold = Scaffold(
      appBar: AppBar(
        title: Text(widget.arguments.folder.name),
        automaticallyImplyLeading: true,
      ),
      body: ListView(
        addAutomaticKeepAlives: true,
        addRepaintBoundaries: true,
        addSemanticIndexes: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        dragStartBehavior: DragStartBehavior.start,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        children: widget.arguments.subtiles,
      ),
    );

    return _scaffold;
  }
}
