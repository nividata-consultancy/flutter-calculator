import 'package:calculator/src/blocs/CalcBloc.dart';
import 'package:calculator/src/resources/CalculatorDataProvider.dart';
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
                  StreamBuilder<String>(
                      stream: bloc.exp,
                      initialData: "0",
                      builder: (context, snapshot) {
                        return DisplayExp(exp: snapshot.data, size: size);
                      }),
                  StreamBuilder<String>(
                      stream: bloc.total,
                      initialData: "0",
                      builder: (context, snapshot) {
                        return ResultValue(result: snapshot.data);
                      }),
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
                            ButtonView(text: "%", size: size),
                            ButtonView(text: "CE", size: size),
                            ButtonViewForNumber(
                                text: CalculatorDataProvider.SEVEN, size: size),
                            ButtonViewForNumber(
                                text: CalculatorDataProvider.FOUR, size: size),
                            ButtonViewForNumber(
                                text: CalculatorDataProvider.ONE, size: size),
                            ButtonView(text: "+-", size: size),
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
                                size: size),
                            ButtonView(
                                text: CalculatorDataProvider.CLEAR, size: size),
                            ButtonViewForNumber(
                                text: CalculatorDataProvider.EIGHT, size: size),
                            ButtonViewForNumber(
                                text: CalculatorDataProvider.FIVE, size: size),
                            ButtonViewForNumber(
                                text: CalculatorDataProvider.TWO, size: size),
                            ButtonViewForNumber(
                                text: CalculatorDataProvider.ZERO, size: size),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            ButtonView(
                                text: CalculatorDataProvider.CLOSE_BRACKET,
                                size: size),
                            ButtonView(
                                text: CalculatorDataProvider.BACK, size: size),
                            ButtonViewForNumber(
                                text: CalculatorDataProvider.NINE, size: size),
                            ButtonViewForNumber(
                                text: CalculatorDataProvider.SIX, size: size),
                            ButtonViewForNumber(
                                text: CalculatorDataProvider.THREE, size: size),
                            ButtonView(
                                text: CalculatorDataProvider.PERIOD,
                                size: size),
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
                                size: size),
                            ButtonView(
                                text: CalculatorDataProvider.MULTIPLY,
                                size: size),
                            ButtonView(
                                text: CalculatorDataProvider.SUBTRACT,
                                size: size),
                            ButtonView(
                                text: CalculatorDataProvider.ADD, size: size),
                            ButtonViewForPlus(
                                text: CalculatorDataProvider.EQUAL, size: size),
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
}

class ButtonViewForNumber extends StatelessWidget {
  final String text;
  final double size;
  final Key key;

  ButtonViewForNumber({this.key, @required this.text, @required this.size})
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
          bloc.buttonText.add(text);
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

  ButtonViewForPlus({this.key, @required this.text, @required this.size})
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
          bloc.buttonText.add(text);
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

  ButtonView({this.key, @required this.text, @required this.size})
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
          bloc.buttonText.add(text);
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
