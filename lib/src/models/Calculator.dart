class Calculator {
  String text;

  Calculator(String text, TextType textType) {
    this.text = text;
  }
}

enum TextType { OPERATOR, OPERAND, UTIL, OTHER }
