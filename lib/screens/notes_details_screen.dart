library screens;

import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';
import 'package:string_translate/string_translate.dart' show Translate;
import 'package:todo/main.dart' show TodoApp;
import 'package:todo/models/brainstorm_note.dart' show BrainstormNote;
import 'package:todo/screens/components/notes_details_tile.dart';
import 'package:todo/screens/edit_note_screen.dart';

class NotesDetailsScreen extends StatefulWidget {
  const NotesDetailsScreen({
    required this.note,
    Key? key,
  }) : super(key: key);

  /// The Name of the Route for this Screen.
  /// Is used to navigate trough the App.
  /// These Values are set in the [MaterialApp] of the [TodoApp]
  static const routeName = '/brainstorm/details';
  final BrainstormNote note;

  @override
  State<NotesDetailsScreen> createState() => _NotesDetailsScreenState();
}

class _NotesDetailsScreenState extends State<NotesDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.note.note,
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
        children: <Widget>[
          // Title
          widget.note.title != null
              ? NotesDetailsTile(
                  title: 'Title:'.tr(),
                  subtitle: widget.note.title,
                  function: () => Navigator.pushNamed(
                    context,
                    EditNoteScreen.routeName,
                    arguments: widget.note,
                  ).then((value) => setState(() {})),
                )
              : const SizedBox(height: 0),

          // Note
          NotesDetailsTile(
            title: 'Content:'.tr(),
            subtitle: widget.note.note,
            function: () => Navigator.pushNamed(
              context,
              EditNoteScreen.routeName,
              arguments: widget.note,
            ).then((value) => setState(() {})),
          ),

          // Checked
          NotesDetailsTile(
            title: 'Checked:'.tr(),
            subtitle: widget.note.checked ? 'Checked'.tr() : 'Not yet'.tr(),
          ),

          // Divider
          const NotesDetailsTile.divider(),

          // Edit Button
          NotesDetailsTile.button(
            title: 'Edit'.tr(),
            function: () => Navigator.pushNamed(
              context,
              EditNoteScreen.routeName,
              arguments: widget.note,
            ).then((value) => setState(() {})),
          )
        ],
      ),
    );
  }
}
