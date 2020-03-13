import 'dart:async';

import 'package:calculator/src/utility/Calculations.dart';
import 'package:calculator/src/utility/Process.dart';
import 'package:rxdart/rxdart.dart';

class CalcBloc {
  String expTemp = "0";
  final _expController = StreamController<String>();
  final _totalSubject = BehaviorSubject<String>();
  final _expSubject = BehaviorSubject<String>();

  Sink<String> get buttonText => _expController.sink;

  Stream<String> get exp => _expSubject.stream;

  Stream<String> get total => _totalSubject.stream;

  CalcBloc() {
    final buttonText = _expController.stream.share();

    buttonText
        .where((buttonText) =>
            buttonText != Calculations.CLEAR && buttonText != Calculations.BACK)
        .listen(_calculate);

    buttonText
        .where((buttonText) => buttonText == Calculations.CLEAR)
        .listen(_clear);

    buttonText
        .where((buttonText) => buttonText == Calculations.BACK)
        .listen(_back);
  }

  void _calculate(String buttonText) {
    expTemp = (expTemp == "0") ? buttonText : (expTemp + buttonText);
    _expSubject.add(expTemp);
    _totalSubject.add(Process.getResult(expTemp).toString());
  }

  void _clear(String buttonText) {
    expTemp = "0";
    _expSubject.add(expTemp);
    _totalSubject.add(expTemp);
    Process.clear();
  }

  void _back(String buttonText) {
    if (expTemp != "0") {
      if (expTemp
          .replaceRange(expTemp.length - 1, expTemp.length, "")
          .isEmpty) {
        expTemp = "0";
      } else {
        expTemp = expTemp.replaceRange(expTemp.length - 1, expTemp.length, "");
      }
    } else {
      expTemp = "0";
    }
    _expSubject.add(expTemp);
    _totalSubject.add(Process.getResult(expTemp).toString());
  }

  dispose() {
    _expSubject.close();
    _totalSubject.close();
    _expController.close();
  }
}

final bloc = CalcBloc();
