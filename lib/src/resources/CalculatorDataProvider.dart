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
        return Calculator(ONE, ONE, TextType.OPERAND);
        break;
      case TWO:
        return Calculator(TWO, TWO, TextType.OPERAND);
        break;
      case THREE:
        return Calculator(THREE, THREE, TextType.OPERAND);
        break;
      case FOUR:
        return Calculator(FOUR, FOUR, TextType.OPERAND);
        break;
      case FIVE:
        return Calculator(FIVE, FIVE, TextType.OPERAND);
        break;
      case SIX:
        return Calculator(SIX, SIX, TextType.OPERAND);
        break;
      case SEVEN:
        return Calculator(SEVEN, SEVEN, TextType.OPERAND);
        break;
      case EIGHT:
        return Calculator(EIGHT, EIGHT, TextType.OPERAND);
        break;
      case NINE:
        return Calculator(NINE, NINE, TextType.OPERAND);
        break;
      case ZERO:
        return Calculator(ZERO, ZERO, TextType.OPERAND);
        break;

      case ADD:
        return Calculator(ADD, "assets/plus.svg", TextType.OPERATOR);
        break;
      case SUBTRACT:
        return Calculator(SUBTRACT, "assets/minus.svg", TextType.OPERATOR);
        break;
      case MULTIPLY:
        return Calculator(MULTIPLY, MULTIPLY, TextType.OPERATOR);
        break;
      case DIVIDE:
        return Calculator(DIVIDE, DIVIDE, TextType.OPERATOR);
        break;
      case PERCENTAGE:
        return Calculator(PERCENTAGE, PERCENTAGE, TextType.OPERATOR);
        break;

      case CLEAR:
        return Calculator(CLEAR, CLEAR, TextType.CLEAR);
        break;
      case BACK:
        return Calculator(BACK, "assets/backspace.svg", TextType.BACK);
        break;
      case EQUAL:
        return Calculator(EQUAL, EQUAL, TextType.EQUAL);
        break;
      case OPEN_BRACKET:
        return Calculator(OPEN_BRACKET, "( )", TextType.BRACKET);
        break;
      case PERIOD:
        return Calculator(PERIOD, PERIOD, TextType.PERIOD);
        break;
    }
  }
}
