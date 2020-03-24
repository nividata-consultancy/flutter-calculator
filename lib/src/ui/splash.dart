import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rxdart/rxdart.dart';

import '../app.dart';

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
      color: Color(0xFFEFEFEF),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: SvgPicture.asset(
              "assets/calculator.svg",
              height: 80,
              width: 80,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "The product of...             ",
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.black54,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                      radius: 20.0,
                      backgroundImage: AssetImage("assets/icon.png")),
                  Text("  NiviData\n  Consultancy",
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.black54,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700)),
                ],
              ),
            ],
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
