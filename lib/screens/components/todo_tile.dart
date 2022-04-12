library components;

import 'package:flutter/material.dart';
import 'package:string_translate/string_translate.dart' show Translate;
import 'package:todo/models/todo.dart' show Todo;
import 'package:todo/models/todo_list.dart';
import 'package:todo/screens/homescreen.dart';
import 'package:todo/screens/todo_detail_screen.dart';
import 'package:todo/storage/storage.dart';

/// A Tile to represent a single Todo in the [Homescreen]
class TodoTile extends StatefulWidget {
  const TodoTile({
    required this.todo,
    required this.setStateFunc,
    Key? key,
  }) : super(key: key);

  final Todo todo;
  final void Function() setStateFunc;

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
        onChanged: (_) => _onChecked(),
      ),
      // Title
      title: Text(
        widget.todo.title,
        semanticsLabel: 'Todo Title'.tr(),
      ),
      // Time
      /* subtitle: Text(
        widget.todo.timeAsString,
        semanticsLabel: 'Todo Time'.tr(),
      ), */
      subtitle: Text(
        widget.todo.content,
        semanticsLabel: 'Todo Content'.tr(),
      ),
      onTap: _onTap,
      textColor: widget.todo.checked
          ? Colors.grey.shade400
          : Theme.of(context).listTileTheme.textColor,
    );

    return _tile;
  }

  void _onTap() {
    if (TodoList.todoMarked) {
      setState(() {
        widget.todo.selected = !widget.todo.selected;
      });
      widget.setStateFunc;
    } else {
      Navigator.pushNamed(
        context,
        TodoDetailScreen.routeName,
        arguments: widget.todo,
      ).then(
        (value) => setState(() {}),
      );
    }
  }

  /// Function called when the Tile is selected
  /// This give you new Options like delete or archive
  void _onSelected() {
    setState(() {
      widget.todo.selected = !widget.todo.selected;
    });
    widget.setStateFunc();
  }

  /// Function called when the Todo is checked
  /// and marked as done.
  void _onChecked() {
    setState(() {
      widget.todo.checked = !widget.todo.checked;
      if (widget.todo.checked == true) {
        TodoList.checkTodo(widget.todo);
      } else if (widget.todo.checked == false) {
        TodoList.uncheckTodo(widget.todo);
      } else {
        // Do nothing
      }
      widget.setStateFunc();
    });
    Storage.storeTodos();
  }
}
