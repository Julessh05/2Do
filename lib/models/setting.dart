import 'package:todo/logic/converter.dart';
import 'package:todo/logic/translate.dart';
import 'package:todo/models/identifiable_model.dart';
import 'package:todo/styles/themes.dart';

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
///   name: "Settings Name",
///   boolValue = true,
/// );
/// ```
///
/// Example with int:
/// ```dart
/// final _setting = Setting(
///   name: "Settings Name",
///   intValue: 4,
/// );
/// ```
///
/// Example with string
/// ```dart
/// final _setting = Setting(
///   name: "Settings Name",
///   stringValue: "Value of the Setting",
/// );
/// ```
///
/// Example with Object:
/// ```dart
/// final _setting = Setting(
///   name: "Settings Name",
///   objectValue: Colors.orange,
/// );
/// ```
///
/// This will throw an Error:
/// ```dart
/// final _setting = Setting(
///   name: "Settings Name",
///   intValue: 4,
///   stingValue: "4",
/// );
/// ```
///
/// Error would be: "You can only define one Value."
class Setting implements IdentifiableModel {
  final String name;
  bool? boolValue;
  int? intValue;
  String? stringValue;
  dynamic objectValue;
  late final Type _valueType;

  Setting({
    required this.name,
    this.boolValue,
    this.intValue,
    this.stringValue,
    this.objectValue,
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
                  objectValue != null,
          "You can only define one Value.",
        ) {
    if (boolValue != null) {
      _valueType = bool;
    } else if (intValue != null) {
      _valueType = int;
    } else if (stringValue != null) {
      _valueType = String;
    } else if (objectValue != null) {
      _valueType = Object;
    } else {
      _valueType = Error;
    }
  }

  /// Created an empty Setting.
  /// Can be used to have access to the [identifier] and [regExp] without
  /// having to create a complex Setting
  Setting.empty({
    this.name = "Placeholder",
  }) {
    _valueType = Null;
  }

  Setting.folder({
    required this.name,
  }) {
    _valueType = Null;
  }

  /// Returns the current State of the givven Value
  /// as String, no matter what kind of Object you put in
  String get valueAsString {
    switch (_valueType) {
      case bool:
        return boolValue.toString();
      case int:
        return intValue.toString();
      case String:
        return stringValue!;
      case Object:
        return objectValue.toString();
      default:
        return "Error parsing Value as String";
    }
  }

  Object get value {
    switch (_valueType) {
      case bool:
        return boolValue!;
      case int:
        return intValue!;
      case String:
        return stringValue!;
      case Object:
        return objectValue;
      default:
        return Error();
    }
  }

  String get typeAsString {
    final String _output;
    switch (_valueType) {
      case bool:
        _output = "bool";
        break;
      case int:
        _output = "int";
        break;
      case String:
        _output = "String";
        break;
      case Object:
        _output = Converter.supportedTypetoString(objectValue.runtimeType);
        break;
      default:
        _output = "Error";
        break;
    }
    return _output;
  }

  /// Returns the Setting as a Map of String : String
  Map<String, String> get asMap {
    final _map = <String, String>{
      "Name": name,
      "ValueType": _valueType.toString(),
      "Value": valueAsString,
    };

    return _map;
  }

  @override
  String toString() {
    String _result = "";

    // Add Name
    _result += "Name:";
    _result += name;

    // Add ValueType
    _result += "ValueType:";
    _result += typeAsString;

    // Add Value as String
    _result += "ValueAsString:";
    _result += Converter.supportedObjectToString(value, _valueType);

    return _result;
  }

  @override
  String get identifier => "Setting:";

  @override
  // TODO: implement regExp
  Pattern get regExp => throw UnimplementedError();
}

/// The List that holds all Settings
final List<Setting> listOfSettings = [
  AllSettings.languageSetting,
  AllSettings.themeModeSetting,
  AllSettings.notificationActiveSetting,
  AllSettings.notificationImportanceSetting,
  AllSettings.emptySetting,
];

/// Class that holds all Settings
class AllSettings {
  /// The Language Setting which gives information
  /// about the current language and Locale
  static final languageSetting = Setting(
    name: "Language",
    objectValue: Translation.activeLocale,
  );

  /// Gives Information about the Theme Mode
  static final themeModeSetting = Setting(
    name: "Thememode",
    objectValue: Themes.themeMode,
  );

  /// Gives Information if the Notifications are active
  static final notificationActiveSetting = Setting(
    name: "activated",
    boolValue: true,
  );

  static final emptySetting = Setting.empty();

  static final notificationImportanceSetting = Setting(
    name: "Importance",
    intValue: 1,
  );
}
