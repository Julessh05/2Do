library screens;

import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';
import 'package:todo/logic/jumper.dart';
import 'package:string_translate/string_translate.dart' show Translate;
import 'package:todo/main.dart' show TodoApp;
import 'package:todo/models/todo.dart' show Todo;
import 'package:todo/models/todo_list.dart';
import 'package:todo/screens/add_todo_screen.dart';
import 'package:todo/screens/components/todo_tile.dart';
import 'package:todo/screens/settings_screens.dart' show SettingsMainScreen;
import 'package:todo/screens/sorted_todo_screen.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  /// The Name of the Route for this Screen.
  /// Is used to navigate trough the App.
  /// These Values are set in the [MaterialApp] of the [TodoApp]
  static const routeName = '/';

  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          tooltip: 'Open Brainstorm Mode'.tr(),
          onPressed: () => Jumper.openBrainstormScreen(context),
          icon: const Icon(Icons.note_add_rounded),
        ),
        title: Text(
          '2Do'.tr(),
          semanticsLabel: 'Title'.tr(),
        ),
        actions: <IconButton>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => Jumper.openSearch(context),
            tooltip: 'Search'.tr(),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(
                context,
                SettingsMainScreen.routeName,
              ).then((value) => setState(() {}));
            },
            tooltip: 'Open Settings'.tr(),
          )
        ],
      ),
      body: _body,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openAddTodo(context),
        child: const Icon(Icons.add_rounded),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      extendBody: true,
      extendBodyBehindAppBar: true,
    );
  }

  Widget get _body {
    const allTodosTag = '#<All>#';

    if (TodoList.tags.isEmpty) {
      return ListView(
        addAutomaticKeepAlives: true,
        addRepaintBoundaries: true,
        addSemanticIndexes: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        dragStartBehavior: DragStartBehavior.start,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        children: <ListTile>[
          ListTile(
            autofocus: true,
            enableFeedback: true,
            enabled: true,
            isThreeLine: false,
            title: Text('All Todos'.tr()),
            subtitle: Text('Show all Todos'.tr()),
            onTap: () => _onTap(allTodosTag),
          ),
        ],
      );
    } else {
      return ListView.builder(
        addAutomaticKeepAlives: true,
        addRepaintBoundaries: true,
        addSemanticIndexes: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        dragStartBehavior: DragStartBehavior.down,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: TodoList.tags.length + 1,
        itemBuilder: (_, counter) {
          final String _tag = TodoList.tags[counter - 1];

          if (counter == 0) {
            return ListTile(
              autofocus: true,
              enableFeedback: true,
              enabled: true,
              isThreeLine: false,
              title: Text('All Todos'.tr()),
              subtitle: Text('Show all Todos'.tr()),
              onTap: () => _onTap(allTodosTag),
            );
          } else {
            return ListTile(
              autofocus: false,
              enableFeedback: true,
              enabled: true,
              isThreeLine: false,
              title: Text(_tag),
              onTap: () => _onTap(_tag),
            );
          }
        },
      );
    }
  }

  void _onTap(String tag) {
    Navigator.pushNamed(context, SortedTodoScreen.routeName)
        .then((_) => setState(() {}));
  }

  /// Opens the [AddTodoScreen] where you can add a Todo
  void _openAddTodo(BuildContext context) {
    Navigator.pushNamed(context, AddTodoScreen.routeName).then(
      (value) => setState(() {}),
    );
  }
}
