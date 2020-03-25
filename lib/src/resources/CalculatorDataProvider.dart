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

  static const CLEAR = 'CA';
  static const BACK = '<=';
  static const EQUAL = '=';
  static const OPEN_BRACKET = '()';

  static Calculator getButtonData(String text) {
    switch (text) {
      case ONE:
        return Calculator(ONE, ONE, TextType.OPERAND, ResourceType.TEXT);
        break;
      case TWO:
        return Calculator(TWO, TWO, TextType.OPERAND, ResourceType.TEXT);
        break;
      case THREE:
        return Calculator(THREE, THREE, TextType.OPERAND, ResourceType.TEXT);
        break;
      case FOUR:
        return Calculator(FOUR, FOUR, TextType.OPERAND, ResourceType.TEXT);
        break;
      case FIVE:
        return Calculator(FIVE, FIVE, TextType.OPERAND, ResourceType.TEXT);
        break;
      case SIX:
        return Calculator(SIX, SIX, TextType.OPERAND, ResourceType.TEXT);
        break;
      case SEVEN:
        return Calculator(SEVEN, SEVEN, TextType.OPERAND, ResourceType.TEXT);
        break;
      case EIGHT:
        return Calculator(EIGHT, EIGHT, TextType.OPERAND, ResourceType.TEXT);
        break;
      case NINE:
        return Calculator(NINE, NINE, TextType.OPERAND, ResourceType.TEXT);
        break;
      case ZERO:
        return Calculator(ZERO, ZERO, TextType.OPERAND, ResourceType.TEXT);
        break;

      case ADD:
        return Calculator(
            ADD, "assets/plus.svg", TextType.OPERATOR, ResourceType.IMAGE_SVG);
        break;
      case SUBTRACT:
        return Calculator(SUBTRACT, "assets/minus.svg", TextType.OPERATOR,
            ResourceType.IMAGE_SVG);
        break;
      case MULTIPLY:
        return Calculator(
            MULTIPLY, MULTIPLY, TextType.OPERATOR, ResourceType.MULTIPLY);
        break;
      case DIVIDE:
        return Calculator(DIVIDE, "assets/divide.svg", TextType.OPERATOR,
            ResourceType.IMAGE_SVG);
        break;
      case PERCENTAGE:
        return Calculator(PERCENTAGE, "assets/percent.svg", TextType.OPERATOR,
            ResourceType.IMAGE_SVG);
        break;

      case CLEAR:
        return Calculator(CLEAR, CLEAR, TextType.CLEAR, ResourceType.TEXT);
        break;
      case BACK:
        return Calculator(BACK, "assets/backspace.svg", TextType.BACK,
            ResourceType.BACK_SPACE);
        break;
      case EQUAL:
        return Calculator(
            EQUAL, "assets/equal.svg", TextType.EQUAL, ResourceType.IMAGE_SVG);
        break;
      case OPEN_BRACKET:
        return Calculator(OPEN_BRACKET, "assets/parentheses.svg",
            TextType.BRACKET, ResourceType.IMAGE_SVG);
        break;
      case PERIOD:
        return Calculator(PERIOD, PERIOD, TextType.PERIOD, ResourceType.TEXT);
        break;
    }
  }
}
