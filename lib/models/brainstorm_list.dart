library models;

import 'dart:collection' show UnmodifiableListView;

import 'package:todo/models/brainstorm_note.dart' show BrainstormNote;
import 'package:todo/storage/storage.dart';

/// Object to hold all the
class BrainstormList {
  /// List to hold the Notes
  static List<BrainstormNote> _notes = [];

  /// List to hold checked Notes
  static List<BrainstormNote> _checkedNotes = [];

  static List<BrainstormNote> _combinedList = [];

  /// The List where all unchecked notes are stored
  /// This List is unmodifiable
  static UnmodifiableListView<BrainstormNote> get listOfNotes =>
      UnmodifiableListView(_notes);

  /// Setter for the [_notes]
  static set listOfNotes(List<BrainstormNote> list) => _notes = list;

  /// The List where all checked notes are stored
  /// This List is unmodifiable
  static UnmodifiableListView<BrainstormNote> get listOfCheckedNotes =>
      UnmodifiableListView(_checkedNotes);

  /// Setter for the [_checkedNotes]
  static set listOfCheckedNotes(List<BrainstormNote> list) =>
      _checkedNotes = list;

  /// The List where all notes are stored
  /// This List is unmodifiable
  static UnmodifiableListView<BrainstormNote> get combinedListOfNotes =>
      UnmodifiableListView(_combinedList);

  /// Adds a note to the [_notes]
  /// This is used when a new note is created, because the note is unchecked
  static void addNote(BrainstormNote note) {
    _notes.add(note);
    _updateCombinedList();
    Storage.storeBrainstormNotes();
  }

  /// Adds a Checked note to the [_checkedNotes]
  /// This is used when loading a note from the File, which is already checked
  static void addCheckedNote(BrainstormNote note) {
    _checkedNotes.add(note);
    _updateCombinedList();
    Storage.storeBrainstormNotes();
  }

  /// Deletes a note
  /// Removes the [note] from [_notes] and [_checkedNotes]
  static void deleteNote(BrainstormNote note) {
    _notes.remove(note);
    _checkedNotes.remove(note);
    _updateCombinedList();
    Storage.storeBrainstormNotes();
  }

  /// Removes the [note] from the [_notes] and adds it to the
  /// [_checkedNotes] so it can be handled as a checked note
  static void checkNote(BrainstormNote note) {
    _notes.remove(note);
    _checkedNotes.add(note);
    _updateCombinedList();
    Storage.storeBrainstormNotes();
  }

  /// Removes the [note] from the [_checkedNotes] and add it
  /// to the [_notes] so it can be handled as a unchecked note
  static void uncheckNote(BrainstormNote note) {
    _checkedNotes.remove(note);
    _notes.add(note);
    _updateCombinedList();
    Storage.storeBrainstormNotes();
  }

  /// Updates the [_combinedList] so this List is always up-to-date
  static void _updateCombinedList() {
    _combinedList = _notes + _checkedNotes;
  }

  static bool get noteMarked {
    for (BrainstormNote note in _combinedList) {
      if (note.selected) {
        return true;
      } else {
        continue;
      }
    }
    return false;
  }
}
