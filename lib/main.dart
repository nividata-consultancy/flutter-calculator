import 'package:calculator/src/app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

/*Container(
margin: EdgeInsets.all(5),
child: GridView.count(
shrinkWrap: true,
crossAxisCount: 4,
childAspectRatio: 1,
mainAxisSpacing: 16.0,
crossAxisSpacing: 16.0,
children: <Map<int, String>>[
//                    {1: "%"},
//                    {1: "^"},
//                    {1: "x2"},0
//                    {1: "/"},
    {1: "CE"},
{1: "C"},
{1: "<="},
{1: "*"},
{2: "7"},
{2: "8"},
{2: "9"},
{1: "-"},
{2: "4"},
{2: "5"},
{2: "6"},
{1: "+"}
].map((map) {
return getButtonView(map);
}).toList()),
),
Padding(
padding: EdgeInsets.fromLTRB(0, 4, 4, 0),
child: Row(
mainAxisSize: MainAxisSize.min,
children: <Widget>[
Expanded(
flex: 3,
child: GridView.count(
crossAxisCount: 3,
shrinkWrap: true,
childAspectRatio: 1,
mainAxisSpacing: 16.0,
crossAxisSpacing: 16.0,
children: <Map<int, String>>[
{1: "%"},
{1: "^"},
{1: "x2"},
{1: "/"},
{1: "CE"},
{1: "C"},
].map((map) {
return getButtonView(map);
}).toList()),
),
Expanded(
flex: 1,
child: Container(
height: 166,
margin: EdgeInsets.fromLTRB(4, 0, 0, 0),
child: getButtonView({1: "+"}),
),
)
],
),
)*/
