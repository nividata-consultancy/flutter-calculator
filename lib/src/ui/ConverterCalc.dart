import 'dart:convert';
import 'package:calculator/src/blocs/ConvBloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:calculator/src/models/Category.dart';
import 'package:calculator/src/models/Unit.dart';

class ConverterCalc extends StatefulWidget {
  final ConvBloc convBloc;

  ConverterCalc(this.convBloc);

  @override
  _ConverterCalcState createState() => _ConverterCalcState();
}

class _ConverterCalcState extends State<ConverterCalc> {
  Color _textColor;
  Category _initialCategory =
      Category(name: "Length", isChipSelected: true, units: [
    Unit(name: "Meter", conversion: 1.0, shortName: "m"),
    Unit(name: "Millimeter", conversion: 1000.0, shortName: "mm")
  ]);

  final _categories = <Category>[];
  Category _currentCategory;
  final _selectedChip = <bool>[];
  List<DropdownMenuItem> _unitMenuItems;
  Unit _fromValue;
  Unit _toValue;
  double _inputValue = 1;
  String _convertedValue = '';

  Future<void> _retrieveLocalCategories() async {
    final regularUnitsJson = DefaultAssetBundle.of(context)
        .loadString('assets/data/regular_units.json');
    final unitsData = JsonDecoder().convert(await regularUnitsJson);
    if (unitsData is! Map) {
      throw ("Date retreived from API is not Map");
    }
    var categoryIndex = 0;
    unitsData.keys.forEach((key) {
      final List<Unit> units = unitsData[key]
          .map<Unit>((dynamic data) => Unit.fromJson(data))
          .toList();
      var category = Category(name: key, units: units);

      setState(() {
        if (categoryIndex == 0) {
          _currentCategory = category;
        }
        _categories.add(category);
        _selectedChip.add(false);
      });
      categoryIndex++;
    });
    _createDropdownMenuItems(_currentCategory);
    _selectedChip[0] = true;
  }

  @override
  void initState() {
    super.initState();
    _textColor = Color(0x00131313);
  }

  void _onCategoryTap(Category category) {
    print("ouch i was tapped ${category.name}");
    setState(() {
      _currentCategory = category;
    });
    _createDropdownMenuItems(_currentCategory);
  }

  void _createDropdownMenuItems(Category selectedCategory) {
    var newItems = <DropdownMenuItem>[];
    for (var unit in selectedCategory.units) {
      newItems.add(DropdownMenuItem(
        value: unit.shortName,
        child: Container(
          child: Text(
            unit.shortName,
            softWrap: true,
          ),
        ),
      ));
    }
    setState(() {
      _unitMenuItems = newItems;
      _fromValue = selectedCategory.units[0];
      _toValue = selectedCategory.units[1];
    });
  }

  void _updateToConversion(dynamic unitName) {
    setState(() {
      _toValue = _getUnit(unitName);
      print(_toValue.name);
    });

    if (_inputValue != null) {
      _updateConversion();
    }
  }

  void _updateFromConversion(dynamic unitShortName) {
    setState(() {
      _fromValue = _getUnit(unitShortName);
    });

    if (_inputValue != null) {
      _updateConversion();
    }
  }

