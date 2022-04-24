library screens;

import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';
import 'package:todo/logic/jumper.dart';
import 'package:string_translate/string_translate.dart' show Translate;
import 'package:todo/models/todo.dart' show Todo;
import 'package:todo/models/todo_list.dart';
import 'package:todo/screens/add_todo_screen.dart';
import 'package:todo/screens/settings_screens.dart';

import 'package:todo/screens/components/todo_tile.dart';

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
      appBar: _appBar,
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

    return _scaffold;
  }

  /// AppBar which depends on whether you have selected
  /// one or more Todos or not
  AppBar get _appBar {
    bool selected = false;
    final AppBar _appBar;
    for (Todo todo in TodoList.combinedListOfTodos) {
      if (todo.selected) {
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
                final List<Todo> _list = [];
                for (Todo todo in TodoList.combinedListOfTodos) {
                  if (todo.selected) {
                    _list.add(todo);
                  } else {
                    continue;
                  }
                }
                for (Todo todo in _list) {
                  TodoList.deleteTodo(todo);
                }
              });
            },
            tooltip: 'Delete Todo'.tr(),
          ),
        ],
      );
    } else {
      _appBar = AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          tooltip: 'Show Checked Todos'.tr(),
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
      );
    }
    return _appBar;
  }

  /// Returns the Body of the Screen depending on the [TodoList.listOfTodos]
  Widget get _body {
    final Widget _body;
    if (TodoList.combinedListOfTodos.isNotEmpty) {
      final _list = <Widget>[];
      _list.addAll(_todoTiles);
      if (TodoList.listOfCheckedTodos.isNotEmpty) {
        _list.add(
          ListTile(
            title: Text('Checked Todos:'.tr()),
          ),
        );
      }
      _list.addAll(_checkedTodoTiles);
      _body = ListView(
        addAutomaticKeepAlives: true,
        addRepaintBoundaries: true,
        addSemanticIndexes: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        dragStartBehavior: DragStartBehavior.start,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const BouncingScrollPhysics(),
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
                'You don\'t have any Todos'.tr(),
                semanticsLabel: 'You don\'t have any Todos'.tr(),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () => _openAddTodo(context),
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

  /// Builds the List of Todos
  List<TodoTile> get _todoTiles {
    final List<TodoTile> _list = [];
    for (Todo todo in TodoList.listOfTodos) {
      _list.add(
        TodoTile(
          todo: todo,
          setStateFunc: _setStateAfterTodoCheck,
        ),
      );
    }
    return _list;
  }

  List<TodoTile> get _checkedTodoTiles {
    final List<TodoTile> _list = [];
    for (int counter = 0;
        counter < TodoList.listOfCheckedTodos.length;
        counter++) {
      _list.add(
        TodoTile(
          todo: TodoList.listOfCheckedTodos[counter],
          setStateFunc: _setStateAfterTodoCheck,
        ),
      );
    }
    return _list;
  }

  /// Opens the [AddTodoScreen] where you can add a Todo
  void _openAddTodo(BuildContext context) {
    Navigator.pushNamed(context, AddTodoScreen.routeName).then(
      (value) => setState(() {}),
    );
  }

  /// Callback Method called when a Todo is checked
  void _setStateAfterTodoCheck() {
    setState(() {});
  }
}
