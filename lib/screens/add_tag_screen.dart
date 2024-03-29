library screens;

import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'
    show MaxLengthEnforcement, FilteringTextInputFormatter;
import 'package:string_translate/string_translate.dart' show Translate;
import 'package:todo/logic/jumper.dart';
import 'package:todo/main.dart' show TodoApp;
import 'package:todo/models/todo_list.dart';

/// Screen to add a new Tag
class AddTagScreen extends StatefulWidget {
  const AddTagScreen({Key? key}) : super(key: key);

  /// The Name of the Route for this Screen.
  /// Is used to navigate trough the App.
  /// These Values are set in the [MaterialApp] of the [TodoApp]
  static const routeName = '/add_todo/add_tag';

  @override
  State<AddTagScreen> createState() => _AddTagScreenState();
}

class _AddTagScreenState extends State<AddTagScreen> {
  String tag = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Tag'.tr()),
        automaticallyImplyLeading: true,
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
            maxLength: 30,
            maxLengthEnforcement:
                MaxLengthEnforcement.truncateAfterCompositionEnds,
            maxLines: 2,
            minLines: 1,
            obscureText: false,
            readOnly: false,
            scrollPhysics: const BouncingScrollPhysics(),
            smartDashesType: SmartDashesType.enabled,
            smartQuotesType: SmartQuotesType.enabled,
            textInputAction: TextInputAction.done,
            textCapitalization: TextCapitalization.words,
            textAlign: TextAlign.start,
            textAlignVertical: TextAlignVertical.center,
            textDirection: TextDirection.ltr,
            inputFormatters: <FilteringTextInputFormatter>[
              // Forbids to use a Comma in the Text Field
              FilteringTextInputFormatter.deny(
                RegExp(','),
              ),
            ],
            toolbarOptions: const ToolbarOptions(
              copy: true,
              cut: true,
              paste: true,
              selectAll: true,
            ),
            decoration: InputDecoration(
              labelText: 'Insert Tag'.tr(),
            ),
            onChanged: (inputTag) {
              tag = inputTag;
            },
            onSubmitted: (inputTag) => _confirm(inputTag),
          ),
          ListTile(
            title: Text(
              'A Tag can\'t contains a Comma'.tr(),
            ),
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.center,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: TextButton(
              onPressed: () => _confirm(tag),
              child: Text(
                'Confirm'.tr(),
              ),
            ),
          )
        ],
      ),
    );
  }

  /// function called when the User is done
  /// editing the Text Field.
  /// It adds the [tag] to the other Tags
  /// and jumps back to the Route before.
  void _confirm(String tag) {
    TodoList.addTag(tag);
    Jumper.back(context);
  }
}
