library components;

import 'package:flutter/material.dart';
import 'package:todo/models/brainstorm_list.dart';
import 'package:todo/models/brainstorm_note.dart' show BrainstormNote;
import 'package:todo/screens/notes_details_screen.dart';
import 'package:todo/storage/storage.dart';

class NotesTile extends StatefulWidget {
  const NotesTile({
    required this.note,
    required this.setStateFunc,
    Key? key,
  }) : super(key: key);

  final BrainstormNote note;
  final void Function() setStateFunc;

  @override
  State<NotesTile> createState() => _NotesTileState();
}

class _NotesTileState extends State<NotesTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: widget.note.selected,
      onLongPress: _onSelected,
      autofocus: false,
      isThreeLine: false,
      enabled: true,
      title: Text(widget.note.note),
      leading: Checkbox(
        value: widget.note.checked,
        autofocus: false,
        tristate: false,
        onChanged: (_) => _onChecked(),
      ),
      onTap: _onTap,
    );
  }

  void _onTap() {
    if (BrainstormList.noteMarked) {
      setState(() {
        widget.note.selected = !widget.note.selected;
      });
      widget.setStateFunc;
    } else {
      Navigator.pushNamed(
        context,
        NotesDetailsScreen.routeName,
        arguments: widget.note,
      ).then(
        (value) => setState(() {}),
      );
    }
  }

  void _onSelected() {
    setState(() {
      widget.note.selected = !widget.note.selected;
    });
    widget.setStateFunc();
  }

  void _onChecked() {
    setState(() {
      widget.note.checked = !widget.note.checked;
      if (widget.note.checked) {
        BrainstormList.checkNote(widget.note);
      } else if (widget.note.checked == false) {
        BrainstormList.uncheckNote(widget.note);
      } else {
        // Do nothing
      }
      widget.setStateFunc();
    });
    Storage.storeBrainstormNotes();
  }
}
