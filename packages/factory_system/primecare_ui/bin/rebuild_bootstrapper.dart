import 'dart:io';

void main() {
  final projectRoot = Directory.current.path;
  final manifestPath = '$projectRoot/packages/factory_system/primecare_ui/lib/src/features/features_manifest.dart';
  final bootstrapperPath = '$projectRoot/packages/factory_system/primecare_ui/lib/src/registry/02_I_governance_bootstrapper.dart';

  if (!File(manifestPath).existsSync()) {
    print('Manifest not found');
    return;
  }

  final manifest = File(manifestPath).readAsStringSync();
  
  // Use a map to deduplicate and store role info
  // Key: ClassName, Value: RoleName
  final intentData = <String, String>{};

  final matches = RegExp(r"export '.*?/registry/.*?_intent\.dart';").allMatches(manifest);
  for (final m in matches) {
    final line = m.group(0)!;
    final parts = line.split('/');
    final fileName = parts.last.replaceAll('_intent.dart\';', '');
    
    String role = fileName;
    if (role.startsWith('04_I_')) {
      role = role.replaceFirst('04_I_', '');
    }
    role = role.replaceAll('_dashboard', '');
    
    final className = _toPascal(role) + 'DashboardIntent';
    intentData[className] = role;
  }

  final sortedClasses = intentData.keys.toList()..sort();

  final buffer = StringBuffer();
  buffer.writeln('// Layer: 02_I_GOVERNANCE_BOOTSTRAPPER');
  buffer.writeln('// AUTO-GENERATED - DO NOT EDIT');
  buffer.writeln('import \'package:flutter_core/00_B_flutter_core.dart\';');
  buffer.writeln('import \'../features/features_manifest.dart\';');
  buffer.writeln('');
  buffer.writeln('class GovernanceBootstrapper {');
  buffer.writeln('  static void bootstrap() {');
  
  for (final className in sortedClasses) {
    final role = intentData[className];
    buffer.writeln('    GovernanceRegistry.register(const $className(), role: \'$role\');');
  }
  
  buffer.writeln('  }');
  buffer.writeln('}');
  buffer.writeln('');

  File(bootstrapperPath).writeAsStringSync(buffer.toString());
  print('Bootstrapper updated with ${sortedClasses.length} unique intents.');
}

String _toPascal(String s) {
  final parts = s.split('_');
  return parts.map((p) => p[0].toUpperCase() + p.substring(1)).join('');
}
