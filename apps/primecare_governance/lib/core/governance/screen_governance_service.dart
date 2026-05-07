import 'screen_metadata.dart';

/// [ScreenGovernanceService] - Orchestrates cross-registry analytics and validation.
class ScreenGovernanceService {
  final List<ScreenMetadata> registry;

  ScreenGovernanceService(this.registry);

  /// Identifies duplicate route paths that could cause navigation collisions.
  List<String> findDuplicateRoutes() {
    final Map<String, int> counts = {};
    for (final screen in registry) {
      counts[screen.routePath] = (counts[screen.routePath] ?? 0) + 1;
    }
    return counts.entries.where((e) => e.value > 1).map((e) => e.key).toList();
  }

  /// Returns screens that share duplicate route paths.
  List<ScreenMetadata> getDuplicateRouteScreens() {
    final dupRoutes = findDuplicateRoutes();
    return registry.where((s) => dupRoutes.contains(s.routePath)).toList();
  }

  /// Calculates the aggregate health score for the entire platform.
  double calculatePlatformHealth() {
    if (registry.isEmpty) return 0;

    final dupRoutes = findDuplicateRoutes().length;

    final totalScore = registry.fold(0.0, (sum, screen) {
      double screenScore =
          screen.completionPercent * 0.4 +
          screen.testPassRate * 0.3 +
          screen.accessibilityScore * 0.15 +
          screen.performanceScore * 0.15;

      // Penalize for security risks without verification
      if (screen.securityLevel == SecurityTier.high && !screen.isRenderOk) {
        screenScore *= 0.8;
      }

      return sum + screenScore;
    });

    double aggregateScore = totalScore / registry.length;

    // Global penalty for navigation collisions
    if (dupRoutes > 0) {
      aggregateScore -= (dupRoutes * 0.5); // 0.5% penalty per collision
    }

    return aggregateScore.clamp(0.0, 100.0);
  }

  /// Generates a report of screens that are high-risk.
  List<ScreenMetadata> getHighRiskScreens() {
    return registry.where((s) => s.hasRisk).toList();
  }

  /// Returns screens that are 100% production ready.
  List<ScreenMetadata> getProductionReadyScreens() {
    return registry.where((s) => s.isReadyForProduction).toList();
  }

  /// Maps API dependencies to screens.
  Map<String, List<String>> getApiDependencyMap() {
    final Map<String, List<String>> apiMap = {};
    for (final screen in registry) {
      for (final api in screen.requiredApis) {
        apiMap.putIfAbsent(api, () => []).add(screen.featureName);
      }
    }
    return apiMap;
  }

  /// Counts screens by lifecycle status.
  Map<LifecycleStatus, int> getLifecycleDistribution() {
    final Map<LifecycleStatus, int> stats = {
      for (var status in LifecycleStatus.values) status: 0,
    };
    for (final screen in registry) {
      stats[screen.lifecycleStatus] = (stats[screen.lifecycleStatus] ?? 0) + 1;
    }
    return stats;
  }

  /// Identifies localization gaps.
  List<ScreenMetadata> getLocalizationGaps() {
    return registry.where((s) => !s.isLocalizationReady).toList();
  }

  /// Tracks sprint workload by points.
  int getTotalSprintPoints() {
    return registry.fold(0, (sum, s) => sum + s.sprintPoints);
  }
}
