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
  ScrollController _controller1;
  ScrollController _controller2;

  @override
  void initState() {
    _controller1 = ScrollController();
    _controller2 = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback(scroll);
    widget.calcBloc.clear.add(CalculatorDataProvider.CLEAR_ALl);
    super.initState();
  }

  void scroll(_) async {
    while (_controller1.hasClients) {
      await Future.delayed(Duration(milliseconds: 200));
      if (_controller1.hasClients)
        await _controller1.animateTo(_controller1.position.maxScrollExtent,
            duration: Duration(milliseconds: 10), curve: Curves.ease);
      if (_controller2.hasClients)
        await _controller2.animateTo(_controller2.position.maxScrollExtent,
            duration: Duration(milliseconds: 10), curve: Curves.ease);
    }
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: (SizeConfig.heightWidthFactor * 38 * 10).toInt(),
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
                                controller: _controller1,
                                scrollDirection: Axis.horizontal,
                                child: Text(
                                  snapshot.data,
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      fontSize: SizeConfig.heightWidthFactor * 22,
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
                                controller: _controller2,
                                scrollDirection: Axis.horizontal,
                                child: SelectableText(
                                  snapshot.data,
                                  style: TextStyle(
                                      fontSize: SizeConfig.heightWidthFactor * 30,
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
