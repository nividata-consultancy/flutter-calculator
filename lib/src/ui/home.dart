import 'package:calculator/src/blocs/CalcBloc.dart';
import 'package:calculator/src/models/Calculator.dart';
import 'package:calculator/src/resources/CalculatorDataProvider.dart';
import 'package:calculator/src/ui/displayExp.dart';
import 'package:calculator/src/ui/resultValue.dart';
import 'package:calculator/src/utility/SizeConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

import '../models/Calculator.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Home();
  }
}

class _Home extends State<Home> {
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
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculator", style: TextStyle(fontSize: 26)),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        top: false,
        bottom: true,
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.white, Colors.grey[100]])),
          padding: EdgeInsets.all(5),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: (SizeConfig.heightWidthFactor * 2).toInt() + 1,
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xFFEFEFEF), Color(0xfff4f4f4)]),
                      border: Border(
                        left: BorderSide(
                          color: Color(0xFFb6b6b8),
                          width: 5.0,
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
                            return DisplayExp(exp: snapshot.data);
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
              ),
              Expanded(
                flex: 7,
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
                              ButtonView(text: CalculatorDataProvider.CLEAR),
                              ButtonView(text: CalculatorDataProvider.SEVEN),
                              ButtonView(text: CalculatorDataProvider.FOUR),
                              ButtonView(text: CalculatorDataProvider.ONE),
                              ButtonView(
                                  text: CalculatorDataProvider.OPEN_BRACKET),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              ButtonView(text: CalculatorDataProvider.BACK),
                              ButtonView(text: CalculatorDataProvider.EIGHT),
                              ButtonView(text: CalculatorDataProvider.FIVE),
                              ButtonView(text: CalculatorDataProvider.TWO),
                              ButtonView(text: CalculatorDataProvider.ZERO),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              ButtonView(
                                  text: CalculatorDataProvider.PERCENTAGE),
                              ButtonView(text: CalculatorDataProvider.NINE),
                              ButtonView(text: CalculatorDataProvider.SIX),
                              ButtonView(text: CalculatorDataProvider.THREE),
                              ButtonView(text: CalculatorDataProvider.PERIOD),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              ButtonView(text: CalculatorDataProvider.DIVIDE),
                              ButtonView(text: CalculatorDataProvider.MULTIPLY),
                              ButtonView(text: CalculatorDataProvider.SUBTRACT),
                              ButtonView(text: CalculatorDataProvider.ADD),
                              ButtonView(text: CalculatorDataProvider.EQUAL),
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
      ),
    );
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }
}

class ButtonView extends StatelessWidget {
  final String text;
  final Key key;

  ButtonView({this.key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Card(
        margin: EdgeInsets.all(6),
        color: Color(0xffe8e9eb),
        elevation: 4,
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(6.0)),
        child: InkWell(
          onTap: () {
            bloc.buttonText.add(text);
          },
          child: getContainer(text),
        ),
      ),
    );
  }
}

Widget getContainer(String text) {
  Calculator calculator = CalculatorDataProvider.getButtonData(text);
  switch (calculator.resourceType) {
    case ResourceType.TEXT:
      return Container(
        child: Center(
            child: Text(calculator.text,
                style: TextStyle(fontSize: SizeConfig.pixelRatio * 12))),
      );
      break;
    case ResourceType.IMAGE_SVG:
      return Container(
        padding: EdgeInsets.all(SizeConfig.pixelRatio * 9),
        child: SvgPicture.asset(calculator.text),
      );
      break;
    case ResourceType.MULTIPLY:
      return Container(
        padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
        child: Center(
            child: Text(calculator.text,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: SizeConfig.pixelRatio * 12))),
      );
      break;
    case ResourceType.BACK_SPACE:
      return Container(
        constraints: BoxConstraints.expand(),
        child: Icon(
          Icons.backspace,
          size: SizeConfig.pixelRatio * 10,
          color: Colors.grey[900],
        ),
      );
      break;
  }
}
