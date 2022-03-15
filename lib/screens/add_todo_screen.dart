library screens;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo/logic/jumper.dart';
import 'package:todo/logic/translate.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/models/todo_list.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({Key? key}) : super(key: key);

  static const routeName = "/add_todo";

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  DateTime? date;
  TimeOfDay? time;
  String? title;
  String content = "";
  int? importance;

  @override
  Widget build(BuildContext context) {
    final _scaffold = Scaffold(
      appBar: AppBar(
        title: Text("Add Todo".translate()),
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
              labelText: "Insert Title".translate(),
            ),
            onSubmitted: (value) {
              title = value;
            },
            onChanged: (value) {
              title = value;
            },
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
            onSubmitted: (value) {
              content = value;
              _createTodo();
            },
            onChanged: (value) {
              content = value;
            },
          ),
          /*  ListTile(
            autofocus: false,
            enabled: true,
            isThreeLine: false,
            title: Text(
              date == null ? "Set a Date".translate() : "Date".translate(),
            ),
            subtitle: date == null ? null : Text(Converter.onlyDate(date!)),
            leading: const Icon(Icons.date_range_rounded),
            onTap: () => _setDate().then(
              (value) => setState(() {
                date = value;
              }),
            ),
          ),
          ListTile(
            autofocus: false,
            enabled: true,
            isThreeLine: false,
            title: Text(
              date == null ? "Set a Time".translate() : "Time".translate(),
            ),
            subtitle:
                time == null ? null : Text(Converter.timeOfDaytoString(time!)),
            leading: const Icon(Icons.timelapse_rounded),
            onTap: () => _setTime().then(
              (value) => setState(() {
                time = value;
              }),
            ),
          ),
          ListTile(
            autofocus: false,
            enabled: true,
            isThreeLine: false,
            title: Text(
              importance == null
                  ? "Set an Importance".translate()
                  : "Importance".translate(),
            ),
            leading: const Icon(Icons.notification_important_rounded),
            subtitle: Text(
              Notifications.importance.toString(),
            ),
          ), */
          const SizedBox(height: 50),
          TextButton(
            onPressed: _createTodo,
            child: Text("Confirm".translate()),
            autofocus: false,
            clipBehavior: Clip.antiAliasWithSaveLayer,
          )
        ],
      ),
    );

    return _scaffold;
  }

  /// Creates a Todo and inserts the Values
  /// Also checks if the Values are give and shows a Dialog
  /// if Values are missing
  void _createTodo() {
    List<String> missingValues = [];

    if (title == null || title!.isEmpty) {
      missingValues.add("Title".translate());
    }
    /* if (date == null) {
      missingValues.add("Date".translate());
    }
     if (time == null) {
      missingValues.add("Time".translate());
    } */

    if (missingValues.isNotEmpty) {
      showDialog(
        barrierDismissible: true,
        context: context,
        builder: (_) {
          return _errorDialog(missingValues);
        },
      );
    } else {
      // Make one DateTime from date and time
      /*   final DateTime dateTime = DateTime(
        date!.year,
        date!.month,
        date!.day,
        time!.hour,
        time!.minute,
      ); */
      final _todo = Todo(
        title: title!,
        content: content,
        /*  time: dateTime,
        created: DateTime.now(),
        importance: importance, */
      );
      // Add the Todo to the global List
      TodoList.addTodo(_todo);
      // Pops the current Route
      Jumper.back(context);
    }
  }

  /// Shows an Error Dialog if some Values are not given
  /// and as a consequence the Todo can't be created
  AlertDialog _errorDialog(List<String> missingValues) {
    final String _title;
    final String _content1;
    String _content2;
    if (missingValues.length < 2) {
      final _component = missingValues[0];
      _title = "$_component " + "is missing".translate();
      _content1 = "The following Value is missing:".translate();
      _content2 = " * $_component";
    } else {
      _title = "Some Values missing".translate();
      _content1 = "The following Values are missing:".translate();
      _content2 = "";
      for (String component in missingValues) {
        _content2 += " * $component \n";
      }
    }
    final _content = _content1 + "\n" + "\n" + _content2;
    final _dialog = AlertDialog(
      scrollable: true,
      title: Text(_title),
      content: Text(_content),
      actionsAlignment: MainAxisAlignment.center,
      alignment: Alignment.center,
      elevation: 20.0,
      actionsOverflowDirection: VerticalDirection.down,
      semanticLabel: "Some Values missing".translate(),
      actionsPadding: const EdgeInsets.all(5),
      actions: <Center>[
        Center(
          child: TextButton(
            onPressed: () => Jumper.back(context),
            child: Text("OK".translate()),
            autofocus: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
          ),
        ),
      ],
    );

    return _dialog;
  }

  /// Shows the Date Picker and returns the Date
  Future<DateTime?> _setDate() async {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022, 2, 22, 22, 22, 22, 22, 22),
      lastDate: DateTime(2222, 2, 22, 22, 22, 22, 22, 22),
      textDirection: TextDirection.ltr,
      currentDate: DateTime.now(),
      initialDatePickerMode: DatePickerMode.day,
      initialEntryMode: DatePickerEntryMode.calendar,
      locale: Translation.activeLocale,
      cancelText: "Cancel".translate(),
      confirmText: "Confirm".translate(),
      // TODO: right / useful?
      useRootNavigator: true,
    );
  }

  /// Shows the Time Picker and returns the time
  Future<TimeOfDay?> _setTime() async {
    return showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.dial,
      cancelText: "Cancel".translate(),
      confirmText: "Confirm".translate(),
      // TODO: right / useful?
      useRootNavigator: true,
    );
  }
}
