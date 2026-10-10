import 'platform_role.dart';

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
