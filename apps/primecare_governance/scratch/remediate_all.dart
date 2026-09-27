// Governance - Category: service | Purpose: Core implementation file for the Remediate All platform logic.
import 'package:primecare_governance/governance/services/ast_patch_engine.dart';
import 'package:primecare_governance/governance/services/cross_subsystem_auditor.dart';

void main() async {
  print('--- Starting Full Cross-Subsystem Remediation ---');
  final auditor = CrossSubsystemAuditor(projectRoot: '../..');
  final engine = ASTPatchEngine('../..');

  print('Step 1: Running Audit...');
  final formIssues = await auditor.auditFormProviderParity();
  final screenIssues = await auditor.auditScreenRegistryParity();

  final allIssues = [...formIssues, ...screenIssues];
  final remediableIssues = allIssues.where((i) => i.autoRemediable).toList();

  if (remediableIssues.isEmpty) {
    print('✅ No remediable issues found.');
    return;
  }

  print(
    'Step 2: Found ${remediableIssues.length} remediable issues. Applying batch remediation...',
  );
  int fixCount = 0;

  // Group by target file
  final fileToCases =
      <String, List<({String enumValue, String returnValue})>>{};

  for (final issue in remediableIssues) {
    if (issue.metadata['type'] == 'missing_form_provider') {
      final targetPath = issue.metadata['targetPath'] as String;
      final formName = issue.metadata['form'] as String;

      fileToCases.putIfAbsent(targetPath, () => []);
      fileToCases[targetPath]!.add((
        enumValue: 'PrimeCareForm.$formName',
        returnValue: 'genericDashboardAdapterProvider(form)',
      ));
    }
  }

  for (final entry in fileToCases.entries) {
    print('Remediating ${entry.key} (${entry.value.length} cases)...');
    final success = await engine.batchInjectSwitchCases(
      entry.value,
      filePath: entry.key,
      variableName: 'primecareFormProvider',
    );
    if (success) fixCount += entry.value.length;
  }

  // Handle Screen Registrations
  for (final issue in remediableIssues) {
    if (issue.metadata['type'] == 'missing_screen_registration') {
      final route = issue.metadata['route'] as String;
      final components = (issue.metadata['requiredComponents'] as List?)
          ?.cast<String>();

      final safeName = route
          .replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_')
          .replaceAll(RegExp(r'^_+|_+$'), '')
          .toLowerCase();
      final constantName = 'screen_$safeName';
      final screenId = 'RECOVERED_${safeName.toUpperCase()}';

      print('Injecting missing screen: $route as $constantName...');
      await engine.injectScreenConstant(
        registryPath:
            'apps/primecare_governance/lib/core/governance/screen_registry.dart',
        className: 'ScreenRegistry',
        screenId: screenId,
        overwrite: true,
        metadata: {
          'id': screenId,
          'featureName': 'Recovered ${safeName.toUpperCase()}',
          'routePath': route,
          'allowedRoles': ['Admin'],
          'title': 'Recovered ${safeName.toUpperCase()}',
          'implementedComponents': components ?? [],
          'lifecycleStatus': 'LifecycleStatus.backlog',
        },
      );
      fixCount++;
    } else if (issue.metadata['type'] == 'untracked_registration') {
      final screenId = issue.metadata['screenId'] as String;
      print('Flagging untracked screen as legacy: $screenId...');
      await engine.updateRegistryMetadata(screenId, {
        'lifecycleStatus': 'LifecycleStatus.legacy',
      });
      fixCount++;
    } else if (issue.metadata['type'] == 'structural_drift') {
      final screenId = issue.metadata['screenId'] as String;
      final route = (issue.metadata['route'] ?? '') as String;
      final missing =
          (issue.metadata['missing'] as List?)?.cast<String>() ?? [];

      print('Remediating structural drift in $screenId...');
      await engine.injectScreenConstant(
        registryPath: 'lib/core/governance/screen_registry.dart',
        className: 'ScreenRegistry',
        screenId: screenId,
        overwrite: true,
        metadata: {
          'id': screenId,
          'featureName': 'Recovered ${screenId.replaceAll('RECOVERED_', '')}',
          'routePath': route,
          'allowedRoles': ['Admin'],
          'title': 'Recovered ${screenId.replaceAll('RECOVERED_', '')}',
          'implementedComponents': missing,
          'lifecycleStatus': 'LifecycleStatus.backlog',
        },
      );
      fixCount++;
    }
  }

  if (fixCount > 0) {
    print('✅ Successfully applied $fixCount remediations.');
  } else {
    print('❌ Failed to apply remediations.');
  }

  print('Step 3: Verifying remediation...');
  final finalFormAudit = await auditor.auditFormProviderParity();
  final finalScreenAudit = await auditor.auditScreenRegistryParity();

  final remainingForm = finalFormAudit
      .where(
        (i) =>
            i.autoRemediable && i.metadata['type'] == 'missing_form_provider',
      )
      .length;
  final remainingScreen = finalScreenAudit
      .where(
        (i) =>
            i.autoRemediable &&
            i.metadata['type'] == 'missing_screen_registration',
      )
      .length;

  if (remainingForm == 0 && remainingScreen == 0) {
    print(
      '🏁 ZERO-DRIFT ACHIEVED! All registries are synchronized with the Governance Blueprint.',
    );
  } else {
    print(
      '⚠️ Remediation partial. Forms: $remainingForm, Screens: $remainingScreen remaining.',
    );
  }

  print('--- Remediation Process Complete ---');
}
