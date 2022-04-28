library screens;

import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';
import 'package:string_translate/string_translate.dart' show Translate;
import 'package:todo/main.dart' show TodoApp;
import 'package:todo/models/todo.dart' show Todo;
import 'package:todo/models/todo_list.dart';
import 'package:todo/screens/components/todo_details_tile.dart';
import 'package:todo/screens/edit_todo_screen.dart';

/// Screen which is shown when you click on a Todo.
/// Here you can see all the Details and Information
/// about the specified [todo].
/// The [todo] must not be null
class TodoDetailScreen extends StatefulWidget {
  const TodoDetailScreen({
    required this.todo,
    Key? key,
  }) : super(key: key);

  /// The Name of the Route for this Screen.
  /// Is used to navigate trough the App.
  /// These Values are set in the [MaterialApp] of the [TodoApp]
  static const routeName = '/todo_details';

  final Todo todo;

  @override
  State<TodoDetailScreen> createState() => _TodoDetailScreenState();
}

class _TodoDetailScreenState extends State<TodoDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final _scaffold = Scaffold(
      appBar: AppBar(
        title: Text(
          widget.todo.title,
          semanticsLabel: 'Title'.tr(),
        ),
        automaticallyImplyLeading: true,
      ),
      body: ListView(
        addAutomaticKeepAlives: true,
        addRepaintBoundaries: true,
        addSemanticIndexes: true,
        dragStartBehavior: DragStartBehavior.start,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        children: <TodoDetailsTile>[
          // Title
          TodoDetailsTile(
            title: 'Title:'.tr(),
            subtitle: widget.todo.title,
            function: () => Navigator.pushNamed(
              context,
              EditTodoScreen.routeName,
              arguments: widget.todo,
            ).then((value) => setState(() {})),
          ),

          // Content
          TodoDetailsTile(
            title: 'Content:'.tr(),
            subtitle: widget.todo.content,
            function: () => Navigator.pushNamed(
              context,
              EditTodoScreen.routeName,
              arguments: widget.todo,
            ).then((value) => setState(() {})),
          ),

          // Checked
          TodoDetailsTile(
            title: 'Checked:'.tr(),
            subtitle: widget.todo.checked ? 'Checked'.tr() : 'Not yet'.tr(),
          ),

          // Tags
          TodoDetailsTile(
            title: 'Tags'.tr(),
            subtitle: widget.todo.tags,
            function: () => Navigator.pushNamed(
              context,
              EditTodoScreen.routeName,
              arguments: widget.todo,
            ).then((value) {
              setState(() {
                TodoList.checkTags();
              });
            }),
          ),

          // Time
          /*  TodoDetailsTile(
            title: 'Time:',
            subtitle: widget.todo.onlyTime,
            function: _showBottomSheet,
          ),

          // Date
          TodoDetailsTile(
            title: 'Date:',
            subtitle: widget.todo.onlyDate,
            function: _showBottomSheet,
          ), */

          // Divider
          const TodoDetailsTile.divider(),

          // Created on Date and Time
          /*  TodoDetailsTile(
            title: 'Created on:',
            subtitle: widget.todo.createdAsString,
          ), */

          // Edit Button
          TodoDetailsTile.button(
            title: 'Edit'.tr(),
            function: () => Navigator.pushNamed(
              context,
              EditTodoScreen.routeName,
              arguments: widget.todo,
            ).then((value) => setState(() {})),
          )
        ],
      ),
    );

    return _scaffold;
  }
}
