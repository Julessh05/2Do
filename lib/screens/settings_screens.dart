library screens;

import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';
import 'package:todo/logic/jumper.dart';
import 'package:string_translate/string_translate.dart'
    show Translate, Translation;
import 'package:todo/main.dart' show TodoApp;
import 'package:todo/models/setting.dart' show Setting, AllSettings;
import 'package:todo/notifications/notifications.dart';
import 'package:todo/screens/color_chooser.dart' show ColorChooser;
import 'package:todo/screens/components/settings_sub_tile.dart';
import 'package:todo/screens/components/settings_tile.dart';
import 'package:todo/storage/storage.dart';
import 'package:todo/styles/coloring.dart';
import 'package:todo/styles/themes.dart';

/// The Main Settings Screen from which you can navigate
/// to the other Settings Screens and can set the Value of the Settings
class SettingsMainScreen extends StatefulWidget {
  const SettingsMainScreen({Key? key}) : super(key: key);

  static const routeName = '/settings';

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
          'Settings'.tr(),
          semanticsLabel: 'Title'.tr(),
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
            simpleDialogFunc: _languageDialog,
          ),

          // Theme Mode Setting
          SettingsTile(
            setting: AllSettings.themeModeSetting,
            icon: const Icon(Icons.color_lens),
            simpleDialog: _themeModeDialog,
          ),

          // Color Setting
          SettingsTile(
            setting: AllSettings.color,
            icon: const Icon(Icons.colorize_rounded),
            newScreenRouteName: ColorChooser.routeName,
            newScreenArguments: null,
          ),

          // Notification Settings
          /*  SettingsTile.folder(
            setting: Setting.folder(name: 'Notifications'.tr()),
            icon: const Icon(Icons.notifications),
            subtiles: <SettingsSubTile>[
              // Notifications Active
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
          ), */

          /* About Settings Tile */
          SettingsTile(
            setting: AllSettings.about,
            icon: const Icon(Icons.info_outline_rounded),
            aboutDialog: const AboutDialog(
              applicationIcon: Icon(Icons.check),
              applicationName: '2Do',
              applicationVersion: TodoApp.appVersionString,
              children: <Widget>[
                Text('\n'),
                Text('A Todo App built with Flutter,'),
                Text('a UI Framework by Google.'),
                Text('Available on Android and IOS'),
              ],
              applicationLegalese: '© Julian Schumacher 2022',
            ),
          )
        ],
      ),
    );

    return _scaffold;
  }

  /// Method called when a Setting is changed
  /// Is responsible for calling setState and updating
  /// the Value to Display of the Settings
  void _reload() {
    setState(() {
      AllSettings.updateSettings();
      Storage.storeSettings();
    });
  }

  /// The Simple Dialog shown to choose your Language
  SimpleDialog _languageDialog() {
    final _dialog = SimpleDialog(
      elevation: 20.0,
      alignment: Alignment.center,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      semanticLabel: 'Choose your Language'.tr(),
      title: Text('Choose your Language'.tr()),
      children: <SimpleDialogOption>[
        // Option English
        SimpleDialogOption(
          onPressed: () {
            Translation.activeLocale = const Locale('en', 'US');
            _reload();
            Jumper.back(context);
          },
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Coloring.mainColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Text(
              'English'.tr(),
              semanticsLabel: 'English'.tr(),
              style: TextStyle(
                color: Coloring.accentColor,
              ),
            ),
          ),
        ),

        // Option German
        SimpleDialogOption(
          onPressed: () {
            Translation.activeLocale = const Locale('de', 'DE');
            _reload();
            Jumper.back(context);
          },
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Coloring.mainColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Text(
              'German'.tr(),
              semanticsLabel: 'German'.tr(),
              style: TextStyle(
                color: Coloring.accentColor,
              ),
            ),
          ),
        ),

        // Option French
        SimpleDialogOption(
          onPressed: () {
            Translation.activeLocale = const Locale('fr', 'FR');
            _reload();
            Jumper.back(context);
          },
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Coloring.mainColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Text(
              'French'.tr(),
              semanticsLabel: 'French'.tr(),
              style: TextStyle(
                color: Coloring.accentColor,
              ),
            ),
          ),
        ),

        // Cancel Button
        SimpleDialogOption(
          child: Center(
            child: Text(
              'Cancel'.tr(),
              semanticsLabel: 'Cancel'.tr(),
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
      title: Text('Choose your Theme Mode'.tr()),
      semanticLabel: 'Choose your Theme Mode'.tr(),
      alignment: Alignment.center,
      children: <SimpleDialogOption>[
        // Option System
        SimpleDialogOption(
          child: RadioListTile(
            autofocus: false,
            enableFeedback: true,
            isThreeLine: false,
            toggleable: true,
            title: Text(
              'System'.tr(),
              semanticsLabel: 'System'.tr(),
            ),
            value: ThemeMode.system,
            groupValue: Themes.themeMode,
            onChanged: (_) => _changeThemeMode(ThemeMode.system),
          ),
        ),

        // Option Light
        SimpleDialogOption(
          child: RadioListTile(
            autofocus: false,
            enableFeedback: true,
            isThreeLine: false,
            toggleable: true,
            title: Text(
              'Light'.tr(),
              semanticsLabel: 'Light'.tr(),
            ),
            value: ThemeMode.light,
            groupValue: Themes.themeMode,
            onChanged: (_) => _changeThemeMode(ThemeMode.light),
          ),
        ),

        // Option Dark
        SimpleDialogOption(
          child: RadioListTile(
            autofocus: false,
            enableFeedback: true,
            isThreeLine: false,
            toggleable: true,
            value: ThemeMode.dark,
            groupValue: Themes.themeMode,
            onChanged: (_) => _changeThemeMode(ThemeMode.dark),
            title: Text(
              'Dark'.tr(),
              semanticsLabel: 'Dark'.tr(),
            ),
          ),
        ),
      ],
    );

    return _dialog;
  }

  /// Method called when the ThemeMode is changed.
  /// Passes the Value to the Stream used to build the App
  /// Then pops the Dialog with Jumper.back(context)
  void _changeThemeMode(ThemeMode mode) {
    setState(() {
      TodoApp.themeStream.sink.add(mode);
      Themes.themeMode = mode;
      _reload();
    });
    Jumper.back(context);
  }

  /// Dialog to choose the Importance of your Notifications
  /// This is used to determine whether your importance should interrupt
  /// or not
  SimpleDialog get _notificationImportanceDialog {
    final _dialog = SimpleDialog(
      alignment: Alignment.center,
      title: Text('Choose an Standard Importance'.tr()),
      children: <SimpleDialogOption>[
        SimpleDialogOption(
          child: RadioListTile(
            autofocus: false,
            enableFeedback: true,
            isThreeLine: false,
            title: Text(
              'unimportant'.tr(),
              semanticsLabel: 'unimportant'.tr(),
            ),
            value: 0,
            groupValue: Notifications.standardImportance,
            onChanged: (_) {},
          ),
        ),
        SimpleDialogOption(
          child: RadioListTile(
            autofocus: false,
            enableFeedback: true,
            isThreeLine: false,
            title: Text(
              'middle Importance'.tr(),
              semanticsLabel: 'middle Importance'.tr(),
            ),
            value: 1,
            groupValue: Notifications.standardImportance,
            onChanged: (_) {},
          ),
        )
      ],
    );

    return _dialog;
  }
}

/// Class that represents the SettingsSubScreen Arguments as a single Object
/// This can be used to extract the Arguments using the Named Navigator
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

  static const routeName = '/settings/subSettings';

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
