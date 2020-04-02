import 'dart:math' show pow;

import '../../enum/inductance_unit.dart';
import '../../enum/symbol_part.dart';
import '../../misc/global.dart';
import '../others/misc.dart';

/// __henry variations
final _henryVariations = createUnitVariation(
  InductanceUnit.values,
  '${variationUnitNameSeperator}henry',
  1,
  decimalPrefixes,
  namePostfix: 'henry',
  symbolPostfix: createSymbol(
    const [
      SymbolPart.henry,
    ],
  ),
);

/// other units
final _otherUnits = {
  createUnit(
    'abhenry',
    createSymbol(
      const [
        SymbolPart.ab,
        SymbolPart.henry,
      ],
    ),
    InductanceUnit.abHenry,
    conversionFactor: pow(10, -9),
    variation: true,
  ),
};

/// Inductance unit details
final inductanceUnitDetails = {
  ..._henryVariations,
  ..._otherUnits,
};
