import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_ui/src/governance_bootstrapper.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_governance/core/governance/screen_registry.dart' as metadata_registry;

void main() {
  test('Detailed Governance Audit Report', () {
    GovernanceBootstrapper.bootstrap();
    
    // Aggregate all screens for audit
    final intents = GovernanceRegistry.getAllIntents();
    final metadataScreens = metadata_registry.ScreenRegistry.getAllScreens();
    
    PrimeLogger.info('\n--- DETAILED AUDIT REPORT ---\n');
    
    int looseTextCount = 0;
    int missingHudCount = 0;
    int missingAdapterCount = 0;
    
    // 1. Audit Registered Intents
    for (final intent in intents) {
      bool hasIssue = false;
      String issues = '';
      
      // I18n Check
      if (intent.title.contains(' ') && !intent.title.contains('.')) {
        looseTextCount++;
        hasIssue = true;
        issues += '[Hardcoded: "${intent.title}"] ';
      }
      
      // Telemetry Check
      if (!intent.componentLabels.any((l) => l.contains('Aura HUD'))) {
        missingHudCount++;
        hasIssue = true;
        issues += '[Missing HUD] ';
      }
      
      // Adapter Check
      if (intent.provider == null) {
        missingAdapterCount++;
        hasIssue = true;
        issues += '[Orphaned Adapter] ';
      }
      
      if (hasIssue) {
        PrimeLogger.warning('FAILED (Intent): [${intent.route}] $issues');
      }
    }

    // 2. Audit Metadata Screens (The 251 screens)
    for (final screen in metadataScreens) {
      // Avoid double auditing if already registered as intent
      if (intents.any((i) => i.route == screen.routePath)) continue;

      bool hasIssue = false;
      String issues = '';

      // I18n Check
      if (screen.title.contains(' ') && !screen.title.contains('.')) {
        looseTextCount++;
        hasIssue = true;
        issues += '[Hardcoded: "${screen.title}"] ';
      }

      // Telemetry Check
      if (!screen.pendingComponents.any((l) => l.contains('Aura HUD'))) {
        missingHudCount++;
        hasIssue = true;
        issues += '[Missing HUD] ';
      }

      // Adapter Check (Metadata screens by definition lack an adapter in the registry)
      missingAdapterCount++;
      hasIssue = true;
      issues += '[Orphaned Adapter] ';

      if (hasIssue) {
        PrimeLogger.warning('FAILED (Metadata): [${screen.routePath}] $issues');
      }
    }
    
    final totalUniqueScreens = intents.length + metadataScreens.where((s) => !intents.any((i) => i.route == s.routePath)).length;

    PrimeLogger.info('\n--- SUMMARY ---');
    PrimeLogger.info('Total Unique Screens: $totalUniqueScreens');
    PrimeLogger.info('Hardcoded Strings: $looseTextCount');
    PrimeLogger.info('Missing HUDs: $missingHudCount');
    PrimeLogger.info('Orphaned Adapters: $missingAdapterCount');
    PrimeLogger.info('--- END REPORT ---\n');
  });
}
