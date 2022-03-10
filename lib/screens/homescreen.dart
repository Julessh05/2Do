library screens;

import 'package:flutter/material.dart';
import 'package:todo/logic/jumper.dart';
import 'package:todo/logic/translate.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/screens/add_todo_screen.dart';
import 'package:todo/screens/search_screen.dart';
import 'package:todo/screens/settings_screens.dart';
import 'package:todo/storage/storage.dart';
import 'components/todo_tile.dart';

// TODO: Remove in Production Code
final Todo _todo = Todo(
  time: DateTime.now(),
  title: "Todo",
  content: "Content",
  created: DateTime.now(),
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
    listOfTodos.add(_todo);
    final _scaffold = Scaffold(
      appBar: AppBar(
        title: Text("2Do".translate(), semanticsLabel: "Title".translate()),
        actions: <IconButton>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => Jumper.openSearch(context),
            tooltip: "Search".translate(),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Jumper.openSettings(context),
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
          return TodoTile(todo: listOfTodos[counter]);
        },
        itemCount: listOfTodos.length,
        scrollDirection: Axis.vertical,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Jumper.openAddTodo(context),
        child: const Icon(Icons.add_rounded),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      extendBody: true,
      extendBodyBehindAppBar: true,
    );

    return _scaffold;
  }
}
