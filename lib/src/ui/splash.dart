import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rxdart/rxdart.dart';
import 'ConverterCalc.dart';
import 'home.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  StreamSubscription subscription;

  @override
  Widget build(BuildContext context) {
    subscription = Stream.value(0).delay(Duration(seconds: 2)).listen((_) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home()));
    });

    return Material(
      color: Color(0xff273639),
      child: SafeArea(
        top: false,
        bottom: true,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SvgPicture.asset(
                    "assets/calculator.svg",
                    height: 144,
                    width: 144,
                  ),
                  SizedBox(width: 10, height: 20),
                  Text("Calculator",
                      style: TextStyle(
                          fontSize: 30.0,
                          color: Color(0xff009e8c),
                          fontFamily: "Montserrat"))
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                          radius: 20.0,
                          backgroundImage: AssetImage("assets/icon.png")),
                      Text("  NiviData\n  Consultancy",
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Colors.white70,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
}
