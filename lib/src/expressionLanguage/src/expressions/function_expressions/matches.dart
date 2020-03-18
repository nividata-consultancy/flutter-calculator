import '../../../expression_language.dart';
class MatchesFunctionExpression extends Expression<bool> {
  final Expression<String> value;
  final Expression<String> regex;

  MatchesFunctionExpression(this.value, this.regex);

  @override
  bool evaluate() {
    return _isFullMatch(value.evaluate(), regex.evaluate());
  }

  @override
  void accept(ExpressionVisitor visitor) {
    visitor.visitMatchesFunction(this);
  }

  bool _isFullMatch(String value, String regexSource) {
    try {
      final regex = RegExp(regexSource);
      final matches = regex.allMatches(value);
      for (Match match in matches) {
        if (match.start == 0 && match.end == value.length) {
          return true;
        }
      }
      return false;
    } catch (e) {
      throw InvalidRegularExpressionException(
          'Regular expression $regexSource is invalid');
    }
  }
}
