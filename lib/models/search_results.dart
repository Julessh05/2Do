library models;

import 'package:todo/models/setting.dart';
import 'package:todo/models/todo.dart';

/// Object that holds a single Search Result
class SearchResult {
  final Todo? todo;
  final Setting? setting;

  const SearchResult({
    this.setting,
    this.todo,
  });

  bool get isTodo => todo != null;

  String get name {
    if (isTodo) {
      return todo!.title;
    } else if (!isTodo) {
      return setting!.name;
    } else {
      return "Error: Getting Name failed";
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
