library screens;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:todo/logic/translate.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/screens/components/todo_details_tile.dart';

class TodoDetailScreen extends StatefulWidget {
  const TodoDetailScreen({
    required this.todo,
    Key? key,
  }) : super(key: key);

  static const routeName = "/todo_details";

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
          semanticsLabel: "Title".translate(),
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
            title: "Title:",
            subtitle: widget.todo.title,
          ),

          // Content
          TodoDetailsTile(
            title: "Content:",
            subtitle: widget.todo.content,
          ),

          // Time
          TodoDetailsTile(
            title: "Time:",
            subtitle: widget.todo.onlyTime,
          ),

          // Date
          TodoDetailsTile(
            title: "Date:",
            subtitle: widget.todo.onlyDate,
          ),

          // Divider
          const TodoDetailsTile.divider(),

          // Created on Date and Time
          TodoDetailsTile(
            title: "Created on:",
            subtitle: widget.todo.createdAsString,
          )
        ],
      ),
    );

    return _scaffold;
  }
}
