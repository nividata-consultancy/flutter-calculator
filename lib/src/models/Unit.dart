import 'package:meta/meta.dart';

class Unit {
  final String name;
  final double conversion;
  final String shortName;
  final bool baseUnit;

  Unit(
      {@required this.name,
      @required this.conversion,
      @required this.shortName,
      @required this.baseUnit})
      : assert(name != null),
        assert(conversion != null),
        assert(shortName != null);

  @override
  String toString() {
    return 'Unit{name: $name, conversion: $conversion, shortName: $shortName}';
  }

  Unit.fromJson(Map jsonMap)
      : assert(jsonMap['name'] != null),
        assert(jsonMap['conversion'] != null),
        name = jsonMap['name'],
        conversion = jsonMap['conversion'].toDouble(),
        shortName = jsonMap['short_name'],
        baseUnit = jsonMap['base_unit'] == null ? false : true;
}
