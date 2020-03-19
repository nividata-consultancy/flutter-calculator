import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';

class ResultValue extends StatelessWidget {
  final String result;
  final double size;
  final Key key;

  ResultValue({this.key, @required this.result, @required this.size})
      : super(key: key);

  ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Container(
        padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
        child: Align(
          alignment: Alignment.centerRight,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              result,
              style: TextStyle(fontSize: 42, fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }
}