  Future<void> _updateConversion() async {
    setState(() {
      _convertedValue =
          _format(_inputValue * (_toValue.conversion / _fromValue.conversion));
    });
    print(_convertedValue);
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

  Unit _getUnit(String unitShortName) {
    return _currentCategory.units.firstWhere(
      (Unit unit) {
        return unit.shortName == unitShortName;
      },
      orElse: null,
    );
  }

  Widget _createDropDownButton(
      String currentVal, ValueChanged<dynamic> onChanged) {
    return DropdownButton(
        onChanged: onChanged,
        value: currentVal,
        items: _unitMenuItems,
        style: Theme.of(context).textTheme.title);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 44,
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: choiceChipWidget(),
          ),
          Expanded(
            flex: 3,
            child: Container(
              constraints: BoxConstraints.expand(),
              margin: EdgeInsets.fromLTRB(20, 15, 20, 10),
              decoration: BoxDecoration(
                  color: Color(0xFF484848),
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              child: Column(
                children: <Widget>[
                  StreamBuilder<Category>(
                      stream: widget.convBloc.getSelectedCategory,
                      initialData: _initialCategory,
                      builder: (context, snapshot) {
                        return Row(
                          children: <Widget>[
                            Expanded(
                              flex: 6,
                              child: Container(
                                margin: EdgeInsets.fromLTRB(24, 10, 0, 0),
                                child: Text(
                                  snapshot.data.firstDropdownName,
                                  style: TextStyle(fontSize: 22),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: DropdownButton(
                                    onChanged: (unit) {
                                      widget.convBloc.setFirstSelectedItemMenu
                                          .add(unit);
                                    },
                                    value: snapshot.data.firstDropdownShortName,
                                    items: snapshot.data.units.map((unit) {
                                      return DropdownMenuItem(
                                        value: unit.shortName,
                                        child: Container(
                                          child: Text(
                                            unit.shortName,
                                            softWrap: true,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    style: Theme.of(context).textTheme.title),
                              ),
                            )
                          ],
                        );
                      }),
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    alignment: Alignment.topLeft,
                    child: StreamBuilder<String>(
                        initialData: "0",
                        stream: widget.convBloc.getConvInput,
                        builder: (context, snapshot) {
                          return Text(snapshot.data,
                              style: TextStyle(fontSize: 10));
                        }),
                  )
                ],
              ),
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
                children: <Widget>[
                  StreamBuilder<Category>(
                      initialData: _initialCategory,
                      stream: widget.convBloc.getSelectedCategory,
                      builder: (context, snapshot) {
                        return Row(
                          children: <Widget>[
                            Expanded(
                              flex: 6,
                              child: Container(
                                margin: EdgeInsets.fromLTRB(24, 10, 0, 0),
                                child: Text(
                                  snapshot.data.secondDropdownName,
                                  style: TextStyle(fontSize: 22),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: DropdownButton(
                                    onChanged: (unit) {
                                      widget.convBloc.setSecondSelectedItemMenu
                                          .add(unit);
                                    },
                                    value:
                                        snapshot.data.secondDropdownShortName,
                                    items: snapshot.data.units.map((unit) {
                                      return DropdownMenuItem(
                                        value: unit.shortName,
                                        child: Container(
                                          child: Text(
                                            unit.shortName,
                                            softWrap: true,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    style: Theme.of(context).textTheme.title),
                              ),
                            )
                          ],
                        );
                      }),
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    alignment: Alignment.topLeft,
                    child: StreamBuilder<String>(
                        initialData: "0",
                        stream: widget.convBloc.getConvResult,
                        builder: (context, snapshot) {
                          return Text(snapshot.data,
                              style: TextStyle(fontSize: 10));
                        }),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget choiceChipWidget() {
    return StreamBuilder<List<Category>>(
        stream: widget.convBloc.getCategoryList,
        initialData: <Category>[_initialCategory],
        builder: (context, snapshot) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: EdgeInsets.all(6.0),
                child: ChoiceChip(
                  padding: EdgeInsets.all(5.0),
                  label: Text(snapshot.data[index].name,
                      style: TextStyle(color: Color(0xFF009C88))),
                  selected: snapshot.data[index].isChipSelected,
                  onSelected: (bool selected) {
                    widget.convBloc.setSelectedCategory
                        .add(snapshot.data[index]);
                    /*setState(() {
                      for (var i = 0; i < _selectedChip.length; i++) {
                        _selectedChip[i] = false;
                      }
                      _selectedChip[index] = true;
                      _currentCategory = selected ? _categories[index] : null;
                      _onCategoryTap(_categories[index]);

                    });*/
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
        });
  }
}
