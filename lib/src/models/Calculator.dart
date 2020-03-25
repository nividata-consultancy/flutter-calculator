class Calculator {
  String key;
  String text;
  TextType textType;
  ResourceType resourceType;

  Calculator(
      String key, String text, TextType textType, ResourceType resourceType) {
    this.key = key;
    this.text = text;
    this.textType = textType;
    this.resourceType = resourceType;
  }
}

enum TextType { OPERATOR, OPERAND, BACK, EQUAL, CLEAR, BRACKET, PERIOD }
enum ResourceType { TEXT, IMAGE_SVG, MULTIPLY }
