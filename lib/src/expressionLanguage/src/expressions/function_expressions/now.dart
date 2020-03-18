import '../../../expression_language.dart';
class NowFunctionExpression extends Expression<DateTime> {
  @override
  void accept(ExpressionVisitor visitor) {
    visitor.visitNowFunction(this);
  }

  @override
  DateTime evaluate() => DateTime.now();
}

class NowInUtcFunctionExpression extends Expression<DateTime> {
  @override
  void accept(ExpressionVisitor visitor) {
    visitor.visitNowInUtcFunction(this);
  }

  @override
  DateTime evaluate() => DateTime.now().toUtc();
}

class DiffDateTimeFunctionExpression extends Expression<Duration> {
  final Expression<DateTime> left;
  final Expression<DateTime> right;

  DiffDateTimeFunctionExpression(this.left, this.right);

  @override
  Duration evaluate() {
    var diff = left.evaluate().difference(right.evaluate());
    return (diff < Duration(microseconds: 0)) ? (-diff) : diff;
  }

  @override
  void accept(ExpressionVisitor visitor) {
    visitor.visitDiffDateTimeFunction(this);
  }
}
