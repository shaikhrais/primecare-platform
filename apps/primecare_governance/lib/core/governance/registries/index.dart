import 'package:flutter_core/flutter_core.dart';
import 'core_governance_registry.dart';

class Registry {
  static void registerAll() {
    CoreGovernanceRegistry.registerScreens();
  }

  static ScreenMetadata? getById(String id) => PlatformScreenRegistry.getById(id);
  static Map<String, ScreenMetadata> get screens => CoreGovernanceRegistry.screens;
  static List<ScreenMetadata> getAllScreens() => PlatformScreenRegistry.allScreens;
}
