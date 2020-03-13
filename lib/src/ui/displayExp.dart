import 'package:flutter/cupertino.dart';

class DisplayExp extends StatelessWidget {
  final String exp;
  final double size;
  final Key key;

  DisplayExp({this.key, @required this.exp, @required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      constraints: BoxConstraints.tightForFinite(
          height: 0.6 * size, width: double.maxFinite),
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Color(0xFFEFEFEF),
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
              color: Color(0xfffefefe),
              width: 2.0,
            ),
            right: BorderSide(
              color: Color(0xfffefefe),
              width: 1.0,
            ),
          )),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(
            exp,
            textAlign: TextAlign.end,
            style: TextStyle(fontSize: 28),
          )
        ],
      ),
    );
  }
}
