import 'dart:async';

import 'package:rxdart/rxdart.dart';

class ConvBloc {
  String expTemp = "0";
  final _convController = StreamController<String>();
  final _convSubject = BehaviorSubject<String>();

  Sink<String> get convText => _convController.sink;

  Stream<String> get convResult => _convSubject.stream;

  ConvBloc() {
    _convController.stream.listen((buttonText) {
      expTemp = (expTemp == "0") ? buttonText : (expTemp + buttonText);
      _convSubject.add(expTemp);
    });
  }

  dispose() {
    _convController.close();
    _convSubject.close();
  }
}
