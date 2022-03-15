library screens;

import 'package:flutter/material.dart';
import 'package:todo/logic/jumper.dart';
import 'package:todo/logic/translate.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/models/todo_list.dart';
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
    TodoList.listOfCheckedTodos.add(Todo(title: "title", content: "content"));
    TodoList.listOfCheckedTodos.add(Todo(title: "title", content: "content1"));
    TodoList.listOfTodos.add(Todo(title: "title", content: "content"));
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
        onPressed: () => _openAddTodo(context),
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
    if (TodoList.combinedListOfTodos.isNotEmpty) {
      _body = ListView.builder(
        addAutomaticKeepAlives: true,
        addRepaintBoundaries: true,
        addSemanticIndexes: true,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (_, counter) {
          return TodoTile(todo: TodoList.listOfTodos[counter]);
        },
        itemCount: TodoList.listOfTodos.length,
        scrollDirection: Axis.vertical,
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
                "You don't have any Todos".translate(),
                semanticsLabel: "You don't have any Todos".translate(),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () => _openAddTodo(context),
                child: Text(
                  "Add one".translate(),
                  semanticsLabel: "Add one".translate(),
                ),
                autofocus: false,
                clipBehavior: Clip.antiAliasWithSaveLayer,
              ),
              const SizedBox(height: 20.0),
              TodoList.listOfCheckedTodos.isNotEmpty
                  ? _checkedTodoExpandTile
                  : Container(),
            ],
          ),
        ),
      );
    }
    return _body;
  }

  Widget get _checkedTodoExpandTile {
    final _body = ExpansionTile(
      title: Text(
        "Checked Todos".translate(),
        semanticsLabel: "Checked Todos".translate(),
      ),
      initiallyExpanded: false,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 2,
          child: ListView.builder(
            itemBuilder: (_, counter) {
              return TodoTile(todo: TodoList.listOfCheckedTodos[counter]);
            },
          ),
        )
      ],
    );
    return _body;
  }

  void _openAddTodo(BuildContext context) {
    Navigator.pushNamed(context, AddTodoScreen.routeName).then(
      (value) => setState(() {}),
    );
  }
}
