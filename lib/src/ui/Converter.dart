import 'package:calculator/src/expressionLanguage/expression_language.dart';
import 'package:flutter/material.dart';

class Converter extends StatefulWidget {
  @override
  _ConverterState createState() => _ConverterState();
}

class _ConverterState extends State<Converter> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0x00131313),
        appBar: AppBar(
          backgroundColor: Color(0x00131313),
          title: Text("Converter"),
        ),
        body: Column(
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
        ));
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
