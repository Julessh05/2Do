library screens;

import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';
import 'package:todo/logic/jumper.dart';
import 'package:string_translate/string_translate.dart' show Translate;
import 'package:todo/main.dart' show TodoApp;
import 'package:todo/models/search_results.dart';
import 'package:todo/models/setting.dart' show Setting, listOfSettings;
import 'package:todo/models/todo.dart' show Todo;
import 'package:todo/models/todo_list.dart';
import 'package:todo/screens/components/search_result_tile.dart';
import 'package:modern_themes/modern_themes.dart' show Coloring;

/// Screen shown when the User searches something
class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  /// The Name of the Route for this Screen.
  /// Is used to navigate trough the App.
  /// These Values are set in the [MaterialApp] of the [TodoApp]
  static const routeName = '/search';

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          autocorrect: true,
          autofocus: true,
          controller: controller,
          enableIMEPersonalizedLearning: true,
          enableInteractiveSelection: true,
          enableSuggestions: true,
          enabled: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          dragStartBehavior: DragStartBehavior.start,
          keyboardAppearance: Theme.of(context).brightness,
          keyboardType: TextInputType.text,
          maxLines: 1,
          minLines: 1,
          obscureText: false,
          readOnly: false,
          smartDashesType: SmartDashesType.enabled,
          smartQuotesType: SmartQuotesType.enabled,
          textAlign: TextAlign.start,
          textAlignVertical: TextAlignVertical.center,
          textCapitalization: TextCapitalization.words,
          textDirection: TextDirection.ltr,
          textInputAction: TextInputAction.search,
          toolbarOptions: const ToolbarOptions(
            copy: true,
            cut: true,
            paste: true,
            selectAll: true,
          ),
          style: TextStyle(color: Coloring.secondaryColor),
          decoration: InputDecoration(
            alignLabelWithHint: true,
            enabled: true,
            filled: false,
            floatingLabelAlignment: FloatingLabelAlignment.start,
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            hintText: 'Search something...'.tr(),
            hintStyle: TextStyle(
              color: Coloring.secondaryColor,
            ),
            border: const UnderlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(05),
              ),
              borderSide: BorderSide(
                color: Colors.white70,
                style: BorderStyle.solid,
                width: 1.5,
              ),
            ),
            errorBorder: const UnderlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(05),
              ),
              borderSide: BorderSide(
                color: Colors.white70,
                style: BorderStyle.solid,
                width: 1.5,
              ),
            ),
            enabledBorder: const UnderlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(05),
              ),
              borderSide: BorderSide(
                color: Colors.white70,
                style: BorderStyle.solid,
                width: 1.5,
              ),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(05),
              ),
              borderSide: BorderSide(
                color: Colors.white70,
                style: BorderStyle.solid,
                width: 1.5,
              ),
            ),
            disabledBorder: const UnderlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(05),
              ),
              borderSide: BorderSide(
                color: Colors.white70,
                style: BorderStyle.solid,
                width: 1.5,
              ),
            ),
            focusedErrorBorder: const UnderlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(05),
              ),
              borderSide: BorderSide(
                color: Colors.white70,
                style: BorderStyle.solid,
                width: 0.5,
              ),
            ),
          ),
          onSubmitted: (value) => _search(value),
        ),
        automaticallyImplyLeading: true,
      ),
    );
  }

  /// Searchs in the [TodoList.listOfTodos] and [listOfSettings]
  /// and navigates to a new Screen.
  /// This eigther shows the results or says 'No Results found'
  void _search(String input) {
    List<SearchResult> listOfResults = [];

    // Search Todos
    for (Todo todo in TodoList.listOfTodos) {
      for (String tag in todo.tagsAsList) {
        if (tag.toLowerCase().contains(input.toLowerCase())) {
          final result = SearchResult(todo: todo);
          listOfResults.add(result);
        } else {
          continue;
        }
      }

      if (todo.title.toLowerCase().contains(input.toLowerCase())) {
        // If Todo matches, create Search Result and add it to the list
        final result = SearchResult(todo: todo);
        listOfResults.add(result);
      } else if (todo.content.toLowerCase().contains(input.toLowerCase())) {
        final result = SearchResult(todo: todo);
        listOfResults.add(result);
      } else {
        continue;
      }
    }

    // Search Settings
    for (Setting setting in listOfSettings) {
      if (setting.name.tr().toLowerCase().contains(input.toLowerCase())) {
        // If Setting matches, create Search Result and add it to the list
        final result = SearchResult(setting: setting);
        listOfResults.add(result);
      }
    }

    for (String tag in TodoList.tags) {
      if (tag.toLowerCase().contains(input.toLowerCase())) {
        final result = SearchResult(tag: tag);

        listOfResults.add(result);
      }
    }

    final results = SearchResultsList(searchResults: listOfResults);
    Jumper.openSearchResultsScreen(context, results);
  }
}

/// Screen that shows the Results (of there are any).
/// If not it will show a Message which says 'No Results found'
class SearchResultScreen extends StatefulWidget {
  final bool hasResults;

  const SearchResultScreen({
    required this.searchResultsList,
    this.hasResults = true,
    Key? key,
  }) : super(key: key);

  /// Creates a Screen that shows a Information, that no
  /// Results were found
  const SearchResultScreen.noResults({
    this.searchResultsList = const SearchResultsList(searchResults: []),
    this.hasResults = false,
    Key? key,
  }) : super(key: key);

  final SearchResultsList searchResultsList;

  /// The Name of the Route for this Screen.
  /// Is used to navigate trough the App.
  /// These Values are set in the [MaterialApp] of the [TodoApp]
  static const routeName = '/search/results';

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: body,
    );
  }

  AppBar get appBar {
    if (widget.hasResults) {
      return AppBar(
        automaticallyImplyLeading: true,
        title: Text('Search Results'.tr()),
      );
    } else {
      return AppBar(
        automaticallyImplyLeading: true,
        title: Text('No Results'.tr()),
      );
    }
  }

  Widget get body {
    if (widget.hasResults) {
      return ListView.builder(
        addAutomaticKeepAlives: true,
        addRepaintBoundaries: true,
        addSemanticIndexes: true,
        dragStartBehavior: DragStartBehavior.start,
        scrollDirection: Axis.vertical,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const BouncingScrollPhysics(),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        itemBuilder: (_, counter) {
          return SearchResulTile(
            result: widget.searchResultsList.searchResults[counter],
          );
        },
        itemCount: widget.searchResultsList.searchResults.length,
      );
    } else {
      return Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 1.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            textBaseline: TextBaseline.alphabetic,
            textDirection: TextDirection.ltr,
            verticalDirection: VerticalDirection.down,
            children: <Widget>[
              Text(
                'No Results were found'.tr(),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () => Jumper.backToTheHomescreen(context),
                autofocus: false,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Text(
                  'Back to the Homescreen'.tr(),
                  semanticsLabel: 'Back to the Homescreen'.tr(),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
