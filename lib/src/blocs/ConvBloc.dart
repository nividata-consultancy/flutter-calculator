import 'dart:async';
import 'dart:convert';

import 'package:calculator/src/models/Calculator.dart';
import 'package:calculator/src/models/Category.dart';
import 'package:calculator/src/models/ConvData.dart';
import 'package:calculator/src/models/Unit.dart';
import 'package:calculator/src/resources/CalculatorDataProvider.dart';
import 'package:calculator/src/utility/Process.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';

class ConvBloc {
  String inputText = "0";
  String resultText = "0";
  bool isUp = true;
  List<Category> categoryList;
  Category selectedCategory1;

  final _convInputController = StreamController<String>();
  final _convInputSubject = BehaviorSubject<ConvData>();

  final _operandController = StreamController<String>();
  final _clearController = StreamController<String>();
  final _backController = StreamController<String>();
  final _periodController = StreamController<String>();

  final _convResultSubject = BehaviorSubject<ConvData>();

  final _categoryListSubject = BehaviorSubject<List<Category>>();

  final _selectedCategoryController = StreamController<Category>();
  final _selectedCategorySubject = BehaviorSubject<Category>();

  final _firstSelectedItemMenuController = StreamController<String>();

  final _secondSelectedItemMenuController = StreamController<String>();

  Sink<String> get setConvInput => _convInputController.sink;

  Stream<ConvData> get getConvInput => _convInputSubject.stream;

  Sink<String> get operand => _operandController.sink;

  Sink<String> get clear => _clearController.sink;

  Sink<String> get back => _backController.sink;

  Sink<String> get period => _periodController.sink;

  Stream<ConvData> get getConvResult => _convResultSubject.stream;

  Stream<List<Category>> get getCategoryList => _categoryListSubject.stream;

  Sink<Category> get setSelectedCategory => _selectedCategoryController.sink;

  Stream<Category> get getSelectedCategory => _selectedCategorySubject.stream;

  Sink<String> get setFirstSelectedItemMenu =>
      _firstSelectedItemMenuController.sink;

  Sink<String> get setSecondSelectedItemMenu =>
      _secondSelectedItemMenuController.sink;

  ConvBloc() {
    _convInputController.stream
        .listen((buttonText) => _processButtonText(buttonText: buttonText));

    _clearController.stream.listen(_clear);

    _backController.stream.listen(_back);

    _periodController.stream
        .map((_) {
          if (isUp)
            return inputText;
          else
            return resultText;
        })
        .where((buttonText) => !Process.isListDigitContainDot(buttonText))
        .listen(_period);

    Stream.fromFuture(_retrieveLocalCategories()).listen((categoryList) {
      categoryList[0].isChipSelected = true;
      this.categoryList = categoryList;
      _categoryListSubject.add(categoryList);
      selectedCategory1 = categoryList[0];
      setSelectedCategory.add(categoryList[0]);
      print("init");
    });

    _firstSelectedItemMenuController.stream.map((String shortName) {
      Unit unit = _getUnit(shortName, selectedCategory1);
      selectedCategory1.firstDropdownShortName = unit.shortName;
      selectedCategory1.firstDropdownName = unit.name;

      print("menu 1 item");
      return selectedCategory1;
    }).map((Category category) {
      print("1st  $category");
      _selectedCategorySubject.add(category);
      return getResult(selectedCategory1);
    }).listen((result) {
      print("rest1 $result");
      if (isUp) {
        resultText = _format(result);
        _convResultSubject.add(ConvData(resultText, isUp));
      } else {
        inputText = _format(result);
        _convInputSubject.add(ConvData(inputText, isUp));
      }
    });

    _secondSelectedItemMenuController.stream.map((String shortName) {
      Unit unit = _getUnit(shortName, selectedCategory1);
      selectedCategory1.secondDropdownShortName = unit.shortName;
      selectedCategory1.secondDropdownName = unit.name;

      print("menu 2 item");
      return selectedCategory1;
    }).map((Category category) {
      print("2nd $category");
      _selectedCategorySubject.add(category);
      return getResult(selectedCategory1);
    }).listen((result) {
      print("rest2 $result");
      if (isUp) {
        resultText = _format(result);
        _convResultSubject.add(ConvData(resultText, isUp));
      } else {
        inputText = _format(result);
        _convInputSubject.add(ConvData(inputText, isUp));
      }
    });

    _operandController.stream.map((buttonText) {
      if (isUp && inputText.length < 12) {
        inputText = (inputText == "0")
            ? (buttonText == "." ? "0." : buttonText)
            : (inputText + buttonText);
        _convInputSubject.add(ConvData(inputText, isUp));
      } else if (!isUp && resultText.length < 12) {
        resultText = (resultText == "0")
            ? (buttonText == "." ? "0." : buttonText)
            : (resultText + buttonText);
        _convResultSubject.add(ConvData(resultText, isUp));
      }
      if (isUp)
        return inputText;
      else
        return resultText;
    }).map((text) {
      return getResult(selectedCategory1);
    }).listen((text) {
      print("input ${text}");
      if (isUp) {
        resultText = _format(text);
        _convResultSubject.add(ConvData(resultText, isUp));
      } else {
        inputText = _format(text);
        _convInputSubject.add(ConvData(inputText, isUp));
      }
    });

    _selectedCategoryController.stream.map((Category currentCategory) {
      for (var i = 0; i < categoryList.length; i++) {
        categoryList[i].isChipSelected = false;
      }
      var index = categoryList.indexOf(currentCategory);
      categoryList[index].isChipSelected = true;
      selectedCategory1 = currentCategory;
      _categoryListSubject.add(categoryList);
      _selectedCategorySubject.add(currentCategory);

      print("select cat change");
      return getResult(currentCategory);
    }).listen((result) {
      if (isUp) {
        resultText = _format(result);
        _convResultSubject.add(ConvData(resultText, isUp));
      } else {
        inputText = _format(result);
        _convInputSubject.add(ConvData(inputText, isUp));
      }
    });
  }

