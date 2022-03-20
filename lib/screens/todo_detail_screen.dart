library screens;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo/logic/jumper.dart';
import 'package:todo/logic/translate.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/screens/components/todo_details_tile.dart';
import 'package:todo/storage/storage.dart';

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

class _TodoDetailScreenState extends State<TodoDetailScreen>
    with TickerProviderStateMixin {
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
            title: "Title:".translate(),
            subtitle: widget.todo.title,
            function: () => Navigator.pushNamed(
              context,
              EditTodoScreen.routeName,
              arguments: widget.todo,
            ).then((value) => setState(() {})),
          ),

          // Content
          TodoDetailsTile(
            title: "Content:".translate(),
            subtitle: widget.todo.content,
            function: () => Navigator.pushNamed(
              context,
              EditTodoScreen.routeName,
              arguments: widget.todo,
            ).then((value) => setState(() {})),
          ),

          // Checked
          TodoDetailsTile(
            title: "Checked:".translate(),
            subtitle: widget.todo.checked.toString(),
          ),

          // Time
          /*  TodoDetailsTile(
            title: "Time:",
            subtitle: widget.todo.onlyTime,
            function: _showBottomSheet,
          ),

          // Date
          TodoDetailsTile(
            title: "Date:",
            subtitle: widget.todo.onlyDate,
            function: _showBottomSheet,
          ), */

          // Divider
          const TodoDetailsTile.divider(),

          // Created on Date and Time
          /*  TodoDetailsTile(
            title: "Created on:",
            subtitle: widget.todo.createdAsString,
          ), */

          // Edit Button
          TodoDetailsTile.button(
            title: "Edit".translate(),
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

class EditTodoScreen extends StatefulWidget {
  const EditTodoScreen({
    required this.todo,
    Key? key,
  }) : super(key: key);

  final Todo todo;

  static const routeName = "/todo_details/edit";

  @override
  State<EditTodoScreen> createState() => _EditTodoScreenState();
}

class _EditTodoScreenState extends State<EditTodoScreen> {
  @override
  Widget build(BuildContext context) {
    String title = widget.todo.title;
    String content = widget.todo.content;

    final _scaffold = Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          "Edit Todo".translate(),
          semanticsLabel: "Edit Todo".translate(),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        textDirection: TextDirection.ltr,
        textBaseline: TextBaseline.alphabetic,
        verticalDirection: VerticalDirection.down,
        children: <Widget>[
          TextFormField(
            autocorrect: true,
            autofocus: true,
            enableIMEPersonalizedLearning: true,
            enableInteractiveSelection: true,
            enableSuggestions: true,
            enabled: true,
            keyboardAppearance: Theme.of(context).brightness,
            obscureText: false,
            keyboardType: TextInputType.text,
            maxLines: 2,
            minLines: 1,
            maxLength: 100,
            maxLengthEnforcement:
                MaxLengthEnforcement.truncateAfterCompositionEnds,
            readOnly: false,
            smartDashesType: SmartDashesType.enabled,
            smartQuotesType: SmartQuotesType.enabled,
            scrollPhysics: const BouncingScrollPhysics(),
            toolbarOptions: const ToolbarOptions(
              copy: true,
              cut: true,
              paste: true,
              selectAll: true,
            ),
            textAlignVertical: TextAlignVertical.center,
            textCapitalization: TextCapitalization.sentences,
            textDirection: TextDirection.ltr,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: "Edit Title".translate(),
            ),
            initialValue: widget.todo.title,
            onFieldSubmitted: (value) {
              title = value;
              widget.todo.title = title;
              Storage.storeTodos();
              Jumper.back(context);
            },
            onChanged: (value) {
              title = value;
              widget.todo.title = title;
            },
          ),
          TextFormField(
            autocorrect: true,
            autofocus: true,
            enableIMEPersonalizedLearning: true,
            enableInteractiveSelection: true,
            enableSuggestions: true,
            enabled: true,
            keyboardAppearance: Theme.of(context).brightness,
            obscureText: false,
            keyboardType: TextInputType.text,
            maxLines: 5,
            minLines: 1,
            maxLengthEnforcement:
                MaxLengthEnforcement.truncateAfterCompositionEnds,
            readOnly: false,
            smartDashesType: SmartDashesType.enabled,
            smartQuotesType: SmartQuotesType.enabled,
            scrollPhysics: const BouncingScrollPhysics(),
            toolbarOptions: const ToolbarOptions(
              copy: true,
              cut: true,
              paste: true,
              selectAll: true,
            ),
            textAlignVertical: TextAlignVertical.center,
            textCapitalization: TextCapitalization.sentences,
            textDirection: TextDirection.ltr,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              labelText: "Edit Content".translate(),
            ),
            initialValue: widget.todo.content,
            onFieldSubmitted: (value) {
              content = value;
              widget.todo.content = content;
              Storage.storeTodos();
              Jumper.back(context);
            },
            onChanged: (value) {
              content = value;
              widget.todo.content = content;
            },
          ),

          // Button
          TextButton(
            onPressed: () {
              widget.todo.title = title;
              widget.todo.content = content;
              Storage.storeTodos();
              Jumper.back(context);
            },
            child: Text(
              "Confirm".translate(),
              semanticsLabel: "Confirm".translate(),
            ),
          )
        ],
      ),
    );

    return _scaffold;
  }
}
