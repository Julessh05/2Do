library screens;

import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show MaxLengthEnforcement;
import 'package:todo/logic/jumper.dart';
import 'package:string_translate/string_translate.dart'
    show Translate, Translation;
import 'package:todo/main.dart' show TodoApp;
import 'package:todo/models/todo.dart' show Todo;
import 'package:todo/models/todo_list.dart';
import 'package:todo/screens/add_tag_screen.dart';
import 'package:todo/storage/storage.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({
    this.tag,
    Key? key,
  }) : super(key: key);

  /// The Name of the Route for this Screen.
  /// Is used to navigate trough the App.
  /// These Values are set in the [MaterialApp] of the [TodoApp]
  static const routeName = '/add_todo';

  final String? tag;

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  // Date of the Todo. Only the Date should be filled
  DateTime? date;
  // Time of the Todo
  TimeOfDay? time;
  // Title of the Todo. Can also be named Keyword(s)
  String? title;
  // Contents of the Todo. Can also be named Notes
  String content = '';
  // Importance as number
  int? importance;
  // Tags of the Todo. Can also be named categories
  final List<String> tags = [];

  /// List to delete Tags
  final List<String> tagsToDelete = [];

  @override
  void initState() {
    if (widget.tag != null && !tags.contains(widget.tag)) {
      tags.add(widget.tag!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: ListView(
        addAutomaticKeepAlives: true,
        addRepaintBoundaries: true,
        addSemanticIndexes: true,
        clipBehavior: Clip.antiAlias,
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
              labelText: 'Insert Content'.tr(),
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
              date == null ? 'Set a Date'.tr() : 'Date'.tr(),
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
              date == null ? 'Set a Time'.tr() : 'Time'.tr(),
            ),
            subtitle:
                time == null ? null : Text(Converter.timeOfDayToString(time!)),
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
                  ? 'Set an Importance'.tr()
                  : 'Importance'.tr(),
            ),
            leading: const Icon(Icons.notification_important_rounded),
            subtitle: Text(
              Notifications.importance.toString(),
            ),
          ), */
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
          const SizedBox(height: 50),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: TextButton(
              onPressed: _createTodo,
              autofocus: false,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Text('Confirm'.tr()),
            ),
          ),
        ],
      ),
    );
  }

  /// AppBar depending on the Mode.
  /// If Tags are marked, the AppBar is changed to delete it
  AppBar get _appBar {
    if (tagsToDelete.isNotEmpty) {
      return AppBar(
        title: Text(
          'Edit'.tr(),
          semanticsLabel: 'Edit'.tr(),
        ),
        automaticallyImplyLeading: true,
        actions: <IconButton>[
          // Delete Button
          IconButton(
            icon: const Icon(Icons.delete_outline_rounded),
            onPressed: () {
              setState(() {
                for (String tag in tagsToDelete) {
                  TodoList.deleteTag(tag);
                }
                tagsToDelete.clear();
              });
            },
            tooltip: 'Delete Tag'.tr(),
          ),
        ],
      );
    } else {
      return AppBar(
        title: Text('Add Todo'.tr()),
        automaticallyImplyLeading: true,
      );
    }
  }

  /// Getter for the Active Tags.
  /// This is the List to display, so it's a List<Widget>
  List<Widget> get _activeTags {
    final List<Widget> list = [];
    for (String tag in tags) {
      list.add(
        TextButton(
          onPressed: () {
            setState(() {
              tags.remove(tag);
            });
          },
          child: Text(tag),
        ),
      );
    }
    return list;
  }

  /// The List of Widgets to show all the Tags
  /// This Getter also handles the SetState and decides
  /// if the Tag is shown with a marked to delete it or not
  List<Widget> get _tagContainerList {
    final List<Widget> list = [];
    for (String tag in TodoList.tags) {
      // Add Spacing
      list.add(const SizedBox(width: 20));
      // Add Tag Button
      list.add(
        TextButton(
          onLongPress: () {
            setState(() {
              tagsToDelete.add(tag);
            });
          },
          onPressed: () {
            if (tagsToDelete.isNotEmpty) {
              tagsToDelete.add(tag);
            }
            if (tags.contains(tag)) {
            } else {
              setState(() {
                tags.add(tag);
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
    list.add(const SizedBox(width: 20));
    // Add Add Tag Button
    list.add(
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
    return list;
  }

  /// Creates a Todo and inserts the Values
  /// Also checks if the Values are give and shows a Dialog
  /// if Values are missing
  void _createTodo() {
    List<String> missingValues = [];

    if (title == null || title!.isEmpty) {
      missingValues.add('Title'.tr());
    }
    /* if (date == null) {
      missingValues.add('Date'.tr());
    }
     if (time == null) {
      missingValues.add('Time'.tr());
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
      final todo = Todo(
        title: title!,
        content: content,
        tags: Todo.tagsToString(tags),
        /*  time: dateTime,
        created: DateTime.now(),
        importance: importance, */
      );
      // Add the Todo to the global List
      TodoList.addTodo(todo);
      Storage.storeTodos();
      todo.save();
      // Pops the current Route
      Jumper.back(context);
    }
  }

  /// Shows an Error Dialog if some Values are not given
  /// and as a consequence the Todo can't be created
  AlertDialog _errorDialog(List<String> missingValues) {
    final String title;
    final String content1;
    String content2;
    if (missingValues.length < 2) {
      final component = missingValues[0];
      title = '$component is missing'.tr();
      content1 = 'The following Value is missing:'.tr();
      content2 = ' * $component';
    } else {
      title = 'Some Values missing'.tr();
      content1 = 'The following Values are missing:'.tr();
      content2 = '';
      for (String component in missingValues) {
        content2 += ' * $component \n';
      }
    }
    final content = '$content1 + \n \n $content2';
    final dialog = AlertDialog(
      scrollable: true,
      title: Text(title),
      content: Text(content),
      actionsAlignment: MainAxisAlignment.center,
      alignment: Alignment.center,
      elevation: 20.0,
      actionsOverflowDirection: VerticalDirection.down,
      semanticLabel: 'Some Values missing'.tr(),
      actionsPadding: const EdgeInsets.all(5),
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

    return dialog;
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
      cancelText: 'Cancel'.tr(),
      confirmText: 'Confirm'.tr(),
      useRootNavigator: true,
    );
  }

  /// Shows the Time Picker and returns the time
  Future<TimeOfDay?> _setTime() async {
    return showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.dial,
      cancelText: 'Cancel'.tr(),
      confirmText: 'Confirm'.tr(),
      useRootNavigator: true,
    );
  }
}
