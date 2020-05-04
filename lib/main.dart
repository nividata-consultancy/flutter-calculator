import 'package:calculator/src/ui/splash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final String fontFamily = "Montserrat";

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Color(0xff273639),
          accentColor: Color(0xff009e8c),
          brightness: Brightness.dark,
          fontFamily: fontFamily,
          textTheme: TextTheme(
            display4:
                TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w300),
            display3:
                TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w500),
            display2:
                TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w400),
            display1:
                TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w400),
            headline:
                TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w400),
            title:
                TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w500),
            subhead:
                TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w400),
            body2:
                TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w500),
            body1:
                TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w400),
            caption:
                TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w400),
            subtitle:
                TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w500),
            button:
                TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w500),
          )),
      home: Splash(),
    );
  }
}
