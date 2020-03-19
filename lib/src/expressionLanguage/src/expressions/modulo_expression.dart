import '../../expression_language.dart';

class ModuloExpression extends Expression<Number> {
  final Expression<Number> value;

  ModuloExpression(this.value);

  @override
  Number evaluate() {
    return value.evaluate() * Decimal("0.01");
  }

  @override
  void accept(ExpressionVisitor visitor) {
    visitor.visitModulo(this);
  }
}
