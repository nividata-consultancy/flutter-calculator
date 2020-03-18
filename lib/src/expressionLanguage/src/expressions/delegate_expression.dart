import '../../expression_language.dart';

class DelegateExpression<T> extends Expression<T> {
  final ExpressionProvider<T> expressionProvider;
  final List<String> expressionPath;

  DelegateExpression(this.expressionPath, this.expressionProvider);

  @override
  T evaluate() {
    return expressionProvider.getExpression().evaluate();
  }

  ExpressionProvider<T> getExpressionProvider() {
    return expressionProvider;
  }

  @override
  void accept(ExpressionVisitor visitor) {
    visitor.visitDelegate(this);
  }
}
