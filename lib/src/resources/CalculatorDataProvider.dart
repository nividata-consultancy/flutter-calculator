import 'package:calculator/src/models/Calculator.dart';

class CalculatorDataProvider {
  static const ONE = '1';
  static const TWO = '2';
  static const THREE = '3';
  static const FOUR = '4';
  static const FIVE = '5';
  static const SIX = '6';
  static const SEVEN = '7';
  static const EIGHT = '8';
  static const NINE = '9';
  static const ZERO = '0';
  static const PERIOD = '.';

  static const ADD = '+';
  static const SUBTRACT = '-';
  static const MULTIPLY = '*';
  static const DIVIDE = '/';
  static const PERCENTAGE = '%';

  static const CLEAR_ALl = 'CA';
  static const BACK = '<=';
  static const EQUAL = '=';
  static const OPEN_BRACKET = '()';

  static const CLEAR = 'C';
  static const UP = '^';
  static const DOWN = 'V';
  static const BACK_CONV = '<';

  static Calculator getButtonData(String text) {
    switch (text) {
      case ONE:
        return Calculator(
            ONE, ONE, ShapeType.NAN, TextType.OPERAND, ResourceType.TEXT);
        break;
      case TWO:
        return Calculator(
            TWO, TWO, ShapeType.NAN, TextType.OPERAND, ResourceType.TEXT);
        break;
      case THREE:
        return Calculator(
            THREE, THREE, ShapeType.NAN, TextType.OPERAND, ResourceType.TEXT);
        break;
      case FOUR:
        return Calculator(
            FOUR, FOUR, ShapeType.NAN, TextType.OPERAND, ResourceType.TEXT);
        break;
      case FIVE:
        return Calculator(
            FIVE, FIVE, ShapeType.NAN, TextType.OPERAND, ResourceType.TEXT);
        break;
      case SIX:
        return Calculator(
            SIX, SIX, ShapeType.NAN, TextType.OPERAND, ResourceType.TEXT);
        break;
      case SEVEN:
        return Calculator(
            SEVEN, SEVEN, ShapeType.NAN, TextType.OPERAND, ResourceType.TEXT);
        break;
      case EIGHT:
        return Calculator(
            EIGHT, EIGHT, ShapeType.NAN, TextType.OPERAND, ResourceType.TEXT);
        break;
      case NINE:
        return Calculator(
            NINE, NINE, ShapeType.NAN, TextType.OPERAND, ResourceType.TEXT);
        break;
      case ZERO:
        return Calculator(
            ZERO, ZERO, ShapeType.NAN, TextType.OPERAND, ResourceType.TEXT);
        break;

      case ADD:
        return Calculator(ADD, "assets/plus.svg", ShapeType.ROUND,
            TextType.OPERATOR, ResourceType.IMAGE_SVG);
        break;
      case SUBTRACT:
        return Calculator(SUBTRACT, "assets/minus.svg", ShapeType.ROUND,
            TextType.OPERATOR, ResourceType.IMAGE_SVG);
        break;
      case MULTIPLY:
        return Calculator(MULTIPLY, "assets/multiply.svg", ShapeType.ROUND,
            TextType.OPERATOR, ResourceType.IMAGE_SVG);
        break;
      case DIVIDE:
        return Calculator(DIVIDE, "assets/divide.svg", ShapeType.ROUND,
            TextType.OPERATOR, ResourceType.IMAGE_SVG);
        break;
      case PERCENTAGE:
        return Calculator(PERCENTAGE, "assets/percent.svg", ShapeType.NAN,
            TextType.OPERATOR, ResourceType.IMAGE_SVG);
        break;

      case CLEAR_ALl:
        return Calculator(CLEAR_ALl, CLEAR_ALl, ShapeType.NAN,
            TextType.CLEAR, ResourceType.TEXT);
        break;
      case BACK:
        return Calculator(BACK, "assets/backspace.svg", ShapeType.NAN,
            TextType.BACK, ResourceType.BACK_SPACE);
        break;
      case EQUAL:
        return Calculator(EQUAL, "assets/equal.svg", ShapeType.ROUND,
            TextType.EQUAL, ResourceType.IMAGE_SVG);
        break;
      case OPEN_BRACKET:
        return Calculator(OPEN_BRACKET, "assets/parentheses.svg", ShapeType.NAN,
            TextType.BRACKET, ResourceType.IMAGE_SVG);
        break;
      case PERIOD:
        return Calculator(
            PERIOD, PERIOD, ShapeType.NAN, TextType.PERIOD, ResourceType.TEXT);
        break;
      case CLEAR:
        return Calculator(
            CLEAR, CLEAR, ShapeType.ROUND, TextType.CLEAR, ResourceType.TEXT);
        break;
      case UP:
        return Calculator(
            UP, UP, ShapeType.ROUND, TextType.UP, ResourceType.TEXT);
        break;
      case DOWN:
        return Calculator(
            DOWN, DOWN, ShapeType.ROUND, TextType.DOWN, ResourceType.TEXT);
        break;
      case BACK_CONV:
        return Calculator(BACK_CONV, BACK_CONV, ShapeType.ROUND, TextType.BACK,
            ResourceType.TEXT);
        break;
    }
  }
}
