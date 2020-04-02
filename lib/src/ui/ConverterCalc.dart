import 'dart:convert';
import 'package:flutter/material.dart';


class ConverterCalc extends StatefulWidget {
  @override
  _ConverterCalcState createState() => _ConverterCalcState();
}

class Length {
  int id;
  String unit;
  String abbreviation;

  Length(this.id, this.unit, this.abbreviation);

  static List<Length> getLength() {
    Length(1, "Millimetre", "mm");
    Length(2, "Kilometre", "km");
    Length(3, "Metre", "m");
    Length(4, "Centimetre", "cm");
    Length(5, "Micrometre", "mcm");
    Length(6, "Nanometre", "nm");
    Length(7, "Mile", "mi");
    Length(8, "Yard", "yd");
    Length(9, "Foot", "ft");
    Length(10, "inch", "in");
    Length(11, "Nauticle mile", "NM");
  }
}

class _ConverterCalcState extends State<ConverterCalc> {
  int _value = 1;
  List<String> _choiceChipsVal;
  int _defaultSelection;
  Color _textColor;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _choiceChipsVal = [
      " Area ",
      " Length ",
      " Temperature ",
      " Volume ",
      " Mass ",
      " Data "
    ];
    _defaultSelection = 0;
    _textColor = Color(0x00131313);
  }

//  calculateSomething() {
//    var areaConverter = getConverter(Converter.length);
//    var val = areaConverter.convert(
//        value: 200, from: LengthUnit.metre, to: LengthUnit.centiMetre);
////    print(val);
//  }

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
                color: Color(0xFF484848),
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
              margin: EdgeInsets.fromLTRB(20, 10, 20, 15),
              decoration: BoxDecoration(
                  color: Color(0xFF484848),
                  borderRadius: BorderRadius.all(Radius.circular(20.0)))),
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
      itemCount: _choiceChipsVal.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: EdgeInsets.all(6.0),
          child: ChoiceChip(
            padding: EdgeInsets.all(5.0),
            label: Text(_choiceChipsVal[index],
                style: TextStyle(color: Color(0xFF009C88))),
            selected: _defaultSelection == index,
            onSelected: (bool selected) {
              setState(() {
//                calculateSomething();
                _defaultSelection = selected ? index : null;
              });
            },
            elevation: 5.0,
            selectedShadowColor: Colors.white,
            selectedColor: Colors.white60,
            backgroundColor: Colors.grey[900],
          ),
        );
      },
    );
  }
}
