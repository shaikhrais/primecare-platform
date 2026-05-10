import 'package:primecare_governance/governance/services/ast_patch_engine.dart';

void main() async {
  print('--- Starting Single-Issue Remediation ---');
  final engine = ASTPatchEngine('../..'); // Using workspace root

  final targetPath =
      'packages/primecare_ui/lib/src/shared/src/registry/primecare_form_provider.dart';
  final formName = 'platformMetrics_legacy';

  print('Injecting switch case for $formName...');
  final success = await engine.injectSwitchCase(
    'PrimeCareForm.$formName',
    'genericDashboardAdapterProvider(form)',
    filePath: targetPath,
    variableName: 'primecareFormProvider',
  );

  if (success) {
    print('✅ Successfully injected case.');
  } else {
    print('❌ Failed to inject case.');
  }
  print('--- Remediation Complete ---');
}
