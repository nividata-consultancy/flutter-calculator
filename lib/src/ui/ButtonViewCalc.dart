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
    SizeConfig().init(context);
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
              child: getContainerForCalc(calculator, context),
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
              child: getContainerForCalc(calculator, context),
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
              child: getContainerForCalc(calculator, context),
            ),
          ),
        );
        break;
    }
  }
}

// ignore: missing_return
Widget getContainerForCalc(Calculator calculator, BuildContext context) {
  switch (calculator.resourceType) {
    case ResourceType.TEXT:
      return Container(
        child: Center(
            child: Text(calculator.text,
                style: Theme.of(context).textTheme.display1)),
      );
      break;
    case ResourceType.IMAGE_SVG:
      print("horizontal block ${SizeConfig.blockSizeVertical}");
      return Padding(
        padding: EdgeInsets.all(SizeConfig.blockSizeVertical * 3),
          child: SvgPicture.asset(
        calculator.text,
      ));
      break;
    case ResourceType.BACK_SPACE:
      return Container(
        constraints: BoxConstraints.expand(),
        child: Icon(
          Icons.backspace,
          size: SizeConfig.blockSizeVertical * 3,
          color: Colors.white,
        ),
      );
      break;
  }
}
