library components;

import 'package:flutter/material.dart';
import 'package:todo/logic/translate.dart';
import 'package:todo/screens/todo_detail_screen.dart';

/// A single Tile in the [TodoDetailScreen] to show
/// one piece of Information from the Todo
class TodoDetailsTile extends StatefulWidget {
  /// A single Tile in the [TodoDetailScreen] to show
  /// one piece of Information from the Todo
  const TodoDetailsTile({
    required this.title,
    this.subtitle = "",
    this.icon,
    Key? key,
  }) : super(key: key);

  /// An empty divider used to organise the Details visually
  const TodoDetailsTile.divider({
    this.title = "",
    this.subtitle = "",
    this.icon,
    Key? key,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final Icon? icon;

  @override
  State<TodoDetailsTile> createState() => _TodoDetailsTileState();
}

class _TodoDetailsTileState extends State<TodoDetailsTile> {
  @override
  Widget build(BuildContext context) {
    final _tile = ListTile(
      autofocus: false,
      title: Text(
        widget.title,
        semanticsLabel: "Title".translate(),
      ),
      subtitle: Text(
        widget.subtitle,
        semanticsLabel: "Value of the Info".translate(),
      ),
      enabled: true,
      leading: widget.icon,
      isThreeLine: false,
    );

    return _tile;
  }
}
