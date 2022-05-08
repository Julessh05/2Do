library blocs;

import 'dart:async' show StreamController, StreamSubscription;

import 'package:bloc_implementation/bloc_implementation.dart';
import 'package:flutter/material.dart';

/// The Main Bloc for this App
class MainBloc extends Bloc {
  /// Controlls the ThemeMode Stream. Is used to change the ThemeMode
  final _themeModeController = StreamController<ThemeMode>();

  /// Stream Subscription for the ThemeMode Stream
  late final StreamSubscription<ThemeMode> _themeModeSub;

  @override
  void init() {
    super.init();
    _themeModeSub = _themeModeController.stream.listen((event) {});
  }

  StreamController<ThemeMode> get themeModeController => _themeModeController;

  @override
  void dispose() {
    _themeModeController.close();
  }
}
