import 'package:calculator/src/blocs/CalcBloc.dart';
import 'package:calculator/src/blocs/ConvBloc.dart';
import 'package:calculator/src/blocs/UiHandlerBloc.dart';
import 'package:calculator/src/models/Calculator.dart';
import 'package:calculator/src/resources/CalculatorDataProvider.dart';
import 'package:calculator/src/utility/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ButtonViewCalc extends StatelessWidget {
  final String text;
  final Key key;
  final CalcBloc calcBloc;
  final ConvBloc convBloc;
  final UiHandlerBloc uiHandlerBloc;
  final bool isCalcSelected;

  ButtonViewCalc(
      {this.key,
      @required this.text,
      @required this.calcBloc,
      @required this.convBloc,
      @required this.uiHandlerBloc,
      @required this.isCalcSelected})
      : super(key: key);

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
                if (isCalcSelected)
                  calcBloc.buttonText.add(text);
                else
                  convBloc.setConvInput.add(text);
              },
              child: getContainerForCalc(calculator),
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
                if (isCalcSelected)
                  calcBloc.buttonText.add(text);
                else
                  convBloc.setConvInput.add(text);
              },
              child: getContainerForCalc(calculator),
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
                if (isCalcSelected)
                  calcBloc.buttonText.add(text);
                else
                  convBloc.setConvInput.add(text);
              },
              child: getContainerForCalc(calculator),
            ),
          ),
        );
        break;
    }
  }
}

// ignore: missing_return
Widget getContainerForCalc(Calculator calculator) {
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
