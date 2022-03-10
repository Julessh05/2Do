library components;

import 'package:flutter/material.dart';
import 'package:todo/logic/translate.dart';
import 'package:todo/models/search_results.dart';
import 'package:todo/screens/search_screen.dart';

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
    final _tile = ListTile(
      autofocus: false,
      enabled: true,
      isThreeLine: false,
      title: Text(widget.result.name),
      leading: widget.result.isTodo
          ? const Icon(Icons.notifications_active)
          : const Icon(Icons.settings),
      subtitle: Text(
        widget.result.isTodo ? "Todo".translate() : "Setting".translate(),
      ),
    );

    return _tile;
  }
}