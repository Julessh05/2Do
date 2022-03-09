library screens;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
          ),

          // Edit Button
          TodoDetailsTile.button(
            title: "Edit".translate(),
            buttonFunction: _showBottomSheet,
          )
        ],
      ),
      //bottomSheet: _bottomSheet,
    );

    return _scaffold;
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return _bottomSheet;
      },
    );
  }

  Widget get _bottomSheet {
    final _bottomSheet = BottomSheet(
      enableDrag: true,
      //animationController: AnimationController(vsync: ),
      onClosing: () {},
      builder: (_) {
        return ListView(
          addAutomaticKeepAlives: true,
          addRepaintBoundaries: true,
          addSemanticIndexes: true,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          dragStartBehavior: DragStartBehavior.start,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          children: <Widget>[
            ListTile(
              autofocus: false,
              title: Text("Edit Todo".translate()),
            ),
            const SizedBox(height: 15),
            TextField(
              autocorrect: true,
              autofocus: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              dragStartBehavior: DragStartBehavior.start,
              enableIMEPersonalizedLearning: true,
              enableInteractiveSelection: true,
              enableSuggestions: true,
              enabled: true,
              keyboardAppearance: Theme.of(context).brightness,
              keyboardType: TextInputType.text,
              maxLines: 2,
              maxLength: 100,
              maxLengthEnforcement:
                  MaxLengthEnforcement.truncateAfterCompositionEnds,
              minLines: 1,
              obscureText: false,
              readOnly: false,
              scrollPhysics: const BouncingScrollPhysics(),
              smartDashesType: SmartDashesType.enabled,
              smartQuotesType: SmartQuotesType.enabled,
              showCursor: true,
              textDirection: TextDirection.ltr,
              textAlignVertical: TextAlignVertical.center,
              textCapitalization: TextCapitalization.sentences,
              textInputAction: TextInputAction.next,
              toolbarOptions: const ToolbarOptions(
                copy: true,
                cut: true,
                paste: true,
                selectAll: true,
              ),
              decoration: InputDecoration(
                labelText: "Edit Title".translate(),
              ),
            ),
            TextField(
              autocorrect: true,
              autofocus: false,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              dragStartBehavior: DragStartBehavior.start,
              enableIMEPersonalizedLearning: true,
              enableInteractiveSelection: true,
              enableSuggestions: true,
              enabled: true,
              keyboardAppearance: Theme.of(context).brightness,
              keyboardType: TextInputType.text,
              maxLines: 5,
              minLines: 1,
              maxLengthEnforcement:
                  MaxLengthEnforcement.truncateAfterCompositionEnds,
              obscureText: false,
              readOnly: false,
              scrollPhysics: const BouncingScrollPhysics(),
              smartDashesType: SmartDashesType.enabled,
              smartQuotesType: SmartQuotesType.enabled,
              showCursor: true,
              textDirection: TextDirection.ltr,
              textAlignVertical: TextAlignVertical.center,
              textCapitalization: TextCapitalization.sentences,
              textInputAction: TextInputAction.next,
              toolbarOptions: const ToolbarOptions(
                copy: true,
                cut: true,
                paste: true,
                selectAll: true,
              ),
              decoration: InputDecoration(
                labelText: "Insert Content".translate(),
              ),
            ),
          ],
        );
      },
    );

    return _bottomSheet;
  }
}
