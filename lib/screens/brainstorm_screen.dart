library screens;

import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';
import 'package:string_translate/string_translate.dart' show Translate;
import 'package:todo/models/brainstorm_list.dart';
import 'package:todo/models/brainstorm_note.dart';
import 'package:todo/screens/add_brainstorm_note_screen.dart';
import 'package:todo/screens/components/notes_tile.dart';

class BrainstormScreen extends StatefulWidget {
  const BrainstormScreen({Key? key}) : super(key: key);

  static const routeName = '/brainstorm';

  @override
  State<BrainstormScreen> createState() => _BrainstormScreenState();
}

class _BrainstormScreenState extends State<BrainstormScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: _body,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddBrainstormNoteScreen.routeName).then(
            (value) => setState(() {}),
          );
        },
        tooltip: 'Add Brainstorm Todo'.tr(),
        child: const Icon(Icons.note_add_rounded),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  AppBar get _appBar {
    bool selected = false;
    final AppBar _appBar;
    for (BrainstormNote note in BrainstormList.combinedListOfNotes) {
      if (note.selected) {
        selected = true;
        break;
      } else {
        continue;
      }
    }
    if (selected) {
      _appBar = AppBar(
        title: Text(
          'Edit'.tr(),
          semanticsLabel: 'Edit'.tr(),
        ),
        actions: <IconButton>[
          IconButton(
            icon: const Icon(Icons.delete_outline_rounded),
            onPressed: () {
              setState(() {
                final List<BrainstormNote> _list = [];
                for (BrainstormNote note
                    in BrainstormList.combinedListOfNotes) {
                  if (note.selected) {
                    _list.add(note);
                  } else {
                    continue;
                  }
                }
                for (BrainstormNote note in _list) {
                  BrainstormList.deleteNote(note);
                }
              });
            },
          ),
        ],
      );
    } else {
      _appBar = AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          'Brainstorm'.tr(),
          semanticsLabel: 'Title'.tr(),
        ),
      );
    }
    return _appBar;
  }

  Widget get _body {
    final Widget _body;
    if (BrainstormList.combinedListOfNotes.isNotEmpty) {
      final _list = <Widget>[];
      _list.addAll(_notesTiles);
      if (BrainstormList.listOfCheckedNotes.isNotEmpty) {
        _list.add(
          ListTile(
            title: Text('Checked Notes:'.tr()),
          ),
        );
      }
      _list.addAll(_checkedNotesTiles);
      _body = ListView(
        addAutomaticKeepAlives: true,
        addRepaintBoundaries: true,
        addSemanticIndexes: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        dragStartBehavior: DragStartBehavior.start,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        children: _list,
      );
    } else {
      _body = Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 1.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            textBaseline: TextBaseline.alphabetic,
            textDirection: TextDirection.ltr,
            mainAxisSize: MainAxisSize.max,
            verticalDirection: VerticalDirection.down,
            children: <Widget>[
              Text(
                'You don\'t have any Notes'.tr(),
                semanticsLabel: 'You don\'t have any Notes'.tr(),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () => _openAddNote(),
                child: Text(
                  'Add one'.tr(),
                  semanticsLabel: 'Add one'.tr(),
                ),
                autofocus: false,
                clipBehavior: Clip.antiAliasWithSaveLayer,
              ),
            ],
          ),
        ),
      );
    }
    return _body;
  }

  void _openAddNote() {
    Navigator.pushNamed(context, AddBrainstormNoteScreen.routeName).then(
      (value) => setState(() {}),
    );
  }

  List<NotesTile> get _notesTiles {
    final List<NotesTile> _list = [];
    for (BrainstormNote note in BrainstormList.listOfNotes) {
      _list.add(NotesTile(
        note: note,
        setStateFunc: _setStateFunc,
      ));
    }
    return _list;
  }

  List<NotesTile> get _checkedNotesTiles {
    final List<NotesTile> _list = [];
    for (BrainstormNote note in BrainstormList.listOfCheckedNotes) {
      _list.add(NotesTile(
        note: note,
        setStateFunc: _setStateFunc,
      ));
    }
    return _list;
  }

  void _setStateFunc() {
    setState(() {});
  }
}
