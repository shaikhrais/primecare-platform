// Layer: 01_INFRASTRUCTURE
import 'package:primecare_ui/src/warehouse/01_I_component_warehouse.dart';

/// A contract for office-specific component warehouses.
/// This ensures a standardized registration process across different domains.
abstract class BaseOfficeWarehouse {
  /// Returns a map of component keys to their respective builders for this office.
  Map<String, ComponentBuilder> get builders;

  /// Bootstraps the office-specific builders into the main warehouse registry.
  void bootstrap(Map<String, ComponentBuilder> registry) {
    registry.addAll(builders);
  }
}
