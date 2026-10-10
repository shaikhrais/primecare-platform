import 'package:primecare_models/primecare_models.dart';
import 'base_screen_intent.dart';

/// Central Governance Registry for the PrimeCare Platform.
/// This system manages the lifecycle and "Intent" of all platform screens,
/// ensuring advanced decoupling between route definition and UI implementation.
class BaseGovernanceRegistry<T extends BaseScreenIntent> {
  final Map<String, T> _intentsByRoute = {};
  final Map<String, T> _intentsByRole = {};

  /// Registers a screen intent with the governance system.
  void register(T intent, {String? role}) {
    _intentsByRoute[intent.route] = intent;

    final effectiveRole = role ?? intent.requiredRole?.nameSnake;
    if (effectiveRole != null) {
      _intentsByRole[effectiveRole] = intent;
    }
  }

  /// Retrieves the intent for a specific route.
  T? getIntentByRoute(String route) {
    return _intentsByRoute[route];
  }

  /// Retrieves the intent for a specific role.
  T? getIntentByRole(String role) {
    return _intentsByRole[role];
  }

  /// Lists all registered screen identifiers.
  List<String> get registeredRoutes => _intentsByRoute.keys.toList();

  /// Returns all registered intents.
  List<T> getAllIntents() =>
      _intentsByRoute.values.toList();

  /// Performs a system-wide "Health Sweep" to identify intents with missing dependencies.
  List<HealthReport> performHealthSweep(dynamic ref) {
    final reports = <HealthReport>[];
    _intentsByRoute.forEach((route, intent) {
      final health = intent.verifyReady(ref);
      reports.add(
        HealthReport(
          route: route,
          isHealthy: health.isReady,
          message: health.message,
        ),
      );
    });
    return reports;
  }

  /// Performs a full domain audit to identify missing role implementations.
  DomainAuditResult performDomainAudit() {
    final universe = PlatformRole.values
        .where(
          (r) =>
              r != PlatformRole.unknown &&
              r != PlatformRole.system &&
              r.index < PlatformRole.corporate.index,
        ) // Only primary roles
        .toList();

    final realized = <PlatformRole>[];
    final pending = <PlatformRole>[];

    for (final role in universe) {
      if (_intentsByRole.containsKey(role.nameSnake)) {
        realized.add(role);
      } else {
        pending.add(role);
      }
    }

    final score = universe.isEmpty
        ? 0.0
        : (realized.length / universe.length) * 100;

    return DomainAuditResult(
      totalRoles: universe.length,
      realizedRoles: realized,
      pendingRoles: pending,
      orphans: [],
      integrityScore: score,
    );
  }

  /// Clears all registered intents. Use this during a mechanical reset
  /// to ensure the next bootstrap has a clean state.
  void flush() {
    _intentsByRoute.clear();
    _intentsByRole.clear();
  }
}

