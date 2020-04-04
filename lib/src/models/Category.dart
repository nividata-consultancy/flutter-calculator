import 'Unit.dart';

class Category {
  final String name;
  final List<Unit> units;
  bool isChipSelected;
  String firstDropdownName = "";
  String firstDropdownShortName = "";
  String secondDropdownName = "";
  String secondDropdownShortName = "";

  Category({
    this.name,
    this.units,
    this.isChipSelected,
  })  : assert(name != null),
        assert(units != null),
        assert(units.length > 1) {
    this.firstDropdownName = units[0].name;
    this.firstDropdownShortName = units[0].shortName;
    this.secondDropdownName = units[1].name;
    this.secondDropdownShortName = units[1].shortName;
  }
}
