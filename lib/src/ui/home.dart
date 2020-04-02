import 'package:calculator/src/blocs/CalcBloc.dart';
import 'package:calculator/src/blocs/UiHandlerBloc.dart';
import 'package:calculator/src/resources/CalculatorDataProvider.dart';
import 'package:calculator/src/ui/CalculatorUi.dart';
import 'package:calculator/src/ui/Converter.dart';
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

  @override
  void initState() {
    bloc.clear.add(CalculatorDataProvider.CLEAR);
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
                              fontSize: 18,
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
                          "Conventer",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
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
      backgroundColor: Color(0xff273639),
      body: SafeArea(
        top: false,
        bottom: true,
        child: StreamBuilder<bool>(
            stream: uiHandlerBloc.chipChange,
            initialData: true,
            builder: (context, snapshot) {
              return Container(
                padding: EdgeInsets.all(5),
                child: snapshot.data ? CalculatorUi() : Converter(),
              );
            }),
      ),
    );
  }

  @override
  void dispose() {
    bloc.dispose();
    uiHandlerBloc.dispose();
    super.dispose();
  }
}
