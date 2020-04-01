import 'dart:async';

import 'package:rxdart/rxdart.dart';

class UiHandlerBloc {
  final _calcUiController = StreamController<bool>();
  final _convUiController = StreamController<bool>();

  final _calcUiSubject = BehaviorSubject<bool>();
  final _convUiSubject = BehaviorSubject<bool>();

  Sink<bool> get calcChipSelect => _calcUiController.sink;

  Sink<bool> get convChipSelect => _convUiController.sink;

  Stream<bool> get calcUi => _calcUiSubject.stream;

  Stream<bool> get convUi => _convUiSubject.stream;

  UiHandlerBloc() {
    _calcUiController.stream.listen((isSelected) {
      _calcUiSubject.add(isSelected);
    });

    _convUiController.stream.listen((isSelected) {
      _convUiSubject.add(isSelected);
    });
  }

  dispose() {
    _calcUiSubject.close();
    _convUiSubject.close();
    _calcUiController.close();
    _convUiController.close();
  }
}

final uiHandlerBloc = UiHandlerBloc();
