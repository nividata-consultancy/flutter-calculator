import '../../../expression_language.dart';
class LengthFunctionExpression extends Expression<Integer> {
  final Expression<String> value;

  LengthFunctionExpression(this.value);

  @override
  Integer evaluate() {
    return Integer(value.evaluate().length);
  }

  @override
  void accept(ExpressionVisitor visitor) {
    visitor.visitLengthFunction(this);
  }
}
