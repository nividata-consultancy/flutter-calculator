class Calculator {
  String key;
  String text;
  TextType textType;

  Calculator(String key, String text, TextType textType) {
    this.key = key;
    this.text = text;
    this.textType = textType;
  }
}

enum TextType { OPERATOR, OPERAND, BACK, EQUAL, CLEAR, BRACKET, PERIOD }
