import 'constant/others/base_unit.dart';
import 'converter/unit_converter.dart';
import 'enum/converter.dart';

export 'enum/acceleration_unit.dart';
export 'enum/area_unit.dart';
export 'enum/blood_cholesterol_unit.dart';
export 'enum/blood_glucose_unit.dart';
export 'enum/capacitance_unit.dart';
export 'enum/converter.dart';
export 'enum/data_rate_unit.dart';
export 'enum/data_unit.dart';
export 'enum/density_unit.dart';
export 'enum/dynamic_viscocity_unit.dart';
export 'enum/electric_charge_unit.dart';
export 'enum/electric_current_unit.dart';
export 'enum/electric_potential_unit.dart';
export 'enum/electrical_conductance_unit.dart';
export 'enum/electrical_resistance_unit.dart';
export 'enum/energy_unit.dart';
export 'enum/force_unit.dart';
export 'enum/frequency_unit.dart';
export 'enum/illuminance_unit.dart';
export 'enum/inductance_unit.dart';
export 'enum/kinematic_viscocity_unit.dart';
export 'enum/length_unit.dart';
export 'enum/luminance_unit.dart';
export 'enum/magnetic_field_intensity_unit.dart';
export 'enum/magnetic_flux_density_unit.dart';
export 'enum/magnetic_flux_unit.dart';
export 'enum/mass_flow_unit.dart';
export 'enum/mass_fraction_unit.dart';
export 'enum/mass_moment_of_inertia_unit.dart';
export 'enum/mass_per_area_unit.dart';
export 'enum/mass_unit.dart';
export 'enum/mole_fraction_unit.dart';
export 'enum/plane_angle_unit.dart';
export 'enum/power_unit.dart';
export 'enum/pressure_unit.dart';
export 'enum/radioactivity_unit.dart';
export 'enum/sound_unit.dart';
export 'enum/speed_unit.dart';
export 'enum/temperature_unit.dart';
export 'enum/time_unit.dart';
export 'enum/torque_unit.dart';
export 'enum/volume_flow_per_area_unit.dart';
export 'enum/volume_flow_unit.dart';
export 'enum/volume_per_area_unit.dart';
export 'enum/volume_unit.dart';
export 'enum/water_hardness_unit.dart';

/// Get an `UnitConverter` instance of type `type`.
UnitConverter getConverter(Converter type) {
  return UnitConverter(type, baseUnit[type]);
}
