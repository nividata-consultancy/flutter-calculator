import '../../expression_language.dart';

class ExpressionProviderCollectorVisitor extends TraversalExpressionsVisitor {
  final List<ExpressionProvider> expressionProviders = [];

  @override
  void visitDelegate<T>(DelegateExpression<T> expression) {
    expressionProviders.add(expression.getExpressionProvider());
  }
}
