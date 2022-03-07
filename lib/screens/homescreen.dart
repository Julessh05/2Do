library screens;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/logic/translate.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/screens/add_todo_screen.dart';
import 'package:todo/screens/settings_screens.dart';
import 'components/todo_tile.dart';

// TODO: Remove in Production Code
final Todo _todo = Todo(
  time: DateTime.now(),
  title: "Todo",
  content: "Content",
);

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    final _scaffold = Scaffold(
      appBar: AppBar(
        title: Text("2Do".translate(), semanticsLabel: "Title".translate()),
        actions: <IconButton>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
            tooltip: "Search".translate(),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: _openSettings,
            tooltip: "Open Settings".translate(),
          )
        ],
      ),
      body: ListView.builder(
        addAutomaticKeepAlives: true,
        addRepaintBoundaries: true,
        addSemanticIndexes: true,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (_, counter) {
          return TodoTile(todo: _todo);
        },
        itemCount: 20,
        scrollDirection: Axis.vertical,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddTodo,
        child: const Icon(Icons.add_rounded),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      extendBody: true,
      extendBodyBehindAppBar: true,
    );

    return _scaffold;
  }

  /// Pushed the [SettingsMainScreen] on Top of the current Route
  void _openSettings() {
    Navigator.pushNamed(context, SettingsMainScreen.routeName).then(
      (_) => setState(() {}),
    );
  }

  void _openAddTodo() {
    Navigator.pushNamed(context, AddTodoScreen.routeName);
  }
}
