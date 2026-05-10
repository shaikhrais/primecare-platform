import 'intents/app_screen_intent.dart';
import 'platform_role.dart';

/// Central Governance Registry for the PrimeCare Platform.
/// This system manages the lifecycle and "Intent" of all platform screens,
/// ensuring advanced decoupling between route definition and UI implementation.
class GovernanceRegistry {
  static final Map<String, AppScreenIntent> _intentsByRoute = {};
  static final Map<String, AppScreenIntent> _intentsByRole = {};

  /// Registers a screen intent with the governance system.
  static void register(AppScreenIntent intent, {String? role}) {
    _intentsByRoute[intent.route] = intent;

    final effectiveRole = role ?? intent.requiredRole?.nameSnake;
    if (effectiveRole != null) {
      _intentsByRole[effectiveRole] = intent;
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
  static List<AppScreenIntent> getAllIntents() =>
      _intentsByRoute.values.toList();

  /// Performs a system-wide "Health Sweep" to identify intents with missing dependencies.
  static List<HealthReport> performHealthSweep(dynamic ref) {
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
  static DomainAuditResult performDomainAudit() {
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
  static void flush() {
    _intentsByRoute.clear();
    _intentsByRole.clear();
  }
}

/// Bridge class for the Aura Pulse service to perform governance audits.
class PlatformGovernanceAudit {
  static DomainAuditResult performAudit(dynamic ref) {
    return GovernanceRegistry.performDomainAudit();
  }
}

/// A detailed report on the health of a specific screen intent.
class HealthReport {
  final String route;
  final bool isHealthy;
  final String? message;

  HealthReport({required this.route, required this.isHealthy, this.message});
}

/// A summary of the platform's domain implementation state.
class DomainAuditResult {
  final int totalRoles;
  final List<PlatformRole> realizedRoles;
  final List<PlatformRole> pendingRoles;
  final List<String> orphans;
  final double integrityScore;

  DomainAuditResult({
    required this.totalRoles,
    required this.realizedRoles,
    required this.pendingRoles,
    required this.orphans,
    required this.integrityScore,
  });

  List<PlatformRole> get realized => realizedRoles;
  List<PlatformRole> get pending => pendingRoles;

  @override
  String toString() {
    return 'Domain Integrity: ${integrityScore.toStringAsFixed(1)}% ($totalRoles roles, ${realized.length} realized, ${pending.length} pending)';
  }
}
