import 'dart:io';

void main() {
  final projectRoot = Directory.current.path;
  final featuresRoot = projectRoot.endsWith('primecare_ui')
      ? '$projectRoot/lib/src/features'
      : '$projectRoot/packages/factory_system/primecare_ui/lib/src/features';
  final bootstrapperFile = projectRoot.endsWith('primecare_ui')
      ? '$projectRoot/lib/src/registry/governance_bootstrapper.dart'
      : '$projectRoot/packages/factory_system/primecare_ui/lib/src/registry/governance_bootstrapper.dart';

  final intentFiles = Directory(featuresRoot)
      .listSync(recursive: true)
      .where((f) => f.path.endsWith('_intent.dart'))
      .toList();

  final intents = <String>[];
  for (final file in intentFiles) {
    final content = File(file.path).readAsStringSync();
    final match = RegExp(
      r'class (\w+) extends (AppScreenIntent|PrimeCareScreen)',
    ).firstMatch(content);
    if (match != null) {
      intents.add(match.group(1)!);
    }
  }

  print('Found ${intents.length} intents.');

  final buffer = StringBuffer();
  buffer.writeln('// Layer: 02_I_GOVERNANCE_BOOTSTRAPPER');
  buffer.writeln("import 'package:flutter_core/flutter_core.dart';");
  buffer.writeln("import '../features/features_manifest.dart';");
  buffer.writeln('');
  buffer.writeln('class GovernanceBootstrapper {');
  buffer.writeln('  static void bootstrap() {');
  for (final intent in intents) {
    buffer.writeln('    GovernanceRegistry.register(const $intent());');
  }
  buffer.writeln('  }');
  buffer.writeln('}');

  File(bootstrapperFile).writeAsStringSync(buffer.toString());
  print('Bootstrapper updated.');
}
