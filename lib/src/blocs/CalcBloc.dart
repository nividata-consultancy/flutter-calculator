import 'dart:async';

import 'package:calculator/src/models/Calculator.dart';
import 'package:calculator/src/resources/CalculatorDataProvider.dart';
import 'package:calculator/src/utility/Process.dart';
import 'package:rxdart/rxdart.dart';

class CalcBloc {
  String expTemp = "0";
  final _expController = StreamController<String>();
  final _operatorController = StreamController<String>();
  final _operandController = StreamController<String>();
  final _clearController = StreamController<String>();
  final _backController = StreamController<String>();
  final _equalController = StreamController<String>();
  final _bracketController = StreamController<String>();
  final _totalSubject = BehaviorSubject<String>();
  final _expSubject = BehaviorSubject<String>();

  Sink<String> get buttonText => _expController.sink;

  Sink<String> get operator => _operatorController.sink;

  Sink<String> get operand => _operandController.sink;

  Sink<String> get clear => _clearController.sink;

  Sink<String> get back => _backController.sink;

  Sink<String> get equal => _equalController.sink;

  Sink<String> get bracket => _bracketController.sink;

  Stream<String> get exp => _expSubject.stream;

  Stream<String> get total => _totalSubject.stream;

  CalcBloc() {
    _expController.stream
        .listen((buttonText) => _processButtonText(buttonText: buttonText));

    var operatorStream = _operatorController.stream.share();
    var operandStream = _operandController.stream.share();
    var bracketStream =
        _bracketController.stream.map((buttonText) => expTemp).share();

    operatorStream.map((buttonText) {
      if (!Process.isDigit(expTemp.split('').last) &&
          expTemp.split('').last != ")") {
        expTemp = expTemp.replaceRange(expTemp.length - 1, expTemp.length, "");
      }
      return buttonText;
    }).listen(_calculate);

    operandStream.listen(_calculate);

    _clearController.stream.listen(_clear);

    _backController.stream.listen(_back);

    _equalController.stream.where((buttonText) {
      return buttonText.isNotEmpty && buttonText != "0";
    }).listen(_equal);

    bracketStream.where((expNew) => expNew == "0").listen((expNew) {
      expTemp = "(";
      _expSubject.add(expTemp);
      _totalSubject.add("0");
    });
    bracketStream
        .where((expNew) => expNew != "0")
        .map((expNew) {
          return expNew[expNew.length - 1];
        })
        .where((lastText) => Process.isCloseParentheses(lastText))
        .listen((lastText) {
          expTemp += "(";
          _expSubject.add(expTemp);
          _totalSubject.add(Process.getResult(expTemp).toString());
        });

    bracketStream
        .where((expNew) => expNew != "0")
        .map((expNew) {
          return expNew[expNew.length - 1];
        })
        .where((lastText) =>
            Process.isOperand(lastText) &&
            !Process.isCloseParentheses(lastText))
        .listen((lastText) {
          expTemp += "(";
          _expSubject.add(expTemp);
          _totalSubject.add(Process.getResult(expTemp).toString());
        });

    bracketStream
        .where((expNew) => expNew != "0")
        .map((expNew) {
          return expNew[expNew.length - 1];
        })
        .where((lastText) =>
            (Process.isDigit(lastText) ||
                Process.isCloseParentheses(lastText)) &&
            "(".allMatches(expTemp).length > ")".allMatches(expTemp).length)
        .listen((lastText) {
          expTemp += ")";
          _expSubject.add(expTemp);
          _totalSubject.add(Process.getResult(expTemp).toString());
        });
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

  void _equal(String buttonText) {
    expTemp = Process.getResult(expTemp).toString();
    print("equal $expTemp");
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

  _processButtonText({String buttonText}) {
    switch (CalculatorDataProvider.getButtonData(buttonText).textType) {
      case TextType.OPERATOR:
        operator.add(buttonText);
        break;
      case TextType.OPERAND:
        operand.add(buttonText);
        break;
      case TextType.CLEAR:
        clear.add(buttonText);
        break;
      case TextType.BACK:
        back.add(buttonText);
        break;
      case TextType.EQUAL:
        equal.add(buttonText);
        break;
      case TextType.BRACKET:
        bracket.add(buttonText);
        break;
    }
  }

  dispose() {
    _expSubject.close();
    _totalSubject.close();
    _expController.close();
    _operatorController.close();
    _operandController.close();
    _clearController.close();
    _backController.close();
    _equalController.close();
    _bracketController.close();
  }
}

final bloc = CalcBloc();
