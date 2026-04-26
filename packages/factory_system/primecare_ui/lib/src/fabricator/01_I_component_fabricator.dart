// Layer: 01_INFRASTRUCTURE
import 'package:primecare_ui/primecare_ui.dart';

class ComponentFabricator {
  /// Dynamically assembles an empty PrimeCare UI component based on the Blueprint type
  /// and injects the required data payload.
  static Widget assemble(BuildContext context, UIComponentBlueprint blueprint) {
    // Delegate entirely to the centralized O(1) ComponentWarehouse.
    // This allows components to be securely registered at runtime or mock-time
    // without ever expanding a massive imperative switch statement.
    return ComponentWarehouse.build(
      blueprint.componentType,
      context,
      blueprint.dataPayload,
    );
  }
}
