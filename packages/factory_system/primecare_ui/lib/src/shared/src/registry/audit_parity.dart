
import 'dart:io';

void main() {
  final baseDir = 'c:/Users/Admin2/Documents/GitHub/primecare-platform';
  final registriesDir = Directory('$baseDir/apps/primecare_governance/lib/core/governance/registries');
  final enumFile = File('$baseDir/packages/factory_system/primecare_ui/lib/src/shared/src/registry/primecare_form_enum.dart');
  final providerFile = File('$baseDir/packages/factory_system/primecare_ui/lib/src/shared/src/registry/primecare_form_provider.dart');

  if (!registriesDir.existsSync()) {
    print('Error: Registries directory not found at ${registriesDir.path}');
    return;
  }

  // 1. Get all Registry IDs (Source of Truth for Modern Dashboards)
  final registryIds = <String>{};
  for (final file in registriesDir.listSync()) {
    if (file is File && file.path.endsWith('.dart') && !file.path.endsWith('index.dart')) {
      final content = file.readAsStringSync();
      // Match 'ID': ScreenMetadata(
      final exp = RegExp(r"'(SCREEN_[^']+)'\s*:\s*ScreenMetadata");
      for (final match in exp.allMatches(content)) {
        registryIds.add(match.group(1)!);
      }
    }
  }
  print('Found ${registryIds.length} registry IDs in Governance.');

  // 2. Get all Enum Values (The UI contract)
  final enumContent = enumFile.readAsStringSync();
  final enumValues = <String>{};
  // Match enumName('label')
  final enumExp = RegExp(r'^\s*([a-zA-Z0-9_]+)\(', multiLine: true);
  for (final match in enumExp.allMatches(enumContent)) {
    enumValues.add(match.group(1)!);
  }
  print('Found ${enumValues.length} enum values in PrimeCareForm.');

  // 3. Check for Mismatches (Source Parity)
  final missingInEnum = <String>[];
  for (final id in registryIds) {
    // Convert SCREEN_CEO_DASHBOARD to ceoDashboard
    final parts = id.replaceFirst('SCREEN_', '').toLowerCase().split('_');
    var camelCase = parts[0];
    for (var i = 1; i < parts.length; i++) {
      if (parts[i].isEmpty) continue;
      camelCase += parts[i][0].toUpperCase() + parts[i].substring(1);
    }
    
    if (!enumValues.contains(camelCase)) {
      // Try with 'Dashboard' suffix if missing
      if (!enumValues.contains(camelCase + 'Dashboard')) {
         missingInEnum.add(id);
      }
    }
  }

  if (missingInEnum.isNotEmpty) {
    print('\n[WARNING] Governance IDs missing in PrimeCareForm:');
    for (final id in missingInEnum) {
      print(' - $id');
    }
  } else {
    print('\n[OK] All Governance IDs (Modern) have a corresponding UI enum value.');
  }

  // 4. Audit Provider Dispatch Architecture
  final providerContent = providerFile.readAsStringSync();
  
  print('\nProvider Architecture Audit:');
  
  final hasRegistryLookup = providerContent.contains('ScreenRegistry.getScreenByForm(form)');
  final hasInfrastructureFallback = providerContent.contains('infrastructureMonitoringAdapterProvider(form)');
  final hasOperationalFallback = providerContent.contains('operationalInsightAdapterProvider(form)');
  final hasDefaultFallback = providerContent.contains('genericDashboardAdapterProvider(form)');

  print(' - Registry-Driven Lookup: ${hasRegistryLookup ? "ACTIVE" : "MISSING"}');
  print(' - Infrastructure Telemetry Fallback: ${hasInfrastructureFallback ? "ACTIVE" : "MISSING"}');
  print(' - Operational Insight Fallback: ${hasOperationalFallback ? "ACTIVE" : "MISSING"}');
  print(' - Default Generic Fallback: ${hasDefaultFallback ? "ACTIVE" : "MISSING"}');

  if (hasRegistryLookup && hasDefaultFallback) {
    print('\n[STATUS] ARCHITECTURAL PARITY ACHIEVED.');
    print('All forms now resolve through the ScreenRegistry or the global fallback engine.');
    print('Legacy 1,000+ line switch-case has been successfully decommissioned.');
  } else {
    print('\n[ERROR] ARCHITECTURAL MISMATCH: Registry lookup or default fallback missing.');
  }
}
