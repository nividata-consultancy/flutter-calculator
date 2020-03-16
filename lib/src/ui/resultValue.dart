import 'package:flutter/cupertino.dart';

class ResultValue extends StatelessWidget {
  final String result;
  final double size;
  final Key key;

  ResultValue({this.key, @required this.result, @required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Container(
        padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
        child: Align(
          alignment: Alignment.bottomRight,
          child: Text(
            result,
            maxLines: 1,
            style: TextStyle(fontSize: 34, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
