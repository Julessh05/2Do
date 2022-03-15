library screens;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:todo/logic/jumper.dart';
import 'package:todo/logic/translate.dart';
import 'package:todo/models/search_results.dart';
import 'package:todo/models/setting.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/models/todo_list.dart';
import 'package:todo/screens/components/search_result_tile.dart';

/// Screen shown when the User searches something
class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  static const routeName = "/search";

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    final _controller = TextEditingController();

    final _scaffold = Scaffold(
      appBar: AppBar(
        title: TextField(
          autocorrect: true,
          autofocus: true,
          controller: _controller,
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
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            alignLabelWithHint: true,
            enabled: true,
            filled: false,
            floatingLabelAlignment: FloatingLabelAlignment.start,
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            hintText: "Search something...".translate(),
            hintStyle: const TextStyle(
              color: Colors.white,
            ),
            border: const UnderlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              borderSide: BorderSide(
                color: Colors.white70,
                style: BorderStyle.solid,
                width: 1.5,
              ),
            ),
            errorBorder: const UnderlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              borderSide: BorderSide(
                color: Colors.white70,
                style: BorderStyle.solid,
                width: 1.5,
              ),
            ),
            enabledBorder: const UnderlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              borderSide: BorderSide(
                color: Colors.white70,
                style: BorderStyle.solid,
                width: 1.5,
              ),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              borderSide: BorderSide(
                color: Colors.white70,
                style: BorderStyle.solid,
                width: 1.5,
              ),
            ),
            disabledBorder: const UnderlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              borderSide: BorderSide(
                color: Colors.white70,
                style: BorderStyle.solid,
                width: 1.5,
              ),
            ),
            focusedErrorBorder: const UnderlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
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

    return _scaffold;
  }

  /// Searchs in the [listOfTodos] and [listOfSettings]
  /// and navigates to a new Screen.
  /// This eigther shows the results or says "No Results found"
  void _search(String input) {
    List<SearchResult> listOfResults = [];

    // Search Todos
    for (Todo todo in TodoList.listOfTodos) {
      if (todo.title == input) {
        // If Todo matches, create Search Result and add it to the list
        final _result = SearchResult(todo: todo);
        listOfResults.add(_result);
      } else {
        continue;
      }
    }

    // Search Settings
    for (Setting setting in listOfSettings) {
      if (setting.name == input) {
        // If Setting matches, create Search Result and add it to the list
        final _result = SearchResult(setting: setting);
        listOfResults.add(_result);
      }
    }

    final _results = SearchResultsList(searchResults: listOfResults);
    Jumper.openSearchResultsScreen(context, _results);
  }
}

/// Screen that shows the Results (of there are any).
/// If not it will show a Message which says "No Results found"
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

  static const routeName = "/search/results";

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  @override
  Widget build(BuildContext context) {
    final _scaffold = Scaffold(
      appBar: appBar,
      body: body,
    );

    return _scaffold;
  }

  AppBar get appBar {
    if (widget.hasResults) {
      return AppBar(
        automaticallyImplyLeading: true,
        title: Text("Search Results".translate()),
      );
    } else {
      return AppBar(
        automaticallyImplyLeading: true,
        title: Text("No Results".translate()),
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
                "No Results were found".translate(),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () => Jumper.backToTheHomescreen(context),
                child: Text(
                  "Back to the Homescreen".translate(),
                  semanticsLabel: "Back to the Homescreen".translate(),
                ),
                autofocus: false,
                clipBehavior: Clip.antiAliasWithSaveLayer,
              ),
            ],
          ),
        ),
      );
    }
  }
}
