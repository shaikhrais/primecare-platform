import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:yaml/yaml.dart';
import 'package:primecare_governance/core/governance/registries/index.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_governance/core/governance/governance_provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('Audit Screen Registry Parity', () async {
    final projectRoot =
        'c:\\Users\\Admin2\\Documents\\GitHub\\primecare-platform';
    final blueprintPath = p.join(
      projectRoot,
      '.agents/governance/blueprints.yaml',
    );

    PrimeLogger.info(
      'Auditing Screen Registry Parity using blueprints.yaml...',
    );

    expect(
      File(blueprintPath).existsSync(),
      true,
      reason: 'blueprints.yaml missing',
    );

    final yamlContent = File(blueprintPath).readAsStringSync();
    final yaml = loadYaml(yamlContent);

    final blueprints = yaml['blueprints'] as YamlList;
    final registries = yaml['registries'] as YamlList;

    final blueprintMap = {
      for (var b in blueprints)
        b['id']: (b['required_components'] as YamlList)
            .map((c) => c['id'].toString())
            .toList(),
    };

    // Initialize registry and hydrate from blueprints
    final container = ProviderContainer();
    await container.read(governanceProvider.notifier).hydrateRegistries();
    
    // Fallback registration for hardcoded screens not in blueprints
    Registry.registerAll();
    final registeredScreens = PlatformScreenRegistry.screens;

    PrimeLogger.info('Found ${blueprintMap.length} blueprints.');
    PrimeLogger.info(
      'Found ${registeredScreens.length} total registered screens.',
    );

    int driftCount = 0;
    int missingCount = 0;

    for (var reg in registries) {
      if (reg['id'] == 'registry.auditor') {
        final mapped = reg['mapped_blueprints'] as YamlList;
        for (var entry in mapped) {
          final screenId = entry['screen_id'].toString();
          final blueprintId = entry['blueprint_id'].toString();

          // Match screen_id from YAML to Registry IDs
          // The YAML screen_id is often hierarchical like 'clinical.psw.dashboard'
          // We convert it to SCREEN_PSW_DASHBOARD for matching.
          final parts = screenId.split('.');
          final normalizedId =
              'SCREEN_${parts.skip(1).join('_').toUpperCase()}';

          final screen =
              registeredScreens[normalizedId] ??
              registeredScreens[screenId.toUpperCase().replaceAll('.', '_')];

          if (screen == null) {
            PrimeLogger.warning(
              'MISSING: Screen $screenId (mapped to $blueprintId) not found in registry (tried $normalizedId).',
            );
            missingCount++;
            continue;
          }

          final required = blueprintMap[blueprintId];
          if (required == null) {
            PrimeLogger.warning('ERROR: Blueprint $blueprintId not found.');
            continue;
          }

          final implemented = screen.implementedComponents;
          final pending = screen.pendingComponents;
          final allComponents = [...implemented, ...pending];

          final missingComps = required
              .where((c) => !allComponents.contains(c))
              .toList();

          if (missingComps.isNotEmpty) {
            PrimeLogger.warning(
              'DRIFT: Screen ${screen.id} is missing expected components from $blueprintId: $missingComps',
            );
            driftCount++;
          } else {
            PrimeLogger.info(
              'PARITY OK: Screen ${screen.id} matches $blueprintId',
            );
          }
        }
      }
    }

    if (missingCount > 0) {
      PrimeLogger.warning(
        'FAILURE: $missingCount screens mapped in blueprints.yaml are missing from the registry.',
      );
    }

    if (driftCount > 0) {
      PrimeLogger.warning(
        'FAILURE: $driftCount screens have structural drift.',
      );
    }

    expect(
      missingCount,
      0,
      reason:
          'Some screens mapped in blueprints.yaml are missing from the registry.',
    );
    expect(
      driftCount,
      0,
      reason: 'Structural drift detected between blueprints and registry.',
    );
  });
}
