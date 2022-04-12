library screens;

import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show MaxLengthEnforcement;
import 'package:string_translate/string_translate.dart' show Translate;
import 'package:todo/logic/jumper.dart';
import 'package:todo/models/brainstorm_list.dart';
import 'package:todo/models/brainstorm_note.dart';
import 'package:todo/models/setting.dart';
import 'package:todo/storage/storage.dart';

class AddBrainstormNoteScreen extends StatefulWidget {
  const AddBrainstormNoteScreen({Key? key}) : super(key: key);

  static const routeName = '/brainstorm/add';

  @override
  State<AddBrainstormNoteScreen> createState() =>
      _AddBrainstormNoteScreenState();
}

class _AddBrainstormNoteScreenState extends State<AddBrainstormNoteScreen> {
  String? title;
  String content = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Todo'.tr()),
        automaticallyImplyLeading: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        textBaseline: TextBaseline.alphabetic,
        mainAxisSize: MainAxisSize.max,
        textDirection: TextDirection.ltr,
        verticalDirection: VerticalDirection.down,
        children: <Widget>[
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
    BrainstormList.addNote(
      BrainstormNote(
        title: title,
        note: content,
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
