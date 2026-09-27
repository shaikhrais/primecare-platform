// Governance - Category: service | Purpose: [RegistryScanner] - Detects "Rogue" endpoints by comparing implementation against registry. This ensures 100% of the ...
import '../models/api_metadata.dart';

/// [RegistryScanner] - Detects "Rogue" endpoints by comparing implementation against registry.
/// This ensures 100% of the platform code is governed and audited.
class RegistryScanner {
  /// Compares a list of implemented routes against the Governance Registry.
  /// Returns a list of "Rogue" routes that are missing metadata.
  static List<String> findRogueEndpoints(
    List<String> implementedRoutes,
    Map<String, ApiMetadata> registeredApis,
  ) {
    final rogueRoutes = <String>[];
    final registeredPaths = registeredApis.values.map((api) => api.endpoint).toSet();

    for (final route in implementedRoutes) {
      if (!registeredPaths.contains(route)) {
        rogueRoutes.add(route);
      }
    }

    return rogueRoutes;
  }

  /// Validates that every registered API has an implementation.
  /// Returns "Orphaned" metadata entries that point to non-existent code.
  static List<String> findOrphanedMetadata(
    List<String> implementedRoutes,
    Map<String, ApiMetadata> registeredApis,
  ) {
    final orphaned = <String>[];
    final implementedSet = implementedRoutes.toSet();

    registeredApis.forEach((id, metadata) {
      if (!implementedSet.contains(metadata.endpoint)) {
        orphaned.add(id);
      }
    });

    return orphaned;
  }
}
