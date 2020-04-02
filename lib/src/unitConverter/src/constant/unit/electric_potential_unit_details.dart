import 'dart:math' show pow;

import '../../enum/electric_potential_unit.dart';
import '../../enum/symbol_part.dart';
import '../../misc/global.dart';
import '../others/misc.dart';

/// __volt variations
final _voltVariations = createUnitVariation(
  ElectricPotentialUnit.values,
  '${variationUnitNameSeperator}volt',
  1,
  decimalPrefixes,
  namePostfix: 'volt',
  symbolPostfix: createSymbol(
    const [
      SymbolPart.volt,
    ],
  ),
);

/// other units
final _otherUnits = {
  createUnit(
    'abvolt',
    createSymbol(
      const [
        SymbolPart.ab,
        SymbolPart.volt,
      ],
    ),
    ElectricPotentialUnit.abVolt,
    conversionFactor: pow(10, -8),
    variation: true,
  ),
};

/// Electric potential unit details
final electricPotentialUnitDetails = {
  ..._voltVariations,
  ..._otherUnits,
};
