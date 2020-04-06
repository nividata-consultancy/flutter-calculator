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
  Category _initialCategory =
      Category(name: "Length", isChipSelected: true, units: [
    Unit(name: "Meter", conversion: 1.0, shortName: "m", baseUnit: true),
    Unit(
        name: "Millimeter",
        conversion: 1000.0,
        shortName: "mm",
        baseUnit: false)
  ]);

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
