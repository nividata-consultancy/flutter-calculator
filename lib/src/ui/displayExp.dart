import 'package:flutter/cupertino.dart';

class DisplayExp extends StatelessWidget {
  final String exp;
  final double size;
  final Key key;

  DisplayExp({this.key, @required this.exp, @required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 2,
      child: Container(
        padding: EdgeInsets.all(5),
        constraints: BoxConstraints.expand(),
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
        child: Align(
          alignment: Alignment.bottomRight,
          child: Text(
            exp,
            maxLines: 3,
            textAlign: TextAlign.end,
            style: TextStyle(fontSize: 28),
          ),
        ),
      ),
    );
  }
}
