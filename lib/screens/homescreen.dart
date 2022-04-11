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
    for (Todo todo in TodoList.listOfTodos) {
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
                for (Todo todo in TodoList.listOfTodos) {
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
          onPressed: () => _openCheckedTodos(context),
          icon: const Icon(Icons.check_circle_outline_rounded),
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
    if (TodoList.listOfTodos.isNotEmpty) {
      _body = ListView.builder(
        addAutomaticKeepAlives: true,
        addRepaintBoundaries: true,
        addSemanticIndexes: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        dragStartBehavior: DragStartBehavior.start,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (_, counter) {
          return TodoTile(
            todo: TodoList.listOfTodos[counter],
            setStateFunc: _setStateAfterTodoCheck,
          );
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

  /// Opens the [AddTodoScreen] where you can add a Todo
  void _openAddTodo(BuildContext context) {
    Navigator.pushNamed(context, AddTodoScreen.routeName).then(
      (value) => setState(() {}),
    );
  }

  /// Opens the [CheckedTodosScreen] where you can see all checked Todos
  void _openCheckedTodos(BuildContext context) {
    Navigator.pushNamed(context, CheckedTodosScreen.routeName)
        .then((value) => setState(() {}));
  }

  /// Callback Method called when a Todo is checked
  void _setStateAfterTodoCheck() {
    setState(() {});
  }
}

/// Screen which shows all the checked Todos.
class CheckedTodosScreen extends StatefulWidget {
  const CheckedTodosScreen({Key? key}) : super(key: key);

  static const routeName = '/checked_todos';

  @override
  State<CheckedTodosScreen> createState() => _CheckedTodosScreenState();
}

class _CheckedTodosScreenState extends State<CheckedTodosScreen> {
  @override
  Widget build(BuildContext context) {
    final _scaffold = Scaffold(
      appBar: _appBar,
      body: _body,
    );

    return _scaffold;
  }

  AppBar get _appBar {
    bool selected = false;
    final AppBar _appBar;
    for (Todo todo in TodoList.listOfCheckedTodos) {
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
                for (Todo todo in TodoList.listOfCheckedTodos) {
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
        automaticallyImplyLeading: true,
        title: Text(
          'Checked Todos'.tr(),
          semanticsLabel: 'Checked Todos'.tr(),
        ),
      );
    }
    return _appBar;
  }

  /// Returns the Body of the Screen depending on the [TodoList.listOfCheckedTodos]
  Widget get _body {
    final Widget _body;
    if (TodoList.listOfCheckedTodos.isNotEmpty) {
      _body = ListView.builder(
        addAutomaticKeepAlives: true,
        addRepaintBoundaries: true,
        addSemanticIndexes: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        dragStartBehavior: DragStartBehavior.start,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        itemCount: TodoList.listOfCheckedTodos.length,
        itemBuilder: (_, counter) {
          return TodoTile(
            todo: TodoList.listOfCheckedTodos[counter],
            setStateFunc: _setStateAfterTodoCheck,
          );
        },
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
                'None of your Todos are checked'.tr(),
                semanticsLabel: 'None of your Todos are checked'.tr(),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () => Jumper.backToTheHomescreen(context),
                child: Text(
                  'Back to the Homescreen'.tr(),
                  semanticsLabel: 'Back to the Homescreen'.tr(),
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

  /// Callback Method called when a Todo is unchecked
  void _setStateAfterTodoCheck() {
    setState(() {});
  }
}
