import 'package:calculator/src/blocs/CalcBloc.dart';
import 'package:calculator/src/blocs/UiHandlerBloc.dart';
import 'package:calculator/src/models/Calculator.dart';
import 'package:calculator/src/resources/CalculatorDataProvider.dart';
import 'package:calculator/src/utility/SizeConfig.dart';
import 'package:flutter/material.dart';

class ButtonViewNew extends StatelessWidget {
  final String text;
  final Key key;
  final CalcBloc calcBloc;
  final UiHandlerBloc uiHandlerBloc;

  ButtonViewNew(
      {this.key,
      @required this.text,
      @required this.calcBloc,
      @required this.uiHandlerBloc})
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
                calcBloc.buttonText.add(text);
              },
              child: getContainerForConverter(calculator),
            ),
          ),
        );
        break;
      case ShapeType.DARK_ROUND:
        break;
      case ShapeType.NAN:
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
  }
}
