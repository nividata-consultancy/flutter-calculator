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
    return Expanded(
      flex: 44,
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: choiceChipWidget(),
          ),
          Expanded(
            flex: 4,
            child: Container(
              constraints: BoxConstraints.expand(),
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              margin: EdgeInsets.fromLTRB(20, 15, 20, 10),
              decoration: BoxDecoration(
                  color: Color(0xFF484848),
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: DropdownButton<String>(
                      underline: SizedBox(),
                      items: <String>["a", "b", "c"].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (_) {},
                    ),
                  ),
                  Align(alignment: Alignment.centerRight, child: Text("123"))
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
                margin: EdgeInsets.fromLTRB(20, 10, 20, 15),
                decoration: BoxDecoration(
                    color: Color(0xFF484848),
                    borderRadius: BorderRadius.all(Radius.circular(20.0)))),
          ),
        ],
      ),
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
            label: Text(_choiceChipsVal[index],
                style: TextStyle(color: Color(0xFF009C88))),
            selected: _defaultSelection == index,
            onSelected: (bool selected) {
              setState(() {
                _defaultSelection = selected ? index : null;
              });
            },
            elevation: 0,
            pressElevation: 0,
            selectedColor: Colors.white70,
            backgroundColor: Colors.grey[900],
          ),
        );
      },
    );
  }
}
