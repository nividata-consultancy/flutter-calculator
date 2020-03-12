import 'package:flutter/cupertino.dart';

class ResultValue extends StatelessWidget {
  final String result;
  final Key key;

  ResultValue({this.key, @required this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(
            result,
            style: TextStyle(fontSize: 34, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
