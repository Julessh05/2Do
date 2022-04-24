library screens;

import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show MaxLengthEnforcement;
import 'package:string_translate/string_translate.dart' show Translate;
import 'package:todo/logic/jumper.dart';
import 'package:todo/models/todo.dart' show Todo;
import 'package:todo/models/todo_list.dart';
import 'package:todo/screens/add_tag_screen.dart';
import 'package:todo/storage/storage.dart';

class EditTodoScreen extends StatefulWidget {
  const EditTodoScreen({
    required this.todo,
    Key? key,
  }) : super(key: key);

  final Todo todo;

  static const routeName = '/todo_details/edit';

  @override
  State<EditTodoScreen> createState() => _EditTodoScreenState();
}

class _EditTodoScreenState extends State<EditTodoScreen> {
  final List<String> tagsToDelete = [];
  List<String> tags = [];
  @override
  Widget build(BuildContext context) {
    // Get initial Tags
    tags = widget.todo.tagsAsList;

    String title = widget.todo.title;
    String content = widget.todo.content;

    final _scaffold = Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          'Edit Todo'.tr(),
          semanticsLabel: 'Edit Todo'.tr(),
        ),
      ),
      body: ListView(
        addAutomaticKeepAlives: true,
        addRepaintBoundaries: true,
        addSemanticIndexes: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        dragStartBehavior: DragStartBehavior.start,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        children: <Widget>[
          const SizedBox(height: 20),
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
              labelText: 'Edit Title'.tr(),
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
              labelText: 'Edit Content'.tr(),
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
          const SizedBox(height: 10),

          ListTile(
            title: Text('Active Tags:'.tr()),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            textBaseline: TextBaseline.alphabetic,
            textDirection: TextDirection.ltr,
            verticalDirection: VerticalDirection.down,
            children: _activeTags,
          ),
          ListTile(
            title: Text('Tags:'.tr()),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            dragStartBehavior: DragStartBehavior.start,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            physics: const BouncingScrollPhysics(),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              textBaseline: TextBaseline.alphabetic,
              textDirection: TextDirection.ltr,
              verticalDirection: VerticalDirection.down,
              children: _tagContainerList,
            ),
          ),
          // Spacing
          const SizedBox(height: 20),

          // Button
          FittedBox(
            alignment: Alignment.center,
            fit: BoxFit.scaleDown,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: TextButton(
              onPressed: () {
                widget.todo.title = title;
                widget.todo.content = content;
                Storage.storeTodos();
                Jumper.back(context);
              },
              child: Text(
                'Confirm'.tr(),
                semanticsLabel: 'Confirm'.tr(),
              ),
            ),
          )
        ],
      ),
    );

    return _scaffold;
  }

  /// Getter for the Active Tags.
  /// This is the List to display, so it's a List<Widget>
  List<Widget> get _activeTags {
    final List<Widget> _list = [];
    for (String tag in tags) {
      _list.add(
        TextButton(
          onPressed: () {
            setState(() {
              tags.remove(tag);
              widget.todo.removeTag(tag);
            });
          },
          child: Text(tag),
        ),
      );
    }
    return _list;
  }

  /// The List of Widgets to show all the Tags
  /// This Getter also handles the SetState and decides
  /// if the Tag is shown with a marked to delete it or not
  List<Widget> get _tagContainerList {
    final List<Widget> _list = [];
    for (String tag in TodoList.tags) {
      // Add Spacing
      _list.add(const SizedBox(width: 20));
      // Add Tag Button
      _list.add(
        TextButton(
          onPressed: () {
            if (tags.contains(tag)) {
              // Do nothing
            } else {
              setState(() {
                tags.add(tag);
                widget.todo.addTag(tag);
              });
            }
          },
          child: tagsToDelete.contains(tag)
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  textDirection: TextDirection.ltr,
                  textBaseline: TextBaseline.alphabetic,
                  verticalDirection: VerticalDirection.down,
                  children: <Widget>[
                    const Icon(Icons.delete_outline_outlined),
                    Text(tag),
                  ],
                )
              : Text(tag),
        ),
      );
    }
    // Add Spacing
    _list.add(const SizedBox(width: 20));
    // Add Add Tag Button
    _list.add(
      TextButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            AddTagScreen.routeName,
          ).then((value) => setState(() {}));
        },
        child: Text(
          'Add Tag'.tr(),
        ),
      ),
    );
    return _list;
  }
}
