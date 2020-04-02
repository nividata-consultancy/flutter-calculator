/// This class defines a metric prefix
class Prefix {
  /// Base of the prefix
  final int base;

  /// Exponent  of the prefix
  final int exponent;

  /// Prefix constructor
  const Prefix(this.base, this.exponent)
      : assert(base != null),
        assert(exponent != null);
}
