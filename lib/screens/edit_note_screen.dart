library screens;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show MaxLengthEnforcement;
import 'package:string_translate/string_translate.dart' show Translate;
import 'package:todo/logic/jumper.dart';
import 'package:todo/main.dart' show TodoApp;
import 'package:todo/models/brainstorm_note.dart' show BrainstormNote;
import 'package:todo/storage/storage.dart';

class EditNoteScreen extends StatefulWidget {
  const EditNoteScreen({
    required this.note,
    Key? key,
  }) : super(key: key);

  /// The Name of the Route for this Screen.
  /// Is used to navigate trough the App.
  /// These Values are set in the [MaterialApp] of the [TodoApp]
  static const routeName = '/brainstorm/details/edit';

  final BrainstormNote note;

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  @override
  Widget build(BuildContext context) {
    String? title = widget.note.title;
    String note = widget.note.note;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          'Edit Note'.tr(),
          semanticsLabel: 'Edit Note'.tr(),
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
          title != null
              ? TextFormField(
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
                  initialValue: widget.note.title,
                  onFieldSubmitted: (value) {
                    title = value;
                    widget.note.title = title;
                    Storage.storeBrainstormNotes();
                    Jumper.back(context);
                  },
                  onChanged: (value) {
                    title = value;
                    widget.note.title = title;
                  },
                )
              : const SizedBox(height: 0),
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
              labelText: 'Edit Note'.tr(),
            ),
            initialValue: widget.note.note,
            onFieldSubmitted: (value) {
              note = value;
              widget.note.note = note;
              Storage.storeBrainstormNotes();
              Jumper.back(context);
            },
            onChanged: (value) {
              note = value;
              widget.note.note = note;
            },
          ),

          // Button
          TextButton(
            onPressed: () {
              widget.note.title = title;
              widget.note.note = note;
              Storage.storeBrainstormNotes();
              Jumper.back(context);
            },
            child: Text(
              'Confirm'.tr(),
              semanticsLabel: 'Confirm'.tr(),
            ),
          )
        ],
      ),
    );
  }
}
