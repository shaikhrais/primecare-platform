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
  Future<RemediationResult> executeGlobalRemediation() async {
    final state = ref?.read(governanceProvider);
    final allScreens = state?.allScreens ?? <String, ScreenMetadata>{};

    int resolvedCount = 0;
    final logs = <String>[];

    // 1. Core Registry Integrity Scan
    final issues = RegistryIntegrityService.inspect(allScreens);
    logs.add('Core Scan: ${issues.length} issues detected.');

    for (final issue in issues) {
      bool success = false;

      final screenId = issue.metadata['screenId'] as String? ?? '';

      switch (issue.issue) {
        case String msg when msg.contains('does not match metadata ID'):
          success = await _fixIdMismatch(issue, screenId);
          break;
        case String msg when msg.contains('Duplicate route path detected'):
          success = await _fixDuplicateRoute(issue, screenId);
          break;
        case String msg when msg.contains('0 story points'):
          success = await _fixZeroWeight(issue, screenId);
          break;
      }

      if (success) {
        resolvedCount++;
        logs.add('[RESOLVED] $screenId: ${issue.issue}');
      }
    }

    // 2. Cross-Subsystem Parity Scan
    final crossSubsystemCount = await _remediateCrossSubsystemDrift(logs);
    resolvedCount += crossSubsystemCount;

    // 3. Network Security Scan
    final securityCount = await _remediateSecurityDrift(logs);
    resolvedCount += securityCount;

    // 4. Localization Parity Scan
    final localizationCount = await _remediateLocalizationDrift(logs, allScreens);
    resolvedCount += localizationCount;

    return RemediationResult(
      issuesDetected:
          issues.length +
          crossSubsystemCount +
          securityCount +
          localizationCount,
      issuesResolved: resolvedCount,
      resolutionLogs: logs,
    );
  }

  Future<bool> _fixIdMismatch(PlatformAuditIssue issue, String screenId) async {
    return await _patchEngine.updateRegistryMetadata(
      screenId,
      {'id': screenId},
      registryPath:
          _getRegistryPathForScreen(screenId),
    );
  }

  Future<bool> _fixDuplicateRoute(PlatformAuditIssue issue, String screenId) async {
    final routePath = issue.metadata['routePath'] as String? ?? '';
    final newRoute =
        '${routePath}_alt_${screenId.hashCode.toString().substring(0, 4)}';
    final registryPath = _getRegistryPathForScreen(screenId);

    return await _patchEngine.updateRegistryMetadata(screenId, {
      'routePath': newRoute,
    }, registryPath: registryPath);
  }

  Future<bool> _fixZeroWeight(PlatformAuditIssue issue, String screenId) async {
    return await _patchEngine.updateScreenMetadata(
      screenId,
      storyPoints: 1,
    );
  }

  Future<int> _remediateCrossSubsystemDrift(List<String> logs) async {
    int count = 0;
    final auditor = CrossSubsystemAuditor(projectRoot: projectRoot);
    final formIssues = await auditor.auditFormProviderParity();
    final screenIssues = await auditor.auditScreenRegistryParity();

    final subsystemIssues = [...formIssues, ...screenIssues];

    for (final issue in subsystemIssues) {
      if (issue.autoRemediable) {
        if (issue.metadata['type'] == 'missing_form_provider') {
          final formName = issue.metadata['form'] as String;
          final targetPath = issue.metadata['targetPath'] as String;

          final success = await _patchEngine.injectSwitchCase(
            'PrimeCareForm.$formName',
            'ref.watch(genericDashboardAdapterProvider(form))',
            filePath: targetPath,
            variableName: 'primecareFormProvider',
          );
          if (success) {
            count++;
            logs.add(
              '[RESOLVED] Cross-Subsystem: Fixed missing form provider for $formName',
            );
          }
        } else if (issue.metadata['type'] == 'missing_registration') {
          final screenId = issue.metadata['screenId'] as String;
          final mapping = issue.metadata['mapping'] as String;

          final success = await _patchEngine.injectScreenConstant(
            registryPath:
                'apps/primecare_governance/lib/core/governance/registries/core_governance_registry.dart',
            className: 'Registry',
            screenId: screenId,
            metadata: {
              'id': screenId,
              'title': "Autogenerated $screenId",
              'routePath': '/${screenId.toLowerCase()}',
              'featureName': "Governance",
              'allowedRoles': ['Staff', 'ClinicalDirector'],
              'lifecycleStatus': 'LifecycleStatus.backlog',
              'storyPoints': 3,
              'designSize': 'const PlatformSize(3840, 2160)',
            },
          );
          if (success) {
            count++;
            logs.add(
              '[RESOLVED] Cross-Subsystem: Injected missing registry entry for $mapping',
            );
          }
        } else if (issue.metadata['type'] == 'structural_drift') {
          final screenId = issue.metadata['screenId'] as String;
          final missing = List<String>.from(issue.metadata['missing'] as List);

          final registryPath = _getRegistryPathForScreen(screenId);
          final success = await _patchEngine.updateRegistryMetadata(screenId, {
            'implementedComponents':
                "[...implementedComponents, ${missing.map((c) => "'$c'").join(', ')}]",
          }, registryPath: registryPath);
          if (success) {
            count++;
            logs.add(
              '[RESOLVED] Cross-Subsystem: Fixed structural drift (added $missing) for $screenId',
            );
          }
        } else if (issue.metadata['type'] == 'design_standard_violation') {
          final screenId = issue.metadata['screenId'] as String;
          final field = issue.metadata['field'] as String;
          final value = issue.metadata['value'] as String;

          final registryPath = _getRegistryPathForScreen(screenId);
          final success = await _patchEngine.updateRegistryMetadata(screenId, {
            field: value,
          }, registryPath: registryPath);
          if (success) {
            count++;
            logs.add(
              '[RESOLVED] Design Parity: Fixed $field for $screenId',
            );
          }
        }
      }
    }
    return count;
  }

  Future<int> _remediateSecurityDrift(List<String> logs) async {
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
    return count;
  }

  Future<int> _remediateLocalizationDrift(
    List<String> logs,
    Map<String, ScreenMetadata> allScreens,
  ) async {
    int count = 0;
    final auditor = CrossSubsystemAuditor(projectRoot: projectRoot);
    final l10nIssues = await auditor.auditTranslationParity(allScreens);
    final complianceIssues = await auditor.auditArticleCompliance(allScreens);
    final featureIssues = await auditor.auditFeatureVerification(allScreens);

    final allIssues = [...l10nIssues, ...complianceIssues, ...featureIssues];

    for (final issue in allIssues) {
      if (issue.autoRemediable) {
        final screenId = issue.metadata['screenId'] as String;
        final registryPath = _getRegistryPathForScreen(screenId);

        bool success = false;
        if (issue.metadata['type'] == 'l10n_flag_drift') {
          final hasAll = issue.metadata['hasAll'] as bool;
          success = await _patchEngine.updateRegistryMetadata(screenId, {
            'hasAllTranslations': hasAll.toString(),
          }, registryPath: registryPath);
        } else if (issue.metadata['type'] == 'compliance_drift') {
          final compliant = issue.metadata['compliant'] as bool;
          success = await _patchEngine.updateRegistryMetadata(screenId, {
            'isAuditCompliant': compliant.toString(),
          }, registryPath: registryPath);
        } else if (issue.metadata['type'] == 'feature_flag_drift') {
          final field = issue.metadata['field'] as String;
          final value = issue.metadata['value'] as bool;
          success = await _patchEngine.updateRegistryMetadata(screenId, {
            field: value.toString(),
          }, registryPath: registryPath);
        }

        if (success) {
          count++;
          logs.add('[RESOLVED] Compliance: ${issue.issue}');
        }
      } else {
        logs.add('[WARNING] Localization: ${issue.issue}');
      }
    }
    return count;
  }

  /// Public entry point for cross-subsystem drift remediation.
  Future<int> remediateDrift() async {
    final logs = <String>[];
    int total = 0;
    
    total += await _remediateCrossSubsystemDrift(logs);
    total += await _remediateSecurityDrift(logs);
    
    // Localization requires all screens
    final allScreens = PlatformScreenRegistry.screens;
    total += await _remediateLocalizationDrift(logs, allScreens);
    
    // Print logs to console for traceability
    for (final log in logs) {
      PrimeLogger.info(log, tag: 'RemediationEngine');
    }
    
    return total;
  }

  String _getRegistryPathForScreen(String screenId) {
    // Currently all metadata resides in the core governance registry.
    // In future versions, this can be split into feature-specific registries.
    return 'apps/primecare_governance/lib/core/governance/registries/core_governance_registry.dart';
  }
}

final governanceRemediationEngineProvider = Provider(
  (ref) => GovernanceRemediationEngine(ref, projectRoot: '../../'),
);
