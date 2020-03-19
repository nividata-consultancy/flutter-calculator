import '../../expression_language.dart';

class Modulo2Expression extends Expression<Number> {
  final Expression<Number> left;
  final Expression<Number> right;

  Modulo2Expression(this.left, this.right);

  @override
  Number evaluate() {
    return left.evaluate() * right.evaluate() * Decimal("0.01");
  }

  @override
  Type getType() {
    return getTypeOfNumberExpression(left.getType(), right.getType());
  }

  @override
  void accept(ExpressionVisitor visitor) {
    visitor.visitModulo2(this);
  }
}
