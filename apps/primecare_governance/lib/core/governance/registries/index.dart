// Governance - Category: service | Purpose: Core implementation file for the Index platform logic.
import 'package:primecare_runtime/primecare_runtime.dart';
import 'core_governance_registry.dart';

class Registry {
  static void registerAll() {
    CoreGovernanceRegistry.registerScreens();
  }

  static ScreenMetadata? getById(String id) => PlatformScreenRegistry.getById(id);
  static Map<String, ScreenMetadata> get screens => CoreGovernanceRegistry.screens;
  static List<ScreenMetadata> getAllScreens() => PlatformScreenRegistry.allScreens;
}
