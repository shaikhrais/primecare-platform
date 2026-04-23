import 'intents/01_I_app_screen_intent.dart';
import '01_I_auditor_blueprint.dart';

/// Central Governance Registry for the PrimeCare Platform.
/// This system manages the lifecycle and "Intent" of all platform screens,
/// ensuring advanced decoupling between route definition and UI implementation.
class GovernanceRegistry {
  static final Map<String, AppScreenIntent> _intentsByRoute = {};
  static final Map<String, AppScreenIntent> _intentsByRole = {};

  /// Registers a screen intent with the governance system.
  static void register(AppScreenIntent intent, {String? role}) {
    _intentsByRoute[intent.route] = intent;
    if (role != null) {
      _intentsByRole[role] = intent;
    }
  }

  /// Retrieves the intent for a specific route.
  static AppScreenIntent? getIntentByRoute(String route) {
    return _intentsByRoute[route];
  }

  /// Retrieves the intent for a specific role.
  static AppScreenIntent? getIntentByRole(String role) {
    return _intentsByRole[role];
  }

  /// Lists all registered screen identifiers.
  static List<String> get registeredRoutes => _intentsByRoute.keys.toList();

  /// Returns all registered intents.
  static List<AppScreenIntent> getAllIntents() => _intentsByRoute.values.toList();

  /// Performs a system-wide "Health Sweep" to identify intents with missing dependencies.
  static List<HealthReport> performHealthSweep(dynamic ref) {
    final reports = <HealthReport>[];
    _intentsByRoute.forEach((route, intent) {
      final health = intent.verifyReady(ref);
      reports.add(HealthReport(
        route: route,
        isHealthy: health.isReady,
        message: health.message,
      ));
    });
    return reports;
  }

  /// Performs a structural audit against the "Auditor's Blueprints".
  static List<BlueprintCompliance> performBlueprintAudit() {
    final results = <BlueprintCompliance>[];
    _intentsByRoute.forEach((route, intent) {
      final blueprint = BlueprintRegistry.getBlueprint(route);
      if (blueprint != null) {
        results.add(blueprint.audit(intent.componentLabels));
      }
    });
    return results;
  }

  /// Clears all registered intents. Use this during a mechanical reset
  /// to ensure the next bootstrap has a clean state.
  static void flush() {
    _intentsByRoute.clear();
    _intentsByRole.clear();
  }
}

/// A detailed report on the health of a specific screen intent.
class HealthReport {
  final String route;
  final bool isHealthy;
  final String? message;

  HealthReport({
    required this.route,
    required this.isHealthy,
    this.message,
  });
}
