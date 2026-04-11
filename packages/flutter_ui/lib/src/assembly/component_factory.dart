import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'component_registry.dart';

class ComponentFactory {
  /// Dynamically assembles an empty PrimeCare UI component based on the Blueprint type
  /// and injects the required data payload.
  static Widget assemble(BuildContext context, UIComponentBlueprint blueprint) {
    // Delegate entirely to the centralized O(1) ComponentRegistry.
    // This allows components to be securely registered at runtime or mock-time
    // without ever expanding a massive imperative switch statement.
    return ComponentRegistry.build(context, blueprint);
  }
}
