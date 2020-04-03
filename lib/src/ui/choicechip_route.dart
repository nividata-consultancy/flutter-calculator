import 'package:calculator/src/models/Category.dart';
import 'package:calculator/src/models/Unit.dart';
import 'package:flutter/material.dart';
import 'dart:convert';


class ChoiceChipRoute extends StatefulWidget {
  @override
  _ChoiceChipRouteState createState() => _ChoiceChipRouteState();
}

class _ChoiceChipRouteState extends State<ChoiceChipRoute> {
  final _categories = <Category>[];
  Category _defaultCategory;
  Category _currentCategory;

  @override
  Future<void> didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    if (_categories.isEmpty) {
      await _retrieveLocalCategories();
    }
  }

  Future<void> _retrieveLocalCategories() async {
    final regularUnitsJson = DefaultAssetBundle.of(context)
        .loadString('assets/data/regular_units.json');
    final unitsData = JsonDecoder().convert(await regularUnitsJson);
    if (unitsData is! Map) {
      throw ("Date retreived from API is not Map");
    }
    var categoryIndex = 0;
    unitsData.keys.forEach((key) {
      print(key);
      final List<Unit> units = unitsData[key]
          .map<Unit>((dynamic data) => Unit.fromJson(data))
          .toList();

      var category = Category(name: key, units: units);
      setState(() {
        if (categoryIndex == 0) {
          _defaultCategory = category;
        }
        _categories.add(category);
      });
      categoryIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
