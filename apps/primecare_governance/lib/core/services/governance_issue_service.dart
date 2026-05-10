import 'package:flutter_core/flutter_core.dart';
import 'audit_service.dart';

class GovernanceIssueService {
  final AuditService _auditService;

  GovernanceIssueService(this._auditService);

  /// Flags a screen for architectural review.
  /// This persists the issue to the local audit log for synchronization.
  Future<void> flagForReview({
    required String screenId,
    required String screenTitle,
    required String reason,
    AuditSeverity severity = AuditSeverity.medium,
    GovernanceCategory category = GovernanceCategory.compliance,
  }) async {
    final details = {
      'screenId': screenId,
      'screenTitle': screenTitle,
      'reason': reason,
      'severity': severity.name,
      'category': category.name,
      'flaggedAt': DateTime.now().toIso8601String(),
    }.toString();

    await _auditService.logAction('GOVERNANCE_FLAG', details);
  }

  /// In a real implementation, this would fetch from a dedicated table.
  /// For this iteration, we use the audit log as the persistent store.
  Future<void> resolveIssue(int flagId) async {
    await _auditService.logAction(
      'GOVERNANCE_RESOLVE',
      'Resolved flag ID: $flagId',
    );
  }
}

final governanceIssueServiceProvider = Provider((ref) {
  final auditService = ref.watch(auditServiceProvider);
  return GovernanceIssueService(auditService);
});
