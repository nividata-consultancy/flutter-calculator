class Calculator {
  String text;
  TextType textType;

  Calculator(String text, TextType textType) {
    this.text = text;
    this.textType = textType;
  }
}

enum TextType { OPERATOR, OPERAND, BACK, EQUAL, CLEAR, BRACKET }
