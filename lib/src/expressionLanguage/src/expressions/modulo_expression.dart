import '../../expression_language.dart';

class ModuloExpression extends Expression<Number> {
  final Expression<Number> left;
  final Expression<Number> right;

  ModuloExpression(this.left, this.right);

  @override
  Number evaluate() {
/*    var rightValue = right.evaluate();
    var epsilon = Decimal.parse('1e-15');
    if (rightValue.abs() < epsilon) {
      throw DivideByZeroException('Modulo by zero');
    }*/
    return left.evaluate() * right.evaluate() * Decimal("0.01");
  }

  @override
  Type getType() {
    return getTypeOfNumberExpression(left.getType(), right.getType());
  }

  @override
  void accept(ExpressionVisitor visitor) {
    visitor.visitModulo(this);
  }
}
