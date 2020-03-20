import 'package:calculator/src/resources/CalculatorDataProvider.dart';
import 'package:calculator/src/utility/Process.dart';
import 'package:calculator/src/ui/displayExp.dart';
import 'package:calculator/src/ui/resultValue.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

typedef void CalculatorButtonTapCallback({String buttonText});

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyApp();
  }
}

class _MyApp extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Color(0xffebebee), brightness: Brightness.light),
      home: HomeWidget(),
    );
  }
}

class HomeWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeWidget();
  }
}

class _HomeWidget extends State<HomeWidget> {
  String exp = "0";
  String result = "0";
  int openParenthesis = 0;

  changeExp(String buttonText) {
    setState(() {
      exp = (exp == "0") ? buttonText : (exp + buttonText);
      result = Process.getResult(exp);
    });
  }

  clear() {
    setState(() {
      Process.clear();
      exp = "0";
      result = "0";
    });
  }

  back() {
    setState(() {
      if (exp != "0") {
        if (exp.replaceRange(exp.length - 1, exp.length, "").isEmpty) {
          exp = "0";
        } else {
          exp = exp.replaceRange(exp.length - 1, exp.length, "");
        }
      } else {
        exp = "0";
      }
      result = Process.getResult(exp);
    });
  }

  @override
  Widget build(BuildContext context) {
    final double size = (MediaQuery.of(context).size.width / 4) - 12;
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculator"),
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.all(5),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
              padding: EdgeInsets.all(5),
              constraints: BoxConstraints.tightForFinite(
                  height: 1.4 * size, width: double.maxFinite),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  // BoxShape.circle or BoxShape.retangle
                  color: Color(0xFFEFEFEF),
                  border: Border(
                    left: BorderSide(
                      color: Color(0xFFb6b6b8),
                      width: 4.0,
                    ),
                    top: BorderSide(
                      color: Color(0xFFb6b6b8),
                      width: 3.0,
                    ),
                    bottom: BorderSide(
                      color: Color(0xfffefefe),
                      width: 2.0,
                    ),
                    right: BorderSide(
                      color: Color(0xfffefefe),
                      width: 1.0,
                    ),
                  )),
              child: Column(
                children: <Widget>[
                  DisplayExp(exp: exp, size: size),
                  ResultValue(result: result),
                ],
              ),
            ),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Container(
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            ButtonView(
                                text: "%", size: size, onTap: _onButtonClick),
                            ButtonView(
                                text: "CE", size: size, onTap: _onButtonClick),
                            ButtonViewForNumber(
                                text: CalculatorDataProvider.SEVEN,
                                size: size,
                                onTap: _onButtonClick),
                            ButtonViewForNumber(
                                text: CalculatorDataProvider.FOUR,
                                size: size,
                                onTap: _onButtonClick),
                            ButtonViewForNumber(
                                text: CalculatorDataProvider.ONE,
                                size: size,
                                onTap: _onButtonClick),
                            ButtonView(
                                text: "+-", size: size, onTap: _onButtonClick),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            ButtonView(
                                text: CalculatorDataProvider.OPEN_BRACKET,
                                size: size,
                                onTap: _onButtonClick),
                            ButtonView(
                                text: CalculatorDataProvider.CLEAR,
                                size: size,
                                onTap: _onButtonClick),
                            ButtonViewForNumber(
                                text: CalculatorDataProvider.EIGHT,
                                size: size,
                                onTap: _onButtonClick),
                            ButtonViewForNumber(
                                text: CalculatorDataProvider.FIVE,
                                size: size,
                                onTap: _onButtonClick),
                            ButtonViewForNumber(
                                text: CalculatorDataProvider.TWO,
                                size: size,
                                onTap: _onButtonClick),
                            ButtonViewForNumber(
                                text: CalculatorDataProvider.ZERO,
                                size: size,
                                onTap: _onButtonClick),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            ButtonView(
                                text: CalculatorDataProvider.BACK,
                                size: size,
                                onTap: _onButtonClick),
                            ButtonViewForNumber(
                                text: CalculatorDataProvider.NINE,
                                size: size,
                                onTap: _onButtonClick),
                            ButtonViewForNumber(
                                text: CalculatorDataProvider.SIX,
                                size: size,
                                onTap: _onButtonClick),
                            ButtonViewForNumber(
                                text: CalculatorDataProvider.THREE,
                                size: size,
                                onTap: _onButtonClick),
                            ButtonView(
                                text: CalculatorDataProvider.PERIOD,
                                size: size,
                                onTap: _onButtonClick),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            ButtonView(
                                text: CalculatorDataProvider.DIVIDE,
                                size: size,
                                onTap: _onButtonClick),
                            ButtonView(
                                text: CalculatorDataProvider.MULTIPLY,
                                size: size,
                                onTap: _onButtonClick),
                            ButtonView(
                                text: CalculatorDataProvider.SUBTRACT,
                                size: size,
                                onTap: _onButtonClick),
                            ButtonView(
                                text: CalculatorDataProvider.ADD,
                                size: size,
                                onTap: _onButtonClick),
                            ButtonViewForPlus(
                                text: CalculatorDataProvider.EQUAL,
                                size: size,
                                onTap: _onButtonClick),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _onButtonClick({String buttonText}) {
    if (buttonText == CalculatorDataProvider.OPEN_BRACKET) {
      addParenthesis(buttonText: buttonText);
    } else if (Process.isDigit(exp.split('').last) ||
        exp.split('').last != buttonText) {
      if (buttonText != CalculatorDataProvider.BACK &&
          !Process.isDigit(exp.split('').last) &&
          !Process.isDigit(buttonText)) {
        exp = exp.replaceRange(exp.length - 1, exp.length, "");
      }
      if (buttonText == CalculatorDataProvider.CLEAR)
        clear();
      else if (buttonText == CalculatorDataProvider.BACK)
        back();
      else if (buttonText == CalculatorDataProvider.EQUAL) {
      } else
        changeExp(buttonText);
    }
  }

  addParenthesis({String buttonText}) {
    if (exp == "0") {
      changeExp("(");
    } else if (exp.split('').last == "(") {
      changeExp("(");
    } else if (!Process.isDigit(exp.split('').last)) {
      changeExp("(");
    } else if (Process.isDigit(exp.split('').last)) {
      changeExp(")");
    } else {}
  }
}

