library models;

import 'package:flutter/material.dart';
import 'package:hive/hive.dart'
    show
        HiveField,
        HiveType,
        HiveObject,
        TypeAdapter,
        BinaryReader,
        BinaryWriter;
import 'package:todo/app_values/brainstorm_values.dart';
import 'package:todo/logic/converter.dart' show Converter;
import 'package:string_translate/string_translate.dart'
    show Translate, Translation;
import 'package:todo/styles/coloring.dart' show Coloring;
import 'package:todo/styles/themes.dart';

part 'setting.g.dart';

/// Represents a single Setting in the App.
/// The [name] is the name of the Setting
/// You can only specify one Value.
/// Either [boolValue], [intValue], [stringValue]
/// or [objectValue]. In the Object Value you can store everything.
/// Choose the string, bool or int value if you store one of
/// those types, because it's easier and safer to store
///
/// Example with bool:
/// ```dart
/// final _setting = Setting(
///   name: 'Settings Name',
///   boolValue = true,
/// );
/// ```
///
/// Example with int:
/// ```dart
/// final _setting = Setting(
///   name: 'Settings Name',
///   intValue: 4,
/// );
/// ```
///
/// Example with String
/// ```dart
/// final _setting = Setting(
///   name: 'Settings Name',
///   stringValue: 'Value of the Setting',
/// );
/// ```
///
/// Example with Object:
/// ```dart
/// final _setting = Setting(
///   name: 'Settings Name',
///   objectValue: Colors.orange,
/// );
/// ```
///
/// This will throw an Error:
/// ```dart
/// final _setting = Setting(
///   name: 'Settings Name',
///   intValue: 4,
///   stingValue: '4',
/// );
/// ```
///
/// Error would be: 'You can only define one Value.'
@HiveType(typeId: 0)
class Setting extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  bool? boolValue;

  @HiveField(2)
  int? intValue;

  @HiveField(3)
  String? stringValue;

  @HiveField(4)
  dynamic objectValue;

  @HiveField(5)
  late String valueType;

  @HiveField(6)
  late String hiveKey;

  @HiveField(7)
  bool? isObject;

  @HiveField(8)
  String? isObjectType;

  @HiveField(9)
  String? subtitle;

  Setting({
    required this.name,
    this.boolValue,
    this.intValue,
    this.stringValue,
    this.objectValue,
    this.isObject,
    this.isObjectType,
  }) : assert(
          boolValue != null &&
                  intValue == null &&
                  stringValue == null &&
                  objectValue == null ||
              boolValue == null &&
                  intValue != null &&
                  stringValue == null &&
                  objectValue == null ||
              boolValue == null &&
                  intValue == null &&
                  stringValue != null &&
                  objectValue == null ||
              boolValue == null &&
                  intValue == null &&
                  stringValue == null &&
                  objectValue != null ||
              boolValue == null &&
                  intValue == null &&
                  stringValue == null &&
                  objectValue == null,
          'You can only define one Value. No Value is accepted if you create a Setting.empty or a Setting.folder',
        ) {
    if (boolValue != null) {
      valueType = 'bool';
    } else if (intValue != null) {
      valueType = 'int';
    } else if (stringValue != null) {
      valueType = 'String';
    } else if (objectValue != null) {
      valueType = 'Object';
    } else {
      valueType = 'Null';
    }
    hiveKey = name;
  }

  /// Created an empty Setting.
  Setting.empty({
    this.name = 'Placeholder',
  }) {
    valueType = 'Null';
    hiveKey = 'Empty Setting';
  }

  Setting.folder({
    required this.name,
    this.subtitle,
  }) {
    valueType = 'folder';
    hiveKey = 'Folder';
  }

  /// Returns the current State of the givven Value
  /// as String, no matter what kind of Object you put in
  String get valueAsString {
    switch (valueType) {
      case 'bool':
        return Converter.supportedObjectToDisplayableString(boolValue, true);
      case 'int':
        return intValue.toString();
      case 'String':
        return stringValue!;
      case 'Object':
        return objectValue.toString();
      default:
        return 'Error parsing Value as String';
    }
  }

  /// Returns the Value of the Setting.
  /// This Method detects which Value is given and returns it.
  Object get value {
    switch (valueType) {
      case 'bool':
        return boolValue!;
      case 'int':
        return intValue!;
      case 'String':
        return stringValue!;
      case 'Object':
        return objectValue;
      default:
        return Error();
    }
  }

  /// Returns the Type of the Setting as a String
  String get typeAsString {
    final String output;
    switch (valueType) {
      case 'bool':
        output = 'bool';
        break;
      case 'int':
        output = 'int';
        break;
      case 'String':
        output = 'String';
        break;
      case 'Object':
        output = Converter.supportedTypeToString(objectValue.runtimeType);
        break;
      default:
        output = 'Error';
        break;
    }
    return output;
  }

  /// Returns the Value to display as a String
  String get valueToDisplay {
    if (valueType == 'int') {
      return intValue.toString();
    } else if (valueType == 'String') {
      return stringValue!.tr();
    } else if (valueType == 'bool') {
      return Converter.supportedObjectToDisplayableString(boolValue, true);
    } else if (valueType == 'folder') {
      return subtitle!;
    } else {
      return Converter.supportedObjectToDisplayableString(objectValue, true);
    }
  }

  /// Returns the Setting as a Map of String : String
  Map<String, String> get asMap {
    final map = <String, String>{
      'Name': name,
      'ValueType': valueType.toString(),
      'Value': valueAsString,
    };

    return map;
  }

  @override
  String toString() {
    String result = '';

    // Add Name
    result += 'Name:';
    result += name;

    // Add ValueType
    result += 'ValueType:';
    result += typeAsString;

    // Add Value as String
    result += 'ValueAsString:';
    result += Converter.supportedObjectToDisplayableString(value, true);

    return result;
  }
}

