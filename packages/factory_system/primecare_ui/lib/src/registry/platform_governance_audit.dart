// Layer: 01_INFRASTRUCTURE
import 'package:flutter_core/flutter_core.dart';

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
    final List<String> orphans = [];

    // 2. Map realized vs pending
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

    // 3. Detect Orphans (Intents registered without a primary PlatformRole mapping)
    final allIntents = GovernanceRegistry.getAllIntents();
    for (final intent in allIntents) {
      bool found = false;
      for (final role in inventory) {
        if (GovernanceRegistry.getIntentByRole(role) == intent) {
          found = true;
          break;
        }
      }
      if (!found) {
        orphans.add(intent.route);
      }
    }

    final double score = inventory.isEmpty
        ? 0.0
        : (realized.length / inventory.length) * 100;
    final blueprintAudit = GovernanceRegistry.performBlueprintAudit();

    return GovernanceAuditResult(
      totalRoles: inventory.length,
      realizedRoles: realized,
      pendingRoles: pending,
      integrityScore: score.toDouble(),
      healthReports: healthReports,
      blueprintAudit: blueprintAudit,
      orphans: orphans,
    );
  }

  /// Sourced directly from the PlatformRole source-of-truth.
  static List<String> _getDomainUniverse() {
    return PlatformRole.values
        .where(
          (PlatformRole r) =>
              r != PlatformRole.unknown && r != PlatformRole.system,
        )
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
  final List<String> orphans;

  GovernanceAuditResult({
    required this.totalRoles,
    required this.realizedRoles,
    required this.pendingRoles,
    required this.integrityScore,
    required this.healthReports,
    required this.blueprintAudit,
    this.orphans = const [],
  });

  @override
  String toString() {
    final blueprintSummary = blueprintAudit.isEmpty
        ? 'No Blueprint Audits performed.'
        : 'Blueprint Compliance: ${blueprintAudit.where((b) => b.isCompliant).length} / ${blueprintAudit.length} compliant';

    final orphanSummary = orphans.isEmpty
        ? 'No orphaned intents.'
        : 'ORPHANED INTENTS: ${orphans.join(', ')}';

    return 'PrimeCare Platform Integrity Score: ${integrityScore.toStringAsFixed(1)}%\n'
        'Realized: ${realizedRoles.length} / $totalRoles roles\n'
        'Pending: ${pendingRoles.length} roles\n'
        '$blueprintSummary\n'
        '$orphanSummary';
  }
}

/// Periodic Audit provider for UI-level visualization.
final platformGovernanceAuditProvider = Provider<GovernanceAuditResult>((ref) {
  // We re-run the audit whenever the registry might have changed or on a timer
  return PlatformGovernanceAudit.performAudit(ref);
});
