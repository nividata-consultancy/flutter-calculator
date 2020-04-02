import 'dart:async';

import 'package:calculator/src/blocs/CalcBloc.dart';
import 'package:calculator/src/resources/CalculatorDataProvider.dart';
import 'package:calculator/src/utility/SizeConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CalculatorUi extends StatefulWidget {
  final CalcBloc calcBloc;

  CalculatorUi(this.calcBloc);

  @override
  _CalculatorUiState createState() => _CalculatorUiState();
}

class _CalculatorUiState extends State<CalculatorUi> {
  ScrollController _controller = ScrollController();

  @override
  void initState() {
    widget.calcBloc.clear.add(CalculatorDataProvider.CLEAR_ALl);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Timer(Duration(milliseconds: 200),
        () => _controller.jumpTo(_controller.position.maxScrollExtent));
    return Expanded(
      flex: 30,
      child: Column(
        children: <Widget>[
          Expanded(
            flex: (SizeConfig.heightWidthFactor * 2).toInt(),
            child: Container(
              padding: EdgeInsets.all(5),
              child: Column(
                children: <Widget>[
                  StreamBuilder<String>(
                      stream: widget.calcBloc.exp,
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
                      stream: widget.calcBloc.total,
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
                                  toolbarOptions: ToolbarOptions(
                                      selectAll: true, copy: true),
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
          )
        ],
      ),
    );
  }
}
