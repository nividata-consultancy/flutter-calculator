class Calculator {
  String key;
  String text;
  ShapeType shapeType;
  TextType textType;
  ResourceType resourceType;

  Calculator(String key, String text, ShapeType shapeType, TextType textType,
      ResourceType resourceType) {
    this.key = key;
    this.text = text;
    this.shapeType = shapeType;
    this.textType = textType;
    this.resourceType = resourceType;
  }
}

enum TextType { OPERATOR, OPERAND, BACK, EQUAL, CLEAR, BRACKET, PERIOD }
enum ResourceType { TEXT, IMAGE_SVG, MULTIPLY, BACK_SPACE }
enum ShapeType { ROUND,DARK_ROUND, NAN }
