import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/proposal_intake.dart';

class ComplianceCheckResult {
  final bool passed;
  final List<String> violations;
  final List<String> suggestions;
  final double riskScore; // 0.0 to 1.0

  ComplianceCheckResult({
    required this.passed,
    this.violations = const [],
    this.suggestions = const [],
    this.riskScore = 0.0,
  });
}

class ComplianceChecklistService {
  final Ref ref;

  ComplianceChecklistService(this.ref);

  /// Performs a deep compliance scan on a proposal.
  /// Checks for PHI, HIPAA, PHIPA, and platform-specific security policies.
  Future<ComplianceCheckResult> runDeepScan(ProposalIntake proposal) async {
    // Simulate deep analysis
    await Future.delayed(const Duration(milliseconds: 1800));

    final violations = <String>[];
    final suggestions = <String>[];
    double riskScore = 0.0;

    final description = proposal.description.toLowerCase();
    // final businessGoal = proposal.businessGoal.toLowerCase();

    // 1. PHI Detection
    final hasPhiKeywords = description.contains('patient') || 
                           description.contains('ssn') || 
                           description.contains('health card') ||
                           description.contains('medical record');
    
    if (hasPhiKeywords && !proposal.needsPhiData) {
      violations.add('PHI detected in description but "needsPhiData" is FALSE.');
      riskScore += 0.4;
    }

    // 2. Audit Log Enforcement
    if (hasPhiKeywords && !proposal.needsAuditLog) {
      violations.add('Audit Logging is MANDATORY for screens handling PHI.');
      riskScore += 0.3;
    }

    // 3. Role Access Policy
    final highPrivilegeRoles = ['admin', 'clinical_director', 'billing_admin'];
    final hasHighPrivilegeRole = proposal.allowedRoles.any((r) => highPrivilegeRoles.contains(r.toLowerCase()));
    
    if (hasHighPrivilegeRole && proposal.priority == 'p3') {
      suggestions.add('High-privilege role access requested for low-priority feature. Verify minimal access policy.');
    }

    // 4. Consent Requirements
    if (description.contains('tracking') || description.contains('monitor')) {
      if (!proposal.needsConsent) {
        violations.add('Patient Tracking detected. Explicit consent workflow is required.');
        riskScore += 0.2;
      }
    }

    // 5. Signature Requirements
    if (description.contains('prescription') || description.contains('medication')) {
      if (!proposal.needsSignature) {
        violations.add('Medication management requires Digital Signature (e-Prescribe standards).');
        riskScore += 0.3;
      }
    }

    return ComplianceCheckResult(
      passed: violations.isEmpty,
      violations: violations,
      suggestions: suggestions,
      riskScore: riskScore.clamp(0.0, 1.0),
    );
  }

  /// Generates a set of mandatory security protocols based on the proposal.
  List<String> getMandatoryProtocols(ProposalIntake proposal) {
    final protocols = <String>['Auth Token Validation', 'TLS 1.3 Encryption'];
    
    if (proposal.needsPhiData) {
      protocols.add('At-Rest Data Encryption (AES-256)');
      protocols.add('PHI Redaction (on export)');
      protocols.add('Granular Audit Logging');
    }

    if (proposal.needsSignature) {
      protocols.add('Biometric Re-Auth for Signature');
      protocols.add('Cryptographic Hash Verification');
    }

    return protocols;
  }
}

final complianceChecklistServiceProvider = Provider((ref) => ComplianceChecklistService(ref));
