library screens;

import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';
import 'package:string_translate/string_translate.dart' show Translate;
import 'package:todo/main.dart' show TodoApp;
import 'package:todo/logic/jumper.dart';
import 'package:todo/models/todo.dart' show Todo;
import 'package:todo/models/todo_list.dart';
import 'package:todo/screens/add_todo_screen.dart';
import 'package:todo/screens/components/todo_tile.dart';

class SortedTodoScreen extends StatefulWidget {
  const SortedTodoScreen({
    required this.tag,
    Key? key,
  }) : super(key: key);

  final String? tag;

  /// The Name of the Route for this Screen.
  /// Is used to navigate trough the App.
  /// These Values are set in the [MaterialApp] of the [TodoApp]
  static const routeName = '/sorted_todo_screen';

  @override
  State<SortedTodoScreen> createState() => _SortedTodoScreenState();
}

class _SortedTodoScreenState extends State<SortedTodoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: _body,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openAddTodo(context, widget.tag),
        child: const Icon(Icons.add_rounded),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      extendBody: true,
      extendBodyBehindAppBar: true,
    );
  }

  /// AppBar which depends on whether you have selected
  /// one or more Todos or not
  AppBar get _appBar {
    bool selected = false;
    final AppBar appBar;
    for (Todo todo in TodoList.combinedListOfTodos) {
      if (todo.selected) {
        selected = true;
        break;
      } else {
        continue;
      }
    }
    if (selected) {
      appBar = AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            setState(() {
              for (Todo todo in TodoList.combinedListOfTodos) {
                todo.selected = false;
              }
            });
          },
          icon: Icon(Icons.adaptive.arrow_back),
        ),
        title: Text(
          'Edit'.tr(),
          semanticsLabel: 'Edit'.tr(),
        ),
        actions: <IconButton>[
          IconButton(
            icon: const Icon(Icons.delete_outline_rounded),
            onPressed: () {
              setState(() {
                final List<Todo> list = [];
                for (Todo todo in TodoList.combinedListOfTodos) {
                  if (todo.selected) {
                    list.add(todo);
                  } else {
                    continue;
                  }
                }
                for (Todo todo in list) {
                  TodoList.deleteTodo(todo);
                }
              });
            },
            tooltip: 'Delete Todo'.tr(),
          ),
        ],
      );
    } else {
      appBar = AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          widget.tag ?? 'All Todos'.tr(),
          semanticsLabel: 'Title'.tr(),
        ),
        actions: <IconButton>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => Jumper.openSearch(context),
            tooltip: 'Search'.tr(),
          ),
        ],
      );
    }
    return appBar;
  }

  /// Returns the Body of the Screen depending on the [TodoList.listOfTodos]
  Widget get _body {
    final Widget body;
    if (TodoList.allTodosWithSpecificTag(widget.tag).isEmpty) {
      body = Center(
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
                'You don\'t have any Todos with this Tag'.tr(),
                semanticsLabel: 'You don\'t have any Todos with this Tag'.tr(),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () => _openAddTodo(context, widget.tag),
                autofocus: false,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Text(
                  'Add one'.tr(),
                  semanticsLabel: 'Add one'.tr(),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      final list = <Widget>[];
      list.addAll(_todoTilesWithTag(widget.tag));
      if (TodoList.listOfCheckedTodos.isNotEmpty) {
        list.add(
          ListTile(
            title: Text('Checked Todos:'.tr()),
          ),
        );
      }
      list.addAll(_checkedTodoTilesWithTag(widget.tag));
      body = ListView(
        addAutomaticKeepAlives: true,
        addRepaintBoundaries: true,
        addSemanticIndexes: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        dragStartBehavior: DragStartBehavior.start,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const BouncingScrollPhysics(),
        children: list,
      );
    }
    return body;
  }

  /// Builds the List of Todos
  List<TodoTile> _todoTilesWithTag(String? tag) {
    final List<TodoTile> list = [];
    for (Todo todo in TodoList.allTodosWithSpecificTag(tag)) {
      if (!todo.checked) {
        list.add(
          TodoTile(
            todo: todo,
            setStateFunc: _setStateAfterTodoCheck,
          ),
        );
      } else {
        continue;
      }
    }
    return list;
  }

  List<TodoTile> _checkedTodoTilesWithTag(String? tag) {
    final List<TodoTile> list = [];
    for (Todo todo in TodoList.allTodosWithSpecificTag(tag)) {
      if (todo.checked) {
        list.add(
          TodoTile(
            todo: todo,
            setStateFunc: _setStateAfterTodoCheck,
          ),
        );
      } else {
        continue;
      }
    }
    return list;
  }

  /// Opens the [AddTodoScreen] where you can add a Todo
  void _openAddTodo(BuildContext context, String? tag) {
    Navigator.pushNamed(context, AddTodoScreen.routeName, arguments: tag).then(
      (value) => setState(() {}),
    );
  }

  /// Callback Method called when a Todo is checked
  void _setStateAfterTodoCheck() {
    setState(() {});
  }
}
