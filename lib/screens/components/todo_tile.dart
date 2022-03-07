library components;

import 'package:flutter/material.dart';
import 'package:todo/logic/translate.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/screens/homescreen.dart';
import 'package:todo/screens/todo_detail_screen.dart';

/// A Tile to represent a single Todo in the [Homescreen]
class TodoTile extends StatefulWidget {
  const TodoTile({
    required this.todo,
    Key? key,
  }) : super(key: key);

  final Todo todo;

  @override
  _TodoTileState createState() => _TodoTileState();
}

class _TodoTileState extends State<TodoTile> {
  @override
  Widget build(BuildContext context) {
    final _tile = ListTile(
      selected: widget.todo.selected,
      autofocus: false,
      isThreeLine: false,
      onLongPress: _onSelected,
      leading: Checkbox(
        autofocus: false,
        tristate: false,
        value: widget.todo.checked,
        onChanged: (_) => _onChecked,
      ),
      title: Text(
        widget.todo.title,
        semanticsLabel: "Todo Title".translate(),
      ),
      subtitle: Text(
        widget.todo.timeAsString,
        semanticsLabel: "Todo Time".translate(),
      ),
      onTap: _openTodoDetails,
    );

    return _tile;
  }

  /// Function called when the Tile is selected
  /// This give you new Options like delete or archive
  void _onSelected() {
    setState(() {
      widget.todo.selected = !widget.todo.selected;
    });
  }

  /// Funtion called when the Todo is checked
  /// and marked as done.
  void _onChecked() {
    setState(() {
      widget.todo.checked = !widget.todo.checked;
      if (widget.todo.checked == true) {
      } else {}
    });
  }

  /// Pushes the [TodoDetailScreen] on Top of the current Route.
  /// Passes a Todo, which is used in the TodoDetailsScreen to show the Todo
  /// and get the Information needed.
  void _openTodoDetails() {
    Navigator.pushNamed(
      context,
      TodoDetailScreen.routeName,
      arguments: widget.todo,
    );
  }
}
