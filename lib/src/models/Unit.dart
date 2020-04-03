import 'package:meta/meta.dart';

class Unit {
  final String name;
  final double conversion;
  final String shortName;

  const Unit(
      {@required this.name,
      @required this.conversion,
      @required this.shortName})
      : assert(name != null),
        assert(conversion != null),
        assert(shortName != null);

  Unit.fromJson(Map jsonMap)
      : assert(jsonMap['name'] != null),
        assert(jsonMap['conversion'] != null),
        assert(jsonMap['short_name'] != null),
        name = jsonMap['name'],
        conversion = jsonMap['conversion'].toDouble(),
        shortName = jsonMap['short_name'];
}
