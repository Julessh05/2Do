library components;

import 'package:flutter/material.dart';
import 'package:string_translate/string_translate.dart' show Translate;
import 'package:todo/models/search_results.dart' show SearchResult;
import 'package:todo/screens/search_screen.dart' show SearchResultScreen;
import 'package:todo/screens/settings_screens.dart' show SettingsMainScreen;
import 'package:todo/screens/sorted_todo_screen.dart';
import 'package:todo/screens/todo_detail_screen.dart';

/// Component which represents a single Search Result
/// in the [SearchResultScreen]
class SearchResulTile extends StatefulWidget {
  const SearchResulTile({
    required this.result,
    Key? key,
  }) : super(key: key);

  final SearchResult result;

  @override
  State<SearchResulTile> createState() => _SearchResulTileState();
}

class _SearchResulTileState extends State<SearchResulTile> {
  @override
  Widget build(BuildContext context) {
    final tile = ListTile(
      autofocus: false,
      enabled: true,
      isThreeLine: false,
      title: Text(widget.result.name),
      leading: widget.result.isTodo
          ? const Icon(Icons.notifications_active)
          : const Icon(Icons.settings),
      subtitle: Text(_subtitle),
      onTap: _openResult,
    );

    return tile;
  }

  String get _subtitle {
    if (widget.result.isSetting) {
      return 'Setting'.tr();
    } else if (widget.result.isTodo) {
      return 'Todo'.tr();
    } else if (widget.result.isTag) {
      return 'Tag'.tr();
    } else {
      return 'Unspecified';
    }
  }

  void _openResult() {
    if (widget.result.isTodo) {
      Navigator.pushNamed(
        context,
        TodoDetailScreen.routeName,
        arguments: widget.result.todo,
      ).then((value) => setState(() {}));
    } else if (widget.result.isSetting) {
      Navigator.pushNamed(
        context,
        SettingsMainScreen.routeName,
      ).then((value) => setState(() {}));
    } else if (widget.result.isTag) {
      Navigator.pushNamed(
        context,
        SortedTodoScreen.routeName,
        arguments: widget.result.tag,
      );
    } else {
      // Do nohing
    }
  }
}
