import '../../expression_language.dart';

class MinusNumberExpression extends Expression<Number> {
  final Expression<Number> left;
  final Expression<Number> right;

  MinusNumberExpression(this.left, this.right);

  @override
  Number evaluate() {
    return left.evaluate() - right.evaluate();
  }

  @override
  Type getType() {
    return getTypeOfNumberExpression(left.getType(), right.getType());
  }

  @override
  void accept(ExpressionVisitor visitor) {
    visitor.visitMinusNumber(this);
  }
}
