import 'dart:async';

import 'package:calculator/src/blocs/CalcBloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class DisplayExp extends StatefulWidget {
  final String exp;
  final double size;
  final Key key;

  DisplayExp({this.key, @required this.exp, @required this.size})
      : super(key: key);

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
      flex: 2,
      child: Container(
        padding: EdgeInsets.fromLTRB(0, 5, 5, 5),
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFEFEFEF), Color(0xfff1f1f1)]),
            shape: BoxShape.rectangle,
            border: Border(
              left: BorderSide(
                color: Color(0xFFb6b6b8),
                width: 4.0,
              ),
              top: BorderSide(
                color: Color(0xFFb6b6b8),
                width: 3.0,
              ),
              bottom: BorderSide(
                color: Color(0xfffafafa),
                width: 2.0,
              ),
              right: BorderSide(
                color: Color(0xfffafafa),
                width: 1.0,
              ),
            )),
        child: Align(
          alignment: Alignment.centerRight,
          child: SingleChildScrollView(
            controller: _controller,
            scrollDirection: Axis.horizontal,
            child: Text(
              widget.exp,
              textAlign: TextAlign.end,
              style: TextStyle(fontSize: 36),
            ),
          ),
        ),
      ),
    );
  }
}
