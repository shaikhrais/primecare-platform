import 'package:flutter_core/flutter_core.dart';

// Domain Registries

class ScreenRegistry {
  // Common Screen Constants
  static const String dashboard = 'SCREEN_DASHBOARD';
  static const String clinical = 'SCREEN_CLINICAL';
  static const String billing = 'SCREEN_BILLING';

  // Registry Aggregator - Single Source of Truth from flutter_core
  static Map<String, ScreenMetadata> get screens => PlatformScreenRegistry.screens;

  // Helper to get all registered screens
  static List<ScreenMetadata> get allScreens => PlatformScreenRegistry.allScreens;

  // Helper to find screen by ID
  static ScreenMetadata? getById(String id) => PlatformScreenRegistry.getById(id);

  // Helper to find screen by route
  static ScreenMetadata? getByRoute(String route) {
    try {
      return screens.values.firstWhere((s) => s.routePath == route);
    } catch (_) {
      return null;
    }
  }

  // Bridging method for UI hydration
  static List<ScreenMetadata> getAllScreens() => allScreens;
}
