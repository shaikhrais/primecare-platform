// Governance - Category: test | Purpose: 1. Setup paths 2. Initialize engines 3. Perform sweep 4. Output results
import 'dart:io';
import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_governance/governance/services/ast_patch_engine.dart';
import 'package:primecare_governance/governance/services/registry_hydration_service.dart';

void main() async {
  PrimeLogger.info('--- REGISTRY HYDRATION SWEEP TEST ---');
  
  // 1. Setup paths
  final projectRoot = Directory.current.path;
  PrimeLogger.info('Project Root: $projectRoot');

  // 2. Initialize engines
  final astEngine = ASTPatchEngine(projectRoot);
  final hydrationService = RegistryHydrationService(
    astEngine: astEngine,
    projectRoot: projectRoot,
  );

  // 3. Perform sweep
  PrimeLogger.info('Starting hydration sweep...');
  final results = await hydrationService.performHydrationSweep();

  // 4. Output results
  PrimeLogger.info('\nSweep Results:');
  PrimeLogger.info('Total Screens Processed: ${results['total']}');
  PrimeLogger.info('Successfully Hydrated: ${results['hydrated']}');
  PrimeLogger.info('Failed/Skipped: ${results['failed']}');
  
  if ((results['details'] as Map).isNotEmpty) {
    PrimeLogger.info('\nDetails:');
    (results['details'] as Map).forEach((id, reason) {
      PrimeLogger.info('- $id: $reason');
    });
  }
  
  PrimeLogger.info('\n--- TEST COMPLETE ---');
}
