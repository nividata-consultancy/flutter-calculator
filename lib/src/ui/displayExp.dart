import 'dart:async';

import 'package:calculator/src/utility/SizeConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DisplayExp extends StatefulWidget {
  final String exp;
  final Key key;

  DisplayExp({this.key, @required this.exp}) : super(key: key);

  @override
  _DisplayExpState createState() => _DisplayExpState();
}

class _DisplayExpState extends State<DisplayExp> {
  ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    Timer(Duration(milliseconds: 200),
        () => _controller.jumpTo(_controller.position.maxScrollExtent));

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
              widget.exp,
              textAlign: TextAlign.end,
              style: TextStyle(fontSize: SizeConfig.pixelRatio * 22),
            ),
          ),
        ),
      ),
    );
  }
}
