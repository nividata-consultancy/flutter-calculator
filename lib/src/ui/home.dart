import 'package:calculator/src/blocs/CalcBloc.dart';
import 'package:calculator/src/blocs/ConvBloc.dart';
import 'package:calculator/src/blocs/UiHandlerBloc.dart';
import 'package:calculator/src/resources/CalculatorDataProvider.dart';
import 'package:calculator/src/ui/ButtonViewCalc.dart';
import 'package:calculator/src/ui/ButtonViewConv.dart';
import 'package:calculator/src/ui/CalculatorUi.dart';
import 'package:calculator/src/ui/ConverterCalc.dart';
import 'package:calculator/src/utility/SizeConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Color(0xff273639),
          accentColor: Color(0xff009e8c),
          brightness: Brightness.dark,
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
  bool isSelectedCalc = true;
  bool isSelectedConv = false;
  UiHandlerBloc uiHandlerBloc;
  CalcBloc calcBloc;
  ConvBloc convBloc;

  @override
  void initState() {
    calcBloc = CalcBloc();
    convBloc = ConvBloc();
    uiHandlerBloc = UiHandlerBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                StreamBuilder<bool>(
                    initialData: true,
                    stream: uiHandlerBloc.chipChange,
                    builder: (context, snapshot) {
                      return ChoiceChip(
                        selected: snapshot.data,
                        pressElevation: 0,
                        elevation: 0,
                        selectedColor: Colors.white,
                        backgroundColor: Color(0xff273639),
                        onSelected: (isSelect) {
                          if (!snapshot.data)
                            uiHandlerBloc.calcChipSelect.add(true);
                        },
                        label: Text(
                          "Calculator",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: snapshot.data
                                  ? Color(0xff009e8c)
                                  : Colors.white54),
                        ),
                      );
                    }),
                SizedBox(
                  width: 10,
                ),
                StreamBuilder<bool>(
                    initialData: true,
                    stream: uiHandlerBloc.chipChange,
                    builder: (context, snapshot) {
                      return ChoiceChip(
                        selected: !snapshot.data,
                        selectedColor: Colors.white,
                        elevation: 0,
                        backgroundColor: Color(0xff273639),
                        pressElevation: 0,
                        onSelected: (isSelect) {
                          if (snapshot.data)
                            uiHandlerBloc.calcChipSelect.add(false);
                        },
                        label: Text(
                          "Converter",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: !snapshot.data
                                  ? Color(0xff009e8c)
                                  : Colors.white54),
                        ),
                      );
                    }),
              ],
            ),
          ),
        ),
        elevation: 0,
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        top: false,
        bottom: true,
        child: StreamBuilder<bool>(
            stream: uiHandlerBloc.chipChange,
            initialData: true,
            builder: (context, snapshot) {
              return Container(
                padding: EdgeInsets.all(5),
                child: Column(
                  children: <Widget>[
                    snapshot.data
                        ? CalculatorUi(calcBloc)
                        : ConverterCalc(convBloc),
                    Visibility(
                      visible: snapshot.data,
                      child: Expanded(
                        flex: (SizeConfig.heightWidthFactor * 12 * 10).toInt(),
                        child: Row(
                          children: <Widget>[
                            ButtonViewCalc(
                              text: CalculatorDataProvider.CLEAR_ALl,
                              calcBloc: calcBloc,
                              convBloc: convBloc,
                              uiHandlerBloc: uiHandlerBloc,
                              isCalcSelected: snapshot.data,
                            ),
                            ButtonViewCalc(
                              text: CalculatorDataProvider.BACK,
                              calcBloc: calcBloc,
                              convBloc: convBloc,
                              uiHandlerBloc: uiHandlerBloc,
                              isCalcSelected: snapshot.data,
                            ),
                            ButtonViewCalc(
                              text: CalculatorDataProvider.PERCENTAGE,
                              calcBloc: calcBloc,
                              convBloc: convBloc,
                              uiHandlerBloc: uiHandlerBloc,
                              isCalcSelected: snapshot.data,
                            ),
                            ButtonViewCalc(
                              text: CalculatorDataProvider.DIVIDE,
                              calcBloc: calcBloc,
                              convBloc: convBloc,
                              uiHandlerBloc: uiHandlerBloc,
                              isCalcSelected: snapshot.data,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: (SizeConfig.heightWidthFactor * 48 * 10).toInt(),
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Row(
                              children: <Widget>[
                                ButtonViewCalc(
                                  text: CalculatorDataProvider.SEVEN,
                                  calcBloc: calcBloc,
                                  convBloc: convBloc,
                                  uiHandlerBloc: uiHandlerBloc,
                                  isCalcSelected: snapshot.data,
                                ),
                                ButtonViewCalc(
                                  text: CalculatorDataProvider.EIGHT,
                                  calcBloc: calcBloc,
                                  convBloc: convBloc,
                                  uiHandlerBloc: uiHandlerBloc,
                                  isCalcSelected: snapshot.data,
                                ),
                                ButtonViewCalc(
                                  text: CalculatorDataProvider.NINE,
                                  calcBloc: calcBloc,
                                  convBloc: convBloc,
                                  uiHandlerBloc: uiHandlerBloc,
                                  isCalcSelected: snapshot.data,
                                ),
                                snapshot.data
                                    ? ButtonViewCalc(
                                        text: CalculatorDataProvider.MULTIPLY,
                                        calcBloc: calcBloc,
                                        convBloc: convBloc,
                                        uiHandlerBloc: uiHandlerBloc,
                                        isCalcSelected: snapshot.data,
                                      )
                                    : ButtonViewNew(
                                        text: CalculatorDataProvider.BACK_CONV,
                                        calcBloc: calcBloc,
                                        convBloc: convBloc,
                                        uiHandlerBloc: uiHandlerBloc,
                                        isCalcSelected: snapshot.data,
                                      ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              children: <Widget>[
                                ButtonViewCalc(
                                  text: CalculatorDataProvider.FOUR,
                                  calcBloc: calcBloc,
                                  convBloc: convBloc,
                                  uiHandlerBloc: uiHandlerBloc,
                                  isCalcSelected: snapshot.data,
                                ),
                                ButtonViewCalc(
                                  text: CalculatorDataProvider.FIVE,
                                  calcBloc: calcBloc,
                                  convBloc: convBloc,
                                  uiHandlerBloc: uiHandlerBloc,
                                  isCalcSelected: snapshot.data,
                                ),
                                ButtonViewCalc(
                                  text: CalculatorDataProvider.SIX,
                                  calcBloc: calcBloc,
                                  convBloc: convBloc,
                                  uiHandlerBloc: uiHandlerBloc,
                                  isCalcSelected: snapshot.data,
                                ),
                                snapshot.data
                                    ? ButtonViewCalc(
                                        text: CalculatorDataProvider.SUBTRACT,
                                        calcBloc: calcBloc,
                                        convBloc: convBloc,
                                        uiHandlerBloc: uiHandlerBloc,
                                        isCalcSelected: snapshot.data,
                                      )
                                    : ButtonViewNew(
                                        text: CalculatorDataProvider.CLEAR,
                                        calcBloc: calcBloc,
                                        convBloc: convBloc,
                                        uiHandlerBloc: uiHandlerBloc,
                                        isCalcSelected: snapshot.data,
                                      ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              children: <Widget>[
                                ButtonViewCalc(
                                  text: CalculatorDataProvider.ONE,
                                  calcBloc: calcBloc,
                                  convBloc: convBloc,
                                  uiHandlerBloc: uiHandlerBloc,
                                  isCalcSelected: snapshot.data,
                                ),
                                ButtonViewCalc(
                                  text: CalculatorDataProvider.TWO,
                                  calcBloc: calcBloc,
                                  convBloc: convBloc,
                                  uiHandlerBloc: uiHandlerBloc,
                                  isCalcSelected: snapshot.data,
                                ),
                                ButtonViewCalc(
                                  text: CalculatorDataProvider.THREE,
                                  calcBloc: calcBloc,
                                  convBloc: convBloc,
                                  uiHandlerBloc: uiHandlerBloc,
                                  isCalcSelected: snapshot.data,
                                ),
                                snapshot.data
                                    ? ButtonViewCalc(
                                        text: CalculatorDataProvider.ADD,
                                        calcBloc: calcBloc,
                                        convBloc: convBloc,
                                        uiHandlerBloc: uiHandlerBloc,
                                        isCalcSelected: snapshot.data,
                                      )
                                    : ButtonViewNew(
                                        text: CalculatorDataProvider.UP,
                                        calcBloc: calcBloc,
                                        convBloc: convBloc,
                                        uiHandlerBloc: uiHandlerBloc,
                                        isCalcSelected: snapshot.data,
                                      ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              children: <Widget>[
                                snapshot.data
                                    ? ButtonViewCalc(
                                        text:
                                            CalculatorDataProvider.OPEN_BRACKET,
                                        calcBloc: calcBloc,
                                        convBloc: convBloc,
                                        uiHandlerBloc: uiHandlerBloc,
                                        isCalcSelected: snapshot.data,
                                      )
                                    : ButtonViewNew(
                                        text:
                                            CalculatorDataProvider.OPEN_BRACKET,
                                        calcBloc: calcBloc,
                                        convBloc: convBloc,
                                        uiHandlerBloc: uiHandlerBloc,
                                        isCalcSelected: snapshot.data,
                                      ),
                                ButtonViewCalc(
                                  text: CalculatorDataProvider.ZERO,
                                  calcBloc: calcBloc,
                                  convBloc: convBloc,
                                  uiHandlerBloc: uiHandlerBloc,
                                  isCalcSelected: snapshot.data,
                                ),
                                ButtonViewCalc(
                                  text: CalculatorDataProvider.PERIOD,
                                  calcBloc: calcBloc,
                                  convBloc: convBloc,
                                  uiHandlerBloc: uiHandlerBloc,
                                  isCalcSelected: snapshot.data,
                                ),
                                snapshot.data
                                    ? ButtonViewCalc(
                                        text: CalculatorDataProvider.EQUAL,
                                        calcBloc: calcBloc,
                                        convBloc: convBloc,
                                        uiHandlerBloc: uiHandlerBloc,
                                        isCalcSelected: snapshot.data,
                                      )
                                    : ButtonViewNew(
                                        text: CalculatorDataProvider.DOWN,
                                        calcBloc: calcBloc,
                                        convBloc: convBloc,
                                        uiHandlerBloc: uiHandlerBloc,
                                        isCalcSelected: snapshot.data,
                                      ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }

  @override
  void dispose() {
    uiHandlerBloc.dispose();
    calcBloc.dispose();
    convBloc.dispose();
    super.dispose();
  }
}
