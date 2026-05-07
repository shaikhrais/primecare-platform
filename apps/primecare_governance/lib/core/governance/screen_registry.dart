export 'screen_metadata.dart';
import 'screen_metadata.dart';

// Domain Registries
import 'package:primecare_governance/core/governance/registries/index.dart';

class ScreenRegistry {
  // Common Screen Constants
  static const String dashboard = 'SCREEN_DASHBOARD';
  static const String clinical = 'SCREEN_CLINICAL';
  static const String billing = 'SCREEN_BILLING';

  // Registry Aggregator
  static final Map<String, ScreenMetadata> screens = Registry.screens;

  // Helper to find screen by ID
  static ScreenMetadata? getById(String id) => screens[id];

  // Helper to find screen by route
  static ScreenMetadata? getByRoute(String route) {
    try {
      return screens.values.firstWhere((s) => s.routePath == route);
    } catch (_) {
      return null;
    }
  }

  // Helper to get all registered screens
  static List<ScreenMetadata> getAllScreens() => screens.values.toList();
}
