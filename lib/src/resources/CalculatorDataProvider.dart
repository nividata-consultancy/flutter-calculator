import 'package:calculator/src/models/Calculator.dart';

class CalculatorDataProvider {
  static const ONE = '1';
  static const TWO = '3';
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

  static const CLEAR = 'C';
  static const BACK = '<=';
  static const EQUAL = '=';
  static const OPEN_BRACKET = '()';
  static const CLOSE_BRACKET = ')';

  static Calculator getButtonData(String text) {
    switch (text) {
      case ONE:
        return Calculator(ONE, TextType.OPERAND);
        break;
      case TWO:
        return Calculator(TWO, TextType.OPERAND);
        break;
      case THREE:
        return Calculator(THREE, TextType.OPERAND);
        break;
      case FOUR:
        return Calculator(FOUR, TextType.OPERAND);
        break;
      case FIVE:
        return Calculator(FIVE, TextType.OPERAND);
        break;
      case SIX:
        return Calculator(SIX, TextType.OPERAND);
        break;
      case SEVEN:
        return Calculator(SEVEN, TextType.OPERAND);
        break;
      case EIGHT:
        return Calculator(EIGHT, TextType.OPERAND);
        break;
      case NINE:
        return Calculator(NINE, TextType.OPERAND);
        break;
      case ZERO:
        return Calculator(ZERO, TextType.OPERAND);
        break;
      case PERIOD:
        return Calculator(PERIOD, TextType.OPERAND);
        break;

      case ADD:
        return Calculator(ADD, TextType.OPERATOR);
        break;
      case SUBTRACT:
        return Calculator(SUBTRACT, TextType.OPERATOR);
        break;
      case MULTIPLY:
        return Calculator(MULTIPLY, TextType.OPERATOR);
        break;
      case DIVIDE:
        return Calculator(DIVIDE, TextType.OPERATOR);
        break;

      case CLEAR:
        return Calculator(CLEAR, TextType.CLEAR);
        break;
      case BACK:
        return Calculator(BACK, TextType.BACK);
        break;
      case EQUAL:
        return Calculator(EQUAL, TextType.EQUAL);
        break;
      case OPEN_BRACKET:
        return Calculator(OPEN_BRACKET, TextType.OTHER);
        break;
      case CLOSE_BRACKET:
        return Calculator(CLOSE_BRACKET, TextType.OTHER);
        break;
    }
  }
}