/// The List that holds all Settings
List<Setting> listOfSettings = [
  AllSettings.languageSetting,
  AllSettings.themeModeSetting,
  AllSettings.brainstormTitle,
  AllSettings.brainstormFlying,
  // AllSettings.notificationActiveSetting,
  // AllSettings.notificationImportanceSetting,
  AllSettings.about,
];

/// Class that holds all Settings
class AllSettings {
  /// The Language Setting which gives information
  /// about the current language and Locale
  static final languageSetting = Setting(
    name: 'Language',
    objectValue: Translation.activeLocale,
    isObject: true,
    isObjectType: 'Locale',
  );

  /// Gives Information about the Theme Mode
  static final themeModeSetting = Setting(
    name: 'Thememode',
    objectValue: Themes.themeMode,
    isObject: true,
    isObjectType: 'ThemeMode',
  );

  /// Gives Information if the Notifications are active
  static final notificationActiveSetting = Setting(
    name: 'activated',
    boolValue: true,
  );

  /// Setting that controls the Importance of the Notifications
  static final notificationImportanceSetting = Setting(
    name: 'Importance',
    intValue: 1,
  );

  /// About Setting that has no interaction.
  /// This does only provide the Information for
  /// the about Dialog
  static final about = Setting(
    name: 'About',
    stringValue: 'Everything about the App',
  );

  /// Setting that controls the Main Color used in the App
  static final color = Setting(
    name: 'Color',
    objectValue: Coloring.mainColor,
    isObject: true,
    isObjectType: 'Color',
  );

  /// Setting to control whether the Brainstorm Notes have
  /// a Title or not
  static final brainstormTitle = Setting(
    name: 'Title',
    boolValue: BrainstormValues.title,
  );

  /// Setting to control whether to Flying Mode is active
  static final brainstormFlying = Setting(
    name: 'Flying Mode',
    boolValue: BrainstormValues.flying,
  );

  /// Key of the List of Settings
  static const listOfSettingsKEY = 'List Of Settings';

  /// Updates The Settings to the most recent Value
  static void updateSettings() {
    languageSetting.objectValue = Translation.activeLocale;
    themeModeSetting.objectValue = Themes.themeMode;
    color.objectValue = Coloring.mainColor;
    brainstormTitle.boolValue = BrainstormValues.title;
    brainstormFlying.boolValue = BrainstormValues.flying;
    createListOfSettings();
  }

  /// Sets the Values and the Settings.
  /// Used whe starting the App
  static void setAllSettings(BuildContext context) {
    for (Setting setting in listOfSettings) {
      switch (setting.name) {
        case 'Language':
          Translation.changeLanguage(setting.objectValue);
          break;
        case 'Thememode':
          Themes.setThemeMode(setting.objectValue, context);
          break;
        case 'Color':
          Coloring.mainColor = setting.objectValue;
          break;
        case 'Title':
          BrainstormValues.title = setting.boolValue!;
          break;
        case 'Flying Mode':
          BrainstormValues.flying = setting.boolValue!;
          break;
      }
    }
    updateSettings();
  }

  /// Creates the ListOfSettings and sets it to the new values
  static void createListOfSettings() {
    listOfSettings = [
      languageSetting,
      themeModeSetting,
      color,
      brainstormTitle,
      brainstormFlying,
      // notificationActiveSetting,
      // notificationImportanceSetting,
      about,
    ];
  }
}
