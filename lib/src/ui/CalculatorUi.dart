import 'dart:async';

import 'package:calculator/src/blocs/CalcBloc.dart';
import 'package:calculator/src/models/Calculator.dart';
import 'package:calculator/src/resources/CalculatorDataProvider.dart';
import 'package:calculator/src/utility/SizeConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CalculatorUi extends StatefulWidget {
  @override
  _CalculatorUiState createState() => _CalculatorUiState();
}

class _CalculatorUiState extends State<CalculatorUi> {
  ScrollController _controller = ScrollController();
  CalcBloc calcBloc;

  @override
  void initState() {
    calcBloc = CalcBloc();
    calcBloc.clear.add(CalculatorDataProvider.CLEAR);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Timer(Duration(milliseconds: 200),
        () => _controller.jumpTo(_controller.position.maxScrollExtent));
    return Column(
      children: <Widget>[
        Expanded(
          flex: (SizeConfig.heightWidthFactor * 2).toInt(),
          child: Container(
            padding: EdgeInsets.all(5),
            child: Column(
              children: <Widget>[
                StreamBuilder<String>(
                    stream: calcBloc.exp,
                    initialData: "0",
                    builder: (context, snapshot) {
                      return Flexible(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(0, 5, 5, 5),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: SingleChildScrollView(
                              controller: _controller,
                              scrollDirection: Axis.horizontal,
                              child: Text(
                                snapshot.data,
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    fontSize: SizeConfig.pixelRatio * 22,
                                    color: Colors.white54),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                StreamBuilder<String>(
                    stream: calcBloc.total,
                    initialData: "0",
                    builder: (context, snapshot) {
                      return Flexible(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: SingleChildScrollView(
                              controller: _controller,
                              scrollDirection: Axis.horizontal,
                              child: SelectableText(
                                snapshot.data,
                                style: TextStyle(
                                    fontSize: SizeConfig.pixelRatio * 22,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                                toolbarOptions:
                                    ToolbarOptions(selectAll: true, copy: true),
                                showCursor: false,
                              ),
                            ),
                          ),
                        ),
                      );
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
                        ButtonView(
                            text: CalculatorDataProvider.CLEAR,
                            calcBloc: calcBloc),
                        ButtonView(
                            text: CalculatorDataProvider.SEVEN,
                            calcBloc: calcBloc),
                        ButtonView(
                            text: CalculatorDataProvider.FOUR,
                            calcBloc: calcBloc),
                        ButtonView(
                            text: CalculatorDataProvider.ONE,
                            calcBloc: calcBloc),
                        ButtonView(
                            text: CalculatorDataProvider.OPEN_BRACKET,
                            calcBloc: calcBloc),
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
                            calcBloc: calcBloc),
                        ButtonView(
                            text: CalculatorDataProvider.EIGHT,
                            calcBloc: calcBloc),
                        ButtonView(
                            text: CalculatorDataProvider.FIVE,
                            calcBloc: calcBloc),
                        ButtonView(
                            text: CalculatorDataProvider.TWO,
                            calcBloc: calcBloc),
                        ButtonView(
                            text: CalculatorDataProvider.ZERO,
                            calcBloc: calcBloc),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        ButtonView(
                            text: CalculatorDataProvider.PERCENTAGE,
                            calcBloc: calcBloc),
                        ButtonView(
                            text: CalculatorDataProvider.NINE,
                            calcBloc: calcBloc),
                        ButtonView(
                            text: CalculatorDataProvider.SIX,
                            calcBloc: calcBloc),
                        ButtonView(
                            text: CalculatorDataProvider.THREE,
                            calcBloc: calcBloc),
                        ButtonView(
                            text: CalculatorDataProvider.PERIOD,
                            calcBloc: calcBloc),
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
                            calcBloc: calcBloc),
                        ButtonView(
                            text: CalculatorDataProvider.MULTIPLY,
                            calcBloc: calcBloc),
                        ButtonView(
                            text: CalculatorDataProvider.SUBTRACT,
                            calcBloc: calcBloc),
                        ButtonView(
                            text: CalculatorDataProvider.ADD,
                            calcBloc: calcBloc),
                        ButtonView(
                            text: CalculatorDataProvider.EQUAL,
                            calcBloc: calcBloc),
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

  @override
  void dispose() {
    calcBloc.dispose();
    super.dispose();
  }
}

class ButtonView extends StatelessWidget {
  final String text;
  final Key key;
  final CalcBloc calcBloc;

  ButtonView({this.key, @required this.text, @required this.calcBloc})
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
                calcBloc.buttonText.add(text);
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
                calcBloc.buttonText.add(text);
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
