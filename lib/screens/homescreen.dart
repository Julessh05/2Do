library screens;

import 'package:flutter/material.dart';
import 'package:todo/logic/jumper.dart';
import 'package:todo/logic/translate.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/screens/add_todo_screen.dart';
import 'package:todo/screens/settings_screens.dart';
import 'components/todo_tile.dart';

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
            onPressed: () => Jumper.openSearch(context),
            tooltip: "Search".translate(),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(
                context,
                SettingsMainScreen.routeName,
              ).then((value) => setState(() {}));
            },
            tooltip: "Open Settings".translate(),
          )
        ],
      ),
      body: body,
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

  Widget get body {
    final Widget _body;
    if (combinedListOfTodos.isEmpty) {
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
                "You don't have any Todos".translate(),
                semanticsLabel: "You don't have any Todos".translate(),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: _openAddTodo,
                child: Text(
                  "Add one".translate(),
                  semanticsLabel: "Add one".translate(),
                ),
                autofocus: false,
                clipBehavior: Clip.antiAliasWithSaveLayer,
              ),
            ],
          ),
        ),
      );
    } else {
      _body = ListView.builder(
        addAutomaticKeepAlives: true,
        addRepaintBoundaries: true,
        addSemanticIndexes: true,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (_, counter) {
          return TodoTile(todo: combinedListOfTodos[counter]);
        },
        itemCount: combinedListOfTodos.length,
        scrollDirection: Axis.vertical,
      );
    }
    return _body;
  }

  void _openAddTodo() {
    Navigator.pushNamed(context, AddTodoScreen.routeName).then(
      (value) => setState(() {}),
    );
  }
}
