import 'dart:async';

import 'package:calculator/src/utility/SizeConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResultValue extends StatefulWidget {
  final String result;
  final Key key;

  ResultValue({this.key, @required this.result}) : super(key: key);

  @override
  _ResultValueState createState() => _ResultValueState();
}

class _ResultValueState extends State<ResultValue> {
  ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    Timer(Duration(milliseconds: 200),
        () => _controller.jumpTo(_controller.position.maxScrollExtent));
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
              widget.result,
              style: TextStyle(
                  fontSize: SizeConfig.pixelRatio * 22,
                  color: Colors.white,
                  fontWeight: FontWeight.w700),
              toolbarOptions: ToolbarOptions(selectAll: true, copy: true),
              showCursor: false,
            ),
          ),
        ),
      ),
    );
  }
}
