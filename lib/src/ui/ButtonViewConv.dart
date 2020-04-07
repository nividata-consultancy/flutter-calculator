import 'package:calculator/src/blocs/CalcBloc.dart';
import 'package:calculator/src/blocs/ConvBloc.dart';
import 'package:calculator/src/blocs/UiHandlerBloc.dart';
import 'package:calculator/src/models/Calculator.dart';
import 'package:calculator/src/resources/CalculatorDataProvider.dart';
import 'package:calculator/src/utility/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ButtonViewNew extends StatelessWidget {
  final String text;
  final Key key;
  final CalcBloc calcBloc;
  final ConvBloc convBloc;
  final UiHandlerBloc uiHandlerBloc;
  final bool isCalcSelected;

  ButtonViewNew(
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
              child: getContainerForConverter(calculator),
            ),
          ),
        );
        break;
      case ShapeType.DARK_ROUND:
        break;
      case ShapeType.NAN:
        return Expanded(
          flex: 1,
          child: Card(
            margin: EdgeInsets.all(4),
            elevation: 0,
            color: Theme.of(context).primaryColor,
            child: getContainerForConverter(calculator),
          ),
        );
        break;
    }
  }
}

// ignore: missing_return
Widget getContainerForConverter(Calculator calculator) {
  switch (calculator.key) {
    case CalculatorDataProvider.BACK_CONV:
      return Container(
        constraints: BoxConstraints.expand(),
        child: Icon(
          Icons.backspace,
          size: SizeConfig.pixelRatio * 10,
          color: Color(0xff009e8c),
        ),
      );
      break;
    case CalculatorDataProvider.CLEAR:
      return Container(
        child: Center(
            child: Text(calculator.text,
                style: TextStyle(
                    fontSize: SizeConfig.pixelRatio * 12, color: Colors.red))),
      );
      break;
    case CalculatorDataProvider.UP:
      return Container(
        constraints: BoxConstraints.expand(),
        child: Icon(
          Icons.arrow_upward,
          size: SizeConfig.pixelRatio * 15,
          color: Color(0xff009e8c),
        ),
      );
      break;
    case CalculatorDataProvider.DOWN:
      return Container(
        constraints: BoxConstraints.expand(),
        child: Icon(
          Icons.arrow_downward,
          size: SizeConfig.pixelRatio * 15,
          color: Color(0xff009e8c),
        ),
      );
      break;
    case CalculatorDataProvider.OPEN_BRACKET:
      return Container(
        padding: EdgeInsets.all(SizeConfig.pixelRatio * 8),
        child: SvgPicture.asset(
          calculator.text,
          color: Colors.grey[700],
        ),
      );
      break;
  }
}
