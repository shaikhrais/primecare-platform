// Layer: 01_INFRASTRUCTURE
import 'package:flutter_core/00_B_flutter_core.dart';
import '02_I_governance_bootstrapper.dart';

/// Programmatic Audit engine for the PrimeCare Platform.
/// This class enables "Knowing Everything" by cross-referencing
/// the Domain Inventory with the Governance Registry.
class PlatformGovernanceAudit {
  /// Generates a comprehensive summary of unimplemented components.
  static GovernanceAuditResult performAudit(dynamic ref) {
    // 1. Initialize Registry
    GovernanceBootstrapper.bootstrap();

    final inventory = _getDomainUniverse();
    final List<String> realized = [];
    final List<String> pending = [];
    final Map<String, GovernanceHealth> healthReports = {};

    for (final role in inventory) {
      final intent = GovernanceRegistry.getIntentByRole(role);
      if (intent != null) {
        realized.add(role);
        // Deep Health Check
        healthReports[role] = intent.verifyReady(ref);
      } else {
        pending.add(role);
      }
    }

    final score = (realized.length / inventory.length) * 100;

    final blueprintAudit = GovernanceRegistry.performBlueprintAudit();

    return GovernanceAuditResult(
      totalRoles: inventory.length,
      realizedRoles: realized,
      pendingRoles: pending,
      integrityScore: score,
      healthReports: healthReports,
      blueprintAudit: blueprintAudit,
    );
  }

  /// Sourced directly from the PlatformRole source-of-truth.
  static List<String> _getDomainUniverse() {
    return PlatformRole.values
        .where((PlatformRole r) => r != PlatformRole.unknown && r != PlatformRole.system)
        .map((PlatformRole r) => r.nameSnake)
        .toList();
  }
}

/// Data container for audit results.
class GovernanceAuditResult {
  final int totalRoles;
  final List<String> realizedRoles;
  final List<String> pendingRoles;
  final double integrityScore;
  final Map<String, GovernanceHealth> healthReports;
  final List<BlueprintCompliance> blueprintAudit;

  GovernanceAuditResult({
    required this.totalRoles,
    required this.realizedRoles,
    required this.pendingRoles,
    required this.integrityScore,
    required this.healthReports,
    required this.blueprintAudit,
  });

  @override
  String toString() {
    final blueprintSummary = blueprintAudit.isEmpty 
        ? 'No Blueprint Audits performed.'
        : 'Blueprint Compliance: ${blueprintAudit.where((b) => b.isCompliant).length} / ${blueprintAudit.length} compliant';

    return 'PrimeCare Platform Integrity Score: ${integrityScore.toStringAsFixed(1)}%\n'
        'Realized: ${realizedRoles.length} / $totalRoles roles\n'
        'Pending: ${pendingRoles.length} roles\n'
        '$blueprintSummary';
  }
}
