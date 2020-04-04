import 'dart:async';
import 'dart:convert';

import 'package:calculator/src/models/Category.dart';
import 'package:calculator/src/models/Unit.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';

class ConvBloc {
  String expTemp = "0";
  final _convController = StreamController<String>();
  final _convSubject = BehaviorSubject<String>();

  final _categoryListController = StreamController<List<Category>>();
  final _categoryListSubject = BehaviorSubject<List<Category>>();

  final _selectedCategoryController = StreamController<Category>();
  final _selectedCategorySubject = BehaviorSubject<Category>();

  final _firstDropdownListController = StreamController<List<Unit>>();
  final _firstDropdownListSubject = BehaviorSubject<List<Unit>>();

  final _secondDropdownListController = StreamController<List<Unit>>();
  final _secondDropdownListSubject = BehaviorSubject<List<Unit>>();

  Sink<String> get convText => _convController.sink;

  Stream<String> get convResult => _convSubject.stream;

  Sink<List<Category>> get setCategoryList => _categoryListController.sink;

  Stream<List<Category>> get getCategoryList => _categoryListSubject.stream;

  Sink<Category> get setSelectedCategoryList =>
      _selectedCategoryController.sink;

  Stream<Category> get getSelectedCategoryList =>
      _selectedCategorySubject.stream;

  Sink<List<Unit>> get setFirstUnitList => _firstDropdownListController.sink;

  Stream<List<Unit>> get getFirstUnitList => _firstDropdownListSubject.stream;

  Sink<List<Unit>> get setSecondUnitList => _secondDropdownListController.sink;

  Stream<List<Unit>> get getSecondUnitList => _secondDropdownListSubject.stream;

  ConvBloc() {
    _convController.stream.listen((buttonText) {
      expTemp = (expTemp == "0") ? buttonText : (expTemp + buttonText);
      _convSubject.add(expTemp);
    });
    Stream.fromFuture(_retrieveLocalCategories()).listen((categoryList) {
      print(categoryList.length);
      _categoryListSubject.add(categoryList);
      _selectedCategorySubject.add(categoryList[0]);
      _firstDropdownListSubject.add(categoryList[0].units);
      var x = categoryList[0].units;
      x.remove(0);
      _secondDropdownListSubject.add(x);
    });
    getFirstUnitList.listen((cate) {
      cate.forEach((f) {
        print(f.name);
      });
    });
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
      var category = Category(name: key, units: units);
      _categories.add(category);
    });
    return _categories;
  }

  dispose() {
    _convController.close();
    _convSubject.close();
    _categoryListController.close();
    _categoryListSubject.close();
    _firstDropdownListController.close();
    _firstDropdownListSubject.close();
    _secondDropdownListController.close();
    _secondDropdownListSubject.close();
    _selectedCategoryController.close();
    _selectedCategorySubject.close();
  }
}
