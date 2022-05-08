library blocs;

import 'dart:async';

import 'package:bloc_implementation/bloc_implementation.dart';

class MainBloc extends Bloc {
  final StreamController _controller = StreamController();

  StreamController get controller => _controller;

  @override
  void dispose() {
    _controller.close();
  }
}
