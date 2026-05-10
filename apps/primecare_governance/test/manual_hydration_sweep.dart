import 'dart:io';
import 'package:primecare_governance/governance/services/ast_patch_engine.dart';
import 'package:primecare_governance/governance/services/registry_hydration_service.dart';

void main() async {
  print('--- REGISTRY HYDRATION SWEEP TEST ---');
  
  // 1. Setup paths
  final projectRoot = Directory.current.path;
  print('Project Root: $projectRoot');

  // 2. Initialize engines
  final astEngine = ASTPatchEngine(projectRoot);
  final hydrationService = RegistryHydrationService(
    astEngine: astEngine,
    projectRoot: projectRoot,
  );

  // 3. Perform sweep
  print('Starting hydration sweep...');
  final results = await hydrationService.performHydrationSweep();

  // 4. Output results
  print('\nSweep Results:');
  print('Total Screens Processed: ${results['total']}');
  print('Successfully Hydrated: ${results['hydrated']}');
  print('Failed/Skipped: ${results['failed']}');
  
  if ((results['details'] as Map).isNotEmpty) {
    print('\nDetails:');
    (results['details'] as Map).forEach((id, reason) {
      print('- $id: $reason');
    });
  }
  
  print('\n--- TEST COMPLETE ---');
}
