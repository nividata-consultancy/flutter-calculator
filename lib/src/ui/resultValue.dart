import 'dart:async';

import 'package:flutter/cupertino.dart';

class ResultValue extends StatefulWidget {
  final String result;
  final double size;
  final Key key;

  ResultValue({this.key, @required this.result, @required this.size})
      : super(key: key);

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
            child: Text(
              widget.result,
              style: TextStyle(fontSize: 42, fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }
}
