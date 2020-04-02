import 'dart:async';

import 'package:rxdart/rxdart.dart';

class UiHandlerBloc {
  final _chipChangeController = StreamController<bool>();

  final _chipChangeSubject = BehaviorSubject<bool>();

  Sink<bool> get calcChipSelect => _chipChangeController.sink;

  Stream<bool> get chipChange => _chipChangeSubject.stream;

  UiHandlerBloc() {
    _chipChangeController.stream.listen((isSelected) {
      _chipChangeSubject.add(isSelected);
    });
  }

  dispose() {
    _chipChangeSubject.close();
    _chipChangeController.close();
  }
}

final uiHandlerBloc = UiHandlerBloc();
