import 'package:primecare_ui/primecare_ui.dart';

void main() async {
  print('--- Platform Governance Blueprint Audit ---');

  // Initialize registries
  GovernanceBootstrapper.bootstrap();

  final blueprints = BlueprintRegistry.getAll();
  print('Blueprints Registered: ${blueprints.length}');

  // Perform audit
  final auditResults = GovernanceRegistry.performBlueprintAudit();
  print('Audit Results Found: ${auditResults.length}');

  bool overallCompliant = true;

  for (final result in auditResults) {
    final status = result.isCompliant ? 'PASS' : 'FAIL';
    print('\n[ $status ] Route: ${result.route}');

    if (!result.isCompliant) {
      overallCompliant = false;
      print('  Missing Components: ${result.missingLabels.join(", ")}');
    } else {
      print('  Compliance confirmed against Auditor Blueprint.');
    }
  }

  if (auditResults.isEmpty) {
    print(
      '\n[ WARNING ] No audit results generated. Check if routes in blueprints match registered intents.',
    );
  } else if (overallCompliant) {
    print('\n[ SUCCESS ] All structural integrity checks passed.');
  } else {
    print('\n[ FAILURE ] Blueprint mismatch detected in dashboard hydration.');
  }
}
