import 'dart:async';

import 'package:calculator/src/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rxdart/rxdart.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  StreamSubscription subscription;

  @override
  Widget build(BuildContext context) {
    subscription = Stream.value(0).delay(Duration(seconds: 2)).listen((_) {
//      Navigator.pushReplacement(
//          context, MaterialPageRoute(builder: (context) => Home()));
    });

    return Container(
      constraints: BoxConstraints.expand(),
      color: Color(0xFFEFEFEF),
      child: Column(
        children: <Widget>[
          Center(
            child: SvgPicture.asset(
              "assets/calculator.svg",
              height: 80,
              width: 80,
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(30.0, 0.0, 0.0, 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Text(
                      "Built with  ",
                      style: TextStyle(
                          color: Colors.black38,
                          fontSize: 10.0,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "  By",
                      style: TextStyle(
                          color: Colors.black38,
                          fontSize: 10.0,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                Text(""),
                Row(
                  children: <Widget>[
                    CircleAvatar(
                        radius: 20.0,
                        backgroundImage: AssetImage("assets/icon.png")),
                    Text("  NiviData\n  Consultancy",
                        style: TextStyle(
                            color: Colors.black38,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold))
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
}
