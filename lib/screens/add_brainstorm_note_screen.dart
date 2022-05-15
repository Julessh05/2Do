library screens;

import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show MaxLengthEnforcement;
import 'package:string_translate/string_translate.dart' show Translate;
import 'package:todo/logic/jumper.dart';
import 'package:todo/main.dart' show TodoApp;
import 'package:todo/models/brainstorm_list.dart';
import 'package:todo/models/brainstorm_note.dart' show BrainstormNote;
import 'package:todo/models/setting.dart' show AllSettings;
import 'package:todo/storage/storage.dart';

class AddBrainstormNoteScreen extends StatefulWidget {
  const AddBrainstormNoteScreen({Key? key}) : super(key: key);

  /// The Name of the Route for this Screen.
  /// Is used to navigate trough the App.
  /// These Values are set in the [MaterialApp] of the [TodoApp]
  static const routeName = '/brainstorm/add';

  @override
  State<AddBrainstormNoteScreen> createState() =>
      _AddBrainstormNoteScreenState();
}

class _AddBrainstormNoteScreenState extends State<AddBrainstormNoteScreen> {
  String? title;
  String? content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Note'.tr()),
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
          AllSettings.brainstormTitle.boolValue!
              ? TextField(
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
                    labelText: 'Insert Title'.tr(),
                  ),
                  onSubmitted: (value) {
                    title = value;
                  },
                  onChanged: (value) {
                    title = value;
                  },
                )
              : const SizedBox(height: 0),
          TextField(
            autocorrect: true,
            autofocus: !AllSettings.brainstormTitle.boolValue!,
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
              labelText: 'Insert Content'.tr(),
            ),
            onSubmitted: (value) {
              content = value;
              _createNote();
            },
            onChanged: (value) {
              content = value;
            },
          ),
        ],
      ),
    );
  }

  /// Creates a Note and determines
  /// if the User wants to go back or not
  void _createNote() {
    if (content == null || content!.isEmpty) {
      showDialog(
        barrierDismissible: true,
        context: context,
        builder: (_) {
          return AlertDialog(
            scrollable: true,
            title: Text('Empty Note'.tr()),
            content: Text(
              'The Note can\'t be empty. Please provide a Text'.tr(),
            ),
            actionsOverflowDirection: VerticalDirection.down,
            actionsAlignment: MainAxisAlignment.center,
            alignment: Alignment.center,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            actions: <Center>[
              Center(
                child: TextButton(
                  onPressed: () => Jumper.back(context),
                  autofocus: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Text('OK'.tr()),
                ),
              ),
            ],
          );
        },
      );
    } else {
      BrainstormList.addNote(
        BrainstormNote(
          title: title,
          note: content!,
        ),
      );
      Storage.storeBrainstormNotes();
      if (AllSettings.brainstormFlying.boolValue!) {
        Navigator.pushReplacementNamed(
          context,
          AddBrainstormNoteScreen.routeName,
        );
      } else {
        Jumper.back(context);
      }
    }
  }
}
