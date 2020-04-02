import 'package:calculator/src/blocs/CalcBloc.dart';
import 'package:calculator/src/models/Calculator.dart';
import 'package:calculator/src/resources/CalculatorDataProvider.dart';
import 'package:calculator/src/ui/resultValue.dart';
import 'package:calculator/src/utility/SizeConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'displayExp.dart';

class CalculatorUi extends StatefulWidget {
  @override
  _CalculatorUiState createState() => _CalculatorUiState();
}

class _CalculatorUiState extends State<CalculatorUi> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          flex: (SizeConfig.heightWidthFactor * 2).toInt(),
          child: Container(
            padding: EdgeInsets.all(5),
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
                        ButtonView(text: CalculatorDataProvider.OPEN_BRACKET),
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
                        ButtonView(text: CalculatorDataProvider.PERCENTAGE),
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
    );
  }
}

class ButtonView extends StatelessWidget {
  final String text;
  final Key key;

  ButtonView({this.key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Calculator calculator = CalculatorDataProvider.getButtonData(text);
    switch (calculator.shapeType) {
      case ShapeType.ROUND:
        return Expanded(
          flex: 1,
          child: Card(
            margin: EdgeInsets.all(5),
            color: Color(0xffe8e9eb),
            elevation: 2,
            shape: CircleBorder(),
            child: InkWell(
              splashColor: Theme.of(context).primaryColor,
              customBorder: CircleBorder(),
              onTap: () {
                bloc.buttonText.add(text);
              },
              child: getContainer(calculator),
            ),
          ),
        );
        break;
      case ShapeType.DARK_ROUND:
        return Expanded(
          flex: 1,
          child: Card(
            margin: EdgeInsets.all(5),
            color: Color(0xff6a837f),
            elevation: 2,
            shape: CircleBorder(),
            child: InkWell(
              splashColor: Theme.of(context).primaryColor,
              customBorder: CircleBorder(),
              onTap: () {
                bloc.buttonText.add(text);
              },
              child: getContainer(calculator),
            ),
          ),
        );
        break;
      case ShapeType.NAN:
        return Expanded(
          flex: 1,
          child: Card(
            margin: EdgeInsets.all(4),
            elevation: 0,
            color: Theme.of(context).primaryColor,
            child: InkWell(
              customBorder: CircleBorder(),
              onTap: () {
                bloc.buttonText.add(text);
              },
              child: getContainer(calculator),
            ),
          ),
        );
        break;
    }
  }
}

Widget getContainer(Calculator calculator) {
  switch (calculator.resourceType) {
    case ResourceType.TEXT:
      return Container(
        child: Center(
            child: Text(calculator.text,
                style: TextStyle(
                    fontSize: SizeConfig.pixelRatio * 12,
                    color: Colors.white))),
      );
      break;
    case ResourceType.IMAGE_SVG:
      return Container(
        padding: EdgeInsets.all(SizeConfig.pixelRatio * 10),
        child: SvgPicture.asset(calculator.text),
      );
      break;
    case ResourceType.MULTIPLY:
      return Container(
        padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
        child: Center(
            child: Text(calculator.text,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: SizeConfig.pixelRatio * 20,
                    color: Color(0xff009e8c)))),
      );
      break;
    case ResourceType.BACK_SPACE:
      return Container(
        constraints: BoxConstraints.expand(),
        child: Icon(
          Icons.backspace,
          size: SizeConfig.pixelRatio * 10,
          color: Colors.white,
        ),
      );
      break;
  }
}
