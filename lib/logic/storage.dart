library logic;

import 'dart:io';

class Storage {
  static final _todoFile = File("${Directory.systemTemp}Todos.txt");

  static void storeTodos() {}
}
