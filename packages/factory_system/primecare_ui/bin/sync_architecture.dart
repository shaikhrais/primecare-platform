import 'dart:io';

void main() {
  final projectRoot = Directory.current.path;
  final baseDir = projectRoot.endsWith('primecare_ui')
      ? projectRoot
      : '$projectRoot/packages/factory_system/primecare_ui';

  final featuresDir = Directory('$baseDir/lib/src/features');
  final manifestFile = File('$baseDir/lib/src/features/features_manifest.dart');
  final bootstrapperFile = File(
    '$baseDir/lib/src/registry/02_I_governance_bootstrapper.dart',
  );

  if (!featuresDir.existsSync()) {
    print('Error: features directory not found at ${featuresDir.path}');
    return;
  }

  print('Syncing PrimeCare UI Architecture...');

  // 1. Collect all files for the manifest
  final allFiles = featuresDir
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) {
        final path = f.path;
        if (!path.endsWith('.dart') ||
            path.endsWith('features_manifest.dart') ||
            path.endsWith('.freezed.dart') ||
            path.endsWith('.g.dart') ||
            path.endsWith('.gr.dart') ||
            path.endsWith('.config.dart')) {
          return false;
        }

        // Only export UI-centric files
        return path.endsWith('_intent.dart') ||
            path.endsWith('_screen.dart') ||
            path.endsWith('_widgets.dart') ||
            path.endsWith('_widget.dart') ||
            path.endsWith('_layout.dart');
      })
      .toList();

  final manifestBuffer = StringBuffer();
  manifestBuffer.writeln('// AUTO-GENERATED FEATURES MANIFEST - DO NOT EDIT');
  manifestBuffer.writeln('// Total Items: ${allFiles.length}');
  manifestBuffer.writeln('');

  final sortedFilePaths = allFiles.map((f) {
    final relativePath = f.path
        .replaceFirst('${featuresDir.path}${Platform.pathSeparator}', '')
        .replaceAll('\\', '/');
    return relativePath;
  }).toList()..sort();

  for (final path in sortedFilePaths) {
    manifestBuffer.writeln("export '$path';");
  }

  manifestFile.writeAsStringSync(manifestBuffer.toString());
  print('Updated features_manifest.dart with ${allFiles.length} exports.');

  // 2. Collect all intents for the bootstrapper
  final intentFiles = allFiles
      .where((f) => f.path.endsWith('_intent.dart'))
      .toList();
  final intents = <IntentInfo>[];

  for (final file in intentFiles) {
    final content = file.readAsStringSync();

    // Find class name
    final classMatch = RegExp(
      r'class (\w+) extends (AppScreenIntent|PrimeCareScreen)',
    ).firstMatch(content);
    if (classMatch == null) continue;

    final className = classMatch.group(1)!;

    // Check for const constructor
    // Look for "const ClassName(" or "const ClassName.name("
    final hasConst =
        RegExp('const $className\\s*\\(').hasMatch(content) ||
        RegExp('const $className\\.\\w+\\s*\\(').hasMatch(content);

    intents.add(IntentInfo(className, hasConst));
  }

  intents.sort((a, b) => a.name.compareTo(b.name));

  final bootBuffer = StringBuffer();
  bootBuffer.writeln('// Layer: 02_I_GOVERNANCE_BOOTSTRAPPER');
  bootBuffer.writeln('// AUTO-GENERATED - DO NOT EDIT');
  bootBuffer.writeln("import 'package:flutter_core/00_B_flutter_core.dart';");
  bootBuffer.writeln("import '../features/features_manifest.dart';");
  bootBuffer.writeln('');
  bootBuffer.writeln('class GovernanceBootstrapper {');
  bootBuffer.writeln('  static void bootstrap() {');
  for (final intent in intents) {
    final prefix = intent.isConst ? 'const ' : '';
    bootBuffer.writeln(
      '    GovernanceRegistry.register($prefix${intent.name}());',
    );
  }
  bootBuffer.writeln('  }');
  bootBuffer.writeln('}');

  bootstrapperFile.writeAsStringSync(bootBuffer.toString());
  print(
    'Updated 02_I_governance_bootstrapper.dart with ${intents.length} intents.',
  );
}

class IntentInfo {
  final String name;
  final bool isConst;
  IntentInfo(this.name, this.isConst);
}
