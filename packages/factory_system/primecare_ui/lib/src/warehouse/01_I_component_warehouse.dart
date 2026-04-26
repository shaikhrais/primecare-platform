// Layer: 01_INFRASTRUCTURE
import 'package:flutter_core/00_B_flutter_core.dart';
import 'offices/base_office_warehouse.dart';
import 'offices/corporate_warehouse.dart';
import 'offices/clinical_warehouse.dart';
import 'offices/franchise_warehouse.dart';
import 'offices/business_development_warehouse.dart';
import 'offices/client_portal_warehouse.dart';
import 'offices/support_warehouse.dart';
import 'offices/infrastructure_warehouse.dart';
import 'offices/common_warehouse.dart';

/// A function signature for building a specific component from a blueprint payload.
typedef ComponentBuilder =
    Widget Function(BuildContext context, dynamic dataPayload);

/// A centralized registry to securely map component string types to their respective Builders.
/// This replaces large switch statements and is O(1) time complexity.
/// Now modularized into Office-specific warehouses for better scalability.
class ComponentWarehouse {
  static final Map<String, ComponentBuilder> _registry = {};
  static bool _isBootstrapped = false;

  /// Ensures all office-specific warehouses are registered.
  static void bootstrap() {
    if (_isBootstrapped) return;

    final warehouses = <BaseOfficeWarehouse>[
      CommonComponentWarehouse(),
      CorporateComponentWarehouse(),
      ClinicalComponentWarehouse(),
      FranchiseComponentWarehouse(),
      BusinessDevelopmentComponentWarehouse(),
      ClientPortalComponentWarehouse(),
      SupportComponentWarehouse(),
      InfrastructureComponentWarehouse(),
    ];

    for (final warehouse in warehouses) {
      warehouse.bootstrap(_registry);
    }

    _isBootstrapped = true;
  }

  /// Retrieves a component builder for the given type.
  static ComponentBuilder? getBuilder(String type) {
    if (!_isBootstrapped) {
      bootstrap();
    }
    return _registry[type];
  }

  /// Builds a component of the specified type with the provided payload.
  static Widget build(String type, BuildContext context, dynamic payload) {
    final builder = getBuilder(type);
    if (builder != null) {
      return builder(context, payload);
    }

    // Fallback if component not found
    return Center(
      child: Text(
        'Component not found: $type',
        style: const TextStyle(color: Colors.red),
      ),
    );
  }

  /// Exposed for testing or dynamic registration
  static void register(String type, ComponentBuilder builder) {
    _registry[type] = builder;
  }

  /// Mechanically flushes all registered components.
  /// Next call to getBuilder() will re-bootstrap the warehouses.
  static void flush() {
    _registry.clear();
    _isBootstrapped = false;
  }
}
