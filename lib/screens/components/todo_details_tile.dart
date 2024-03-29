library components;

import 'package:flutter/material.dart';
import 'package:string_translate/string_translate.dart' show Translate;
import 'package:todo/screens/todo_detail_screen.dart';

/// A single Tile in the [TodoDetailScreen] to show
/// one piece of Information from the Todo
class TodoDetailsTile extends StatefulWidget {
  /// A single Tile in the [TodoDetailScreen] to show
  /// one piece of Information from the Todo
  /// The [isButton] have to be false
  /// The [function] should be null
  const TodoDetailsTile({
    required this.title,
    this.subtitle = '',
    this.icon,
    Key? key,
    this.isButton = false,
    this.function,
  }) : super(key: key);

  /// An empty divider used to organise the Details visually
  /// The [isButton] have to be false
  /// The [function] should be null
  const TodoDetailsTile.divider({
    this.title = '',
    this.subtitle = '',
    this.icon,
    this.isButton = false,
    this.function,
    Key? key,
  }) : super(key: key);

  /// Created a Button as a Todo Tile
  /// The function must be provided, and the isButton have
  /// to be true
  const TodoDetailsTile.button({
    required this.title,
    required this.function,
    this.subtitle = '',
    this.icon,
    this.isButton = true,
    Key? key,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final Icon? icon;
  final bool isButton;
  final void Function()? function;

  @override
  State<TodoDetailsTile> createState() => _TodoDetailsTileState();
}

class _TodoDetailsTileState extends State<TodoDetailsTile> {
  @override
  Widget build(BuildContext context) {
    final Widget tile;
    if (widget.isButton) {
      // Fitted Box to make Button not appear
      // in the whole width
      tile = FittedBox(
        alignment: Alignment.center,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        fit: BoxFit.scaleDown,
        child: TextButton(
          autofocus: false,
          onPressed: widget.function,
          child: Text(widget.title),
        ),
      );
    } else {
      tile = ListTile(
        autofocus: false,
        title: Text(
          widget.title,
          semanticsLabel: 'Title'.tr(),
        ),
        subtitle: Text(
          widget.subtitle,
          semanticsLabel: 'Value of the Info'.tr(),
        ),
        enabled: true,
        leading: widget.icon,
        isThreeLine: false,
        onTap: widget.function,
      );
    }
    return tile;
  }
}
