import 'package:calculator/src/blocs/CalcBloc.dart';
import 'package:calculator/src/resources/CalculatorDataProvider.dart';
import 'package:calculator/src/ui/displayExp.dart';
import 'package:calculator/src/ui/resultValue.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
          primaryColor: Color(0xffebebee),
          brightness: Brightness.light,
          fontFamily: 'Montserrat'),
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
  void initState() {
    bloc.clear.add(CalculatorDataProvider.CLEAR);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    final double buttonSize = (screen.width / 4) - 12;
    final double displayHeight =
        screen.height - (buttonSize * 5) - (buttonSize);
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculator"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFEFEFEF), Colors.white])),
        padding: EdgeInsets.all(5),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(5),
              constraints: BoxConstraints.expand(height: displayHeight),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFFEFEFEF), Color(0xfff4f4f4)]),
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
                      color: Color(0xfffafafa),
                      width: 2.0,
                    ),
                    right: BorderSide(
                      color: Color(0xfffafafa),
                      width: 1.0,
                    ),
                  )),
              child: Column(
                children: <Widget>[
                  StreamBuilder<String>(
                      stream: bloc.exp,
                      initialData: "0",
                      builder: (context, snapshot) {
                        return DisplayExp(exp: snapshot.data, size: buttonSize);
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
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            ButtonViewForClear(
                                text: CalculatorDataProvider.CLEAR,
                                size: buttonSize),
                            ButtonViewForNumber(
                                text: CalculatorDataProvider.SEVEN,
                                size: buttonSize),
                            ButtonViewForNumber(
                                text: CalculatorDataProvider.FOUR,
                                size: buttonSize),
                            ButtonViewForNumber(
                                text: CalculatorDataProvider.ONE,
                                size: buttonSize),
                            ButtonBackView(
                                text: CalculatorDataProvider.OPEN_BRACKET,
                                size: buttonSize),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            ButtonBackView(
                                text: CalculatorDataProvider.BACK,
                                size: buttonSize),
                            ButtonViewForNumber(
                                text: CalculatorDataProvider.EIGHT,
                                size: buttonSize),
                            ButtonViewForNumber(
                                text: CalculatorDataProvider.FIVE,
                                size: buttonSize),
                            ButtonViewForNumber(
                                text: CalculatorDataProvider.TWO,
                                size: buttonSize),
                            ButtonViewForNumber(
                                text: CalculatorDataProvider.ZERO,
                                size: buttonSize),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            ButtonBackView(
                                text: CalculatorDataProvider.PERCENTAGE,
                                size: buttonSize),
                            ButtonViewForNumber(
                                text: CalculatorDataProvider.NINE,
                                size: buttonSize),
                            ButtonViewForNumber(
                                text: CalculatorDataProvider.SIX,
                                size: buttonSize),
                            ButtonViewForNumber(
                                text: CalculatorDataProvider.THREE,
                                size: buttonSize),
                            ButtonView(
                                text: CalculatorDataProvider.PERIOD,
                                size: buttonSize),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            ButtonBackView(
                                text: CalculatorDataProvider.DIVIDE,
                                size: buttonSize),
                            ButtonViewMultiply(
                                text: CalculatorDataProvider.MULTIPLY,
                                size: buttonSize),
                            ButtonBackView(
                                text: CalculatorDataProvider.SUBTRACT,
                                size: buttonSize),
                            ButtonBackView(
                                text: CalculatorDataProvider.ADD,
                                size: buttonSize),
                            ButtonBackView(
                                text: CalculatorDataProvider.EQUAL,
                                size: buttonSize),
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

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
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
          child: Center(
              child: Text(CalculatorDataProvider.getButtonData(text).text,
                  style: TextStyle(fontSize: 25))),
        ),
      ),
    );
  }
}

class ButtonViewForClear extends StatelessWidget {
  final String text;
  final double size;
  final Key key;

  ButtonViewForClear({this.key, @required this.text, @required this.size})
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
          child: Center(
              child: Text(CalculatorDataProvider.getButtonData(text).text,
                  style: TextStyle(fontSize: 23))),
        ),
      ),
    );
  }
}

class ButtonViewMultiply extends StatelessWidget {
  final String text;
  final double size;
  final Key key;

  ButtonViewMultiply({this.key, @required this.text, @required this.size})
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
          padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
          child: Center(
              child: Text(CalculatorDataProvider.getButtonData(text).text,
                  textAlign: TextAlign.center, style: TextStyle(fontSize: 36))),
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
        highlightColor: Colors.black54,
        child: Container(
          constraints:
              BoxConstraints.tightForFinite(width: size, height: size * .75),
          child: Center(
              child: Text(CalculatorDataProvider.getButtonData(text).text,
                  style: TextStyle(fontSize: 25))),
        ),
      ),
    );
  }
}

class ButtonBackView extends StatelessWidget {
  final String text;
  final double size;
  final Key key;

  ButtonBackView({this.key, @required this.text, @required this.size})
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
          padding: EdgeInsets.all(19),
          constraints:
              BoxConstraints.tightForFinite(width: size, height: size * .75),
          child:
              SvgPicture.asset(CalculatorDataProvider.getButtonData(text).text),
        ),
      ),
    );
  }
}
