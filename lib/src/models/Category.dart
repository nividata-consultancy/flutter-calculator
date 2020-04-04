import 'Unit.dart';

class Category {
  final String name;
  final List<Unit> units;
   bool isChipSelected;

   Category({this.name, this.units, this.isChipSelected})
      : assert(name != null),
        assert(units != null);
}
