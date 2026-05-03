
import 'dart:io';
import 'dart:convert';

void main() {
  final baseDir = '.';
  final registriesDir = Directory('$baseDir/apps/primecare_governance/lib/core/governance/registries');
  final enumFile = File('$baseDir/packages/factory_system/primecare_ui/lib/src/shared/src/registry/primecare_form_enum.dart');
  final providerFile = File('$baseDir/packages/factory_system/primecare_ui/lib/src/shared/src/registry/primecare_form_provider.dart');

  if (!registriesDir.existsSync()) {
    print('Error: Registries directory not found at ${registriesDir.path}');
    return;
  }

  // 1. Get all Registry IDs
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
  print('Found ${registryIds.length} registry IDs.');

  // 2. Get all Enum Values
  final enumContent = enumFile.readAsStringSync();
  final enumValues = <String>{};
  // Match enumName('label')
  final enumExp = RegExp(r'^\s*([a-zA-Z0-9_]+)\(', multiLine: true);
  for (final match in enumExp.allMatches(enumContent)) {
    enumValues.add(match.group(1)!);
  }
  print('Found ${enumValues.length} enum values.');

  // 3. Check for Mismatches
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
    print('\n[WARNING] IDs in Registry but missing in PrimeCareForm:');
    for (final id in missingInEnum) {
      print(' - $id');
    }
  } else {
    print('\n[OK] All registry IDs have a corresponding enum value.');
  }

  // 4. Audit Provider mappings
  final providerContent = providerFile.readAsStringSync();
  final specializedMappings = <String, String>{};
  final genericMappings = <String>{};
  
  final caseExp = RegExp(r'case PrimeCareForm\.([a-zA-Z0-9_]+):\s+return ([a-zA-Z0-9_]+)(\(form\))?;');
  for (final match in caseExp.allMatches(providerContent)) {
    final form = match.group(1)!;
    final adapter = match.group(2)!;
    if (adapter == 'genericDashboardAdapterProvider' || adapter == 'workflowAdapterProvider' || adapter == 'operationalInsightAdapterProvider' || adapter == 'infrastructureMonitoringAdapterProvider') {
      genericMappings.add(form);
    } else {
      specializedMappings[form] = adapter;
    }
  }

  print('\nProvider Audit:');
  print(' - Specialized Mappings: ${specializedMappings.length}');
  print(' - Generic/Fallback Mappings (explicit): ${genericMappings.length}');
  
  // Identify gaps: enum values not in provider
  final missingInProvider = <String>[];
  for (final val in enumValues) {
    if (!specializedMappings.containsKey(val) && !genericMappings.contains(val)) {
      missingInProvider.add(val);
    }
  }
  
  if (missingInProvider.isNotEmpty) {
    print('\n[WARNING] Enum values missing in primecareFormProvider switch:');
    for (final val in missingInProvider) {
      print(' - $val');
    }
  }
}
