library models;

import 'package:string_translate/string_translate.dart' show Translate;
import 'package:todo/models/setting.dart' show Setting;
import 'package:todo/models/todo.dart' show Todo;

/// Object that holds a single Search Result
class SearchResult {
  final Todo? todo;
  final Setting? setting;
  final String? tag;

  const SearchResult({
    this.setting,
    this.todo,
    this.tag,
  }) : assert(
            todo != null && setting == null && tag == null ||
                todo == null && setting != null && tag == null ||
                todo == null && setting == null && tag != null,
            'You have to pass exactly one Parameter to create a Search Result');

  /// Returns true if the SearchResult is a Todo
  bool get isTodo => todo != null;

  /// Returns true if the SearchResult is a Setting
  bool get isSetting => setting != null;

  /// Returns true if the SearchResult is a Tag
  bool get isTag => tag != null;

  /// Returns the name / Type of the Search Result.
  /// So it returns the Title from a Todo, the Name of a Setting
  /// and the Tag as String
  String get name {
    if (isTodo) {
      return todo!.title;
    } else if (isSetting) {
      return setting!.name.tr();
    } else if (isTag) {
      return tag!;
    } else {
      return 'Error: Getting Name failed';
    }
  }
}

/// Object that holds all Search Results.
/// It also has a few other functions like [hasResults]
class SearchResultsList {
  const SearchResultsList({required this.searchResults});

  final List<SearchResult> searchResults;

  bool get hasResults => searchResults.isNotEmpty;
}