  void _clear(String buttonText) {
    inputText = "0";
    resultText = "0";
    operand.add("0");
  }

  void _back(String buttonText) {
    if (isUp) {
      if (inputText != "0") {
        if (inputText
            .replaceRange(inputText.length - 1, inputText.length, "")
            .isEmpty) {
          inputText = "0";
        } else {
          inputText = inputText.replaceRange(
              inputText.length - 1, inputText.length, "");
        }
      } else {
        inputText = "0";
      }
    } else {
      if (resultText != "0") {
        if (resultText
            .replaceRange(resultText.length - 1, resultText.length, "")
            .isEmpty) {
          resultText = "0";
        } else {
          resultText = resultText.replaceRange(
              resultText.length - 1, resultText.length, "");
        }
      } else {
        resultText = "0";
      }
    }
    if (isUp) {
      if (inputText == "0") {
        operand.add("0");
      } else {
        operand.add("");
      }
    } else {
      if (resultText == "0") {
        operand.add("0");
      } else {
        operand.add("");
      }
    }
  }

  void _period(String buttonText) {
    operand.add(".");
  }

  Future<List<Category>> _retrieveLocalCategories() async {
    final regularUnitsJson =
        rootBundle.loadString('assets/data/regular_units.json');

    final unitsData = JsonDecoder().convert(await regularUnitsJson);
    if (unitsData is! Map) {
      throw ("Date retreived from API is not Map");
    }
    final _categories = <Category>[];
    unitsData.keys.forEach((key) {
      final List<Unit> units = unitsData[key]
          .map<Unit>((dynamic data) => Unit.fromJson(data))
          .toList();
      var category = Category(name: key, units: units, isChipSelected: false);
      _categories.add(category);
    });
    return _categories;
  }

  Unit _getUnit(String unitShortName, Category currentCategory) {
    return currentCategory.units.firstWhere(
      (Unit unit) {
        return unit.shortName == unitShortName;
      },
      orElse: null,
    );
  }

  String _format(double conversion) {
    var outputNum = conversion.toStringAsPrecision(7);
    if (outputNum.contains('.') && outputNum.endsWith('0')) {
      var i = outputNum.length - 1;
      while (outputNum[i] == '0') {
        i -= 1;
      }
      outputNum = outputNum.substring(0, i + 1);
    }
    if (outputNum.endsWith('.')) {
      return outputNum.substring(0, outputNum.length - 1);
    }
    return outputNum;
  }

  _processButtonText({String buttonText}) {
    switch (CalculatorDataProvider.getButtonData(buttonText).textType) {
      case TextType.CLEAR:
        clear.add(buttonText);
        break;
      case TextType.BACK:
        back.add(buttonText);
        break;
      case TextType.UP:
        isUp = true;
        if (inputText == "0") {
          operand.add("0");
        } else {
          operand.add("");
        }
        break;
      case TextType.DOWN:
        isUp = false;
        if (resultText == "0") {
          operand.add("0");
        } else {
          operand.add("");
        }
        break;
      case TextType.OPERAND:
        operand.add(buttonText);
        break;
      case TextType.OPERATOR:
        break;
      case TextType.EQUAL:
        break;
      case TextType.BRACKET:
        break;
      case TextType.PERIOD:
        period.add(buttonText);
        break;
    }
  }

  dispose() {
    _convInputController.close();
    _convInputSubject.close();
    _operandController.close();
    _clearController.close();
    _backController.close();
    _periodController.close();
    _convResultSubject.close();
    _categoryListSubject.close();
    _firstSelectedItemMenuController.close();
    _secondSelectedItemMenuController.close();
    _selectedCategoryController.close();
    _selectedCategorySubject.close();
  }

  double getResult(Category currentCategory) {
    if (isUp) {
      double toValue;
      Unit toValueUnit =
          _getUnit(currentCategory.firstDropdownShortName, currentCategory);

      if (toValueUnit.baseUnit)
        toValue = toValueUnit.conversion;
      else {
        toValue = currentCategory.units[0].conversion / toValueUnit.conversion;
      }
      double fromValue =
          _getUnit(currentCategory.secondDropdownShortName, currentCategory)
              .conversion;
      return double.parse(inputText) * (toValue * fromValue);
    } else {
      double fromValue;
      Unit fromValueUnit =
          _getUnit(currentCategory.secondDropdownShortName, currentCategory);

      if (fromValueUnit.baseUnit)
        fromValue = fromValueUnit.conversion;
      else {
        fromValue =
            currentCategory.units[0].conversion / fromValueUnit.conversion;
      }
      double toValue =
          _getUnit(currentCategory.firstDropdownShortName, currentCategory)
              .conversion;
      return double.parse(resultText) * (toValue * fromValue);
    }
  }
}