class ButtonViewForNumber extends StatelessWidget {
  final String text;
  final double size;
  final Key key;
  final CalculatorButtonTapCallback onTap;

  ButtonViewForNumber(
      {this.key,
      @required this.text,
      @required this.size,
      @required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(6),
      color: Color(0xffe8e9eb),
      elevation: 4,
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(6.0)),
      child: InkWell(
        onTap: () {
          onTap(buttonText: text);
        },
        child: Container(
          constraints:
              BoxConstraints.tightForFinite(width: size, height: size * .75),
          child: Center(child: Text(text, style: TextStyle(fontSize: 25))),
        ),
      ),
    );
  }
}

class ButtonViewForPlus extends StatelessWidget {
  final String text;
  final double size;
  final Key key;
  final CalculatorButtonTapCallback onTap;

  ButtonViewForPlus(
      {this.key,
      @required this.text,
      @required this.size,
      @required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(6),
      color: Color(0xffe8e9eb),
      elevation: 4,
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(6.0)),
      child: InkWell(
        onTap: () {
          onTap(buttonText: text);
        },
        child: Container(
          constraints: BoxConstraints.tightForFinite(
              width: size, height: (size * 1.5) + 12),
          child: Center(child: Text(text, style: TextStyle(fontSize: 25))),
        ),
      ),
    );
  }
}

class ButtonView extends StatelessWidget {
  final String text;
  final double size;
  final Key key;
  final CalculatorButtonTapCallback onTap;

  ButtonView(
      {this.key,
      @required this.text,
      @required this.size,
      @required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(6),
      color: Color(0xffe8e9eb),
      elevation: 4,
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(6.0)),
      child: InkWell(
        onTap: () {
          onTap(buttonText: text);
        },
        child: Container(
          constraints:
              BoxConstraints.tightForFinite(width: size, height: size * .75),
          child: Center(child: Text(text, style: TextStyle(fontSize: 25))),
        ),
      ),
    );
  }
}
