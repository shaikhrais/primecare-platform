// Governance - Category: view | Purpose: [PlatformScreenRegistry] - Centralized single source of truth for all platform screens. This registry serves both the...
import '../models/screen_metadata.dart';

/// [PlatformScreenRegistry] - Centralized single source of truth for all platform screens.
/// This registry serves both the UI implementation (primecare_ui) and 
/// the governance monitoring (primecare_governance).
class PlatformScreenRegistry {
  static final Map<String, ScreenMetadata> screens = {
  };

  static List<ScreenMetadata> get allScreens => screens.values.toList();

  static ScreenMetadata? getById(String id) => screens[id];

  static void registerScreens(List<ScreenMetadata> newScreens) {
    for (final screen in newScreens) {
      screens[screen.id] = screen;
    }
  }

  static void clearRegistry() {
    screens.clear();
  }

  static List<ScreenMetadata> getAllScreens() => screens.values.toList();
}
