
import 'Unit.dart';

class Category {
  final String name;
  final List<Unit> units;

  const Category({this.name, this.units})
      : assert(name != null),
        assert(units != null);
}
