import '../flutter_core.dart';

/// Central hub for initializing all platform application registries.
/// This is typically called once at the app entry point.
class PlatformInitializer {
  static void initializeAll(List<PlatformApplication> apps) {
    for (final app in apps) {
      PlatformApplicationRegistry.register(app);
    }
  }
}
