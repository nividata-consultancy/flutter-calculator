import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:convert/convert.dart';
import 'package:calculator/src/models/Category.dart';
import 'package:calculator/src/models/Unit.dart';
import 'dart:convert';

class ConverterCalc extends StatefulWidget {
  @override
  _ConverterCalcState createState() => _ConverterCalcState();
}

class _ConverterCalcState extends State<ConverterCalc> {
  Color _textColor;

  final _categories = <Category>[];
  Category _defaultCategory;
  Category _currentCategory;
  final _selectedChip = <bool>[];

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
        _selectedChip.add(false);
      });
      categoryIndex++;
    });
    _selectedChip[0] = true;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textColor = Color(0x00131313);
  }

  void _onCategoryTap(Category category) {
    print("ouch i was tapped ${category.name}");
    _currentCategory = category;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: choiceChipWidget(),
        ),
        Expanded(
          flex: 3,
          child: Container(
            margin: EdgeInsets.fromLTRB(20, 15, 20, 10),
            decoration: BoxDecoration(
                color: Color(0xFF480048),
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            constraints: BoxConstraints.expand(),
            margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
            decoration: BoxDecoration(
                color: Color(0xFF484848),
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            child: Column(
              children: <Widget>[Text("hello")],
            ),
          ),
        ),
        Expanded(
          flex: 10,
          child: Container(),
        ),
      ],
    );
  }

  Widget choiceChipWidget() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: _categories.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: EdgeInsets.all(6.0),
          child: ChoiceChip(
            padding: EdgeInsets.all(5.0),
            label: Text(_categories[index].name,
                style: TextStyle(color: Color(0xFF009C88))),
            selected: _selectedChip[index],
            onSelected: (bool selected) {
              setState(() {
                for (var i = 0; i < _selectedChip.length; i++) {
                  _selectedChip[i] = false;
                }
                _selectedChip[index] = true;
                _currentCategory = selected ? _categories[index] : null;
                _onCategoryTap(_categories[index]);
              });
            },
            pressElevation: 2.0,
            elevation: 0.0,
            selectedShadowColor: Colors.white60,
            selectedColor: Colors.white,
            backgroundColor: Colors.grey[900],
          ),
        );
      },
    );
  }
}
