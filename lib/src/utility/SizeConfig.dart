import 'package:flutter/widgets.dart';

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double buttonSize;
  static double resultTextSize;
  static double expTextSize;

  static double pixelRatio;
  static double heightWidthFactor;
  static double textScaleFactor;


  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    pixelRatio = _mediaQueryData.devicePixelRatio;
    buttonSize = (screenWidth / 4) - 12;
    heightWidthFactor = screenHeight / screenWidth;
    expTextSize = screenHeight - (buttonSize * 5) - (buttonSize);
    textScaleFactor = _mediaQueryData.textScaleFactor;

  }
}
