// Governance - Category: service | Purpose: Core implementation file for the Governance Remediation Engine platform logic.
import 'ast_patch_engine.dart';
import 'registry_integrity_service.dart';
import 'cross_subsystem_auditor.dart';
import 'package:flutter_core/flutter_core.dart';
import '../../core/governance/governance_provider.dart';

class RemediationResult {
  final int issuesDetected;
  final int issuesResolved;
  final List<String> resolutionLogs;

  RemediationResult({
    required this.issuesDetected,
    required this.issuesResolved,
    this.resolutionLogs = const [],
  });
}

class GovernanceRemediationEngine {
  final Ref? ref;
  final ASTPatchEngine _patchEngine;
  final String projectRoot;

  GovernanceRemediationEngine(this.ref, {this.projectRoot = '.'})
    : _patchEngine = ASTPatchEngine(projectRoot);

  /// Performs a platform-wide scan and automated remediation of all registries.
  Future<RemediationResult> executeGlobalRemediation({Map<String, ScreenMetadata>? screens}) async {
    final state = ref?.read(governanceProvider);
    final allScreens = screens ?? state?.allScreens ?? <String, ScreenMetadata>{};

    int resolvedCount = 0;
    final logs = <String>[];

    // 1. Core Registry Integrity Scan
    final issues = RegistryIntegrityService.inspect(allScreens);
    logs.add('Core Scan: ${issues.length} issues detected.');

    // Identity, routes and estimates require authoritative reconciliation.
    // Changing declarations does not implement a missing screen or capability.
    for (final issue in issues) {
      logs.add('[PENDING] ${issue.screenId}: ${issue.issue} ${issue.suggestion}');
    }

    // 2. Cross-Subsystem Parity Scan
    final crossSubsystemCount = await _remediateCrossSubsystemDrift(logs);
    resolvedCount += crossSubsystemCount.issuesResolved;

    // 3. Network Security Scan
    final securityCount = await _remediateSecurityDrift(logs);
    resolvedCount += securityCount.issuesResolved;

    // 4. Localization Parity Scan
    final localizationCount = await _remediateLocalizationDrift(logs, allScreens);
    resolvedCount += localizationCount.issuesResolved;

    return RemediationResult(
      issuesDetected:
          issues.length +
          crossSubsystemCount.issuesDetected +
          securityCount.issuesDetected +
          localizationCount.issuesDetected,
      issuesResolved: resolvedCount,
      resolutionLogs: logs,
    );
  }

  Future<RemediationResult> _remediateCrossSubsystemDrift(List<String> logs) async {
    final auditor = CrossSubsystemAuditor(projectRoot: projectRoot);
    final issues = [
      ...await auditor.auditFormProviderParity(),
      ...await auditor.auditScreenRegistryParity(),
    ];
    for (final issue in issues) {
      logs.add('[PENDING] Cross-Subsystem: ${issue.issue} ${issue.suggestion}');
    }
    return RemediationResult(issuesDetected: issues.length, issuesResolved: 0);
  }

  Future<RemediationResult> _remediateSecurityDrift(List<String> logs) async {
    int count = 0;
    final auditor = CrossSubsystemAuditor(projectRoot: projectRoot);
    final securityIssues = await auditor.auditNetworkSecurity();
    final bankGradeIssues = await auditor.auditBankGradeSecurityCompliance();

    final allIssues = [...securityIssues, ...bankGradeIssues];

    for (final issue in allIssues) {
      if (issue.autoRemediable) {
        bool success = false;

        if (issue.metadata['type'] == 'missing_security_header') {
          final header = issue.metadata['header'] as String;
          final value = issue.metadata['value'] as String;
          final isRaw = issue.metadata['isRaw'] as bool? ?? false;
          final targetPath = issue.metadata['targetPath'] as String;

          success = await _patchEngine.injectHeader(
            header,
            value,
            filePath: targetPath,
            isRaw: isRaw,
          );
        } else if (issue.metadata['type'] == 'missing_security_interceptor') {
          final targetPath = issue.metadata['targetPath'] as String;
          final interceptor = issue.metadata['interceptor'] as String;

          success = await _patchEngine.injectIntoConstructor(
            filePath: targetPath,
            className: 'ApiClient',
            codeLine: '_dio.interceptors.add($interceptor);',
          );
        } else if (issue.metadata['type'] == 'missing_bootstrap_security') {
          final targetPath = issue.metadata['targetPath'] as String;
          final call = issue.metadata['call'] as String;

          success = await _patchEngine.injectIntoFunction(
            filePath: targetPath,
            functionName: 'main',
            codeLine: call,
          );
        }

        if (success) {
          count++;
          logs.add('[RESOLVED] Security Compliance: ${issue.issue}');
        }
      }
    }
    return RemediationResult(issuesDetected: allIssues.length, issuesResolved: count);
  }

  Future<RemediationResult> _remediateLocalizationDrift(
    List<String> logs,
    Map<String, ScreenMetadata> allScreens,
  ) async {
    final auditor = CrossSubsystemAuditor(projectRoot: projectRoot);
    final issues = [
      ...await auditor.auditTranslationParity(allScreens),
      ...await auditor.auditArticleCompliance(allScreens),
      ...await auditor.auditFeatureVerification(allScreens),
    ];
    for (final issue in issues) {
      logs.add('[PENDING] Verification: ${issue.issue} ${issue.suggestion}');
    }
    return RemediationResult(issuesDetected: issues.length, issuesResolved: 0);
  }

  /// Public entry point for cross-subsystem drift remediation.
  Future<int> remediateDrift() async {
    final logs = <String>[];
    int total = 0;
    
    total += (await _remediateCrossSubsystemDrift(logs)).issuesResolved;
    total += (await _remediateSecurityDrift(logs)).issuesResolved;
    
    // Localization requires all screens
    final allScreens = PlatformScreenRegistry.screens;
    total += (await _remediateLocalizationDrift(logs, allScreens)).issuesResolved;
    
    // Print logs to console for traceability
    for (final log in logs) {
      PrimeLogger.info(log, tag: 'RemediationEngine');
    }
    
    return total;
  }


}

final governanceRemediationEngineProvider = Provider(
  (ref) => GovernanceRemediationEngine(ref, projectRoot: '../../'),
);
