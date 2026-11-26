// Governance - Category: test | Purpose: Core implementation file for the Inspect Parity platform logic.
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:yaml/yaml.dart';
import 'package:primecare_governance/core/governance/registries/index.dart';
import 'package:primecare_governance/core/governance/governance_provider.dart';
import 'package:primecare_governance/governance/services/governance_history_service.dart';
import 'package:primecare_governance/governance/services/history_provider.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:mocktail/mocktail.dart';
import 'package:primecare_governance/governance/models/governance_report.dart';

class MockGovernanceHistoryService extends Mock implements GovernanceHistoryService {}
class FakeGovernanceReport extends Fake implements GovernanceReport {}

void main() async {
  registerFallbackValue(FakeGovernanceReport());
  final projectRoot = 'c:\\Users\\Admin2\\Documents\\GitHub\\primecare-platform';
  final blueprintPath = p.join(projectRoot, '.agents/governance/blueprints.yaml');

  print('Reading $blueprintPath');
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

  final mockHistoryService = MockGovernanceHistoryService();
  when(() => mockHistoryService.getHealthTrend()).thenAnswer((_) async => []);
  when(() => mockHistoryService.captureSnapshot(any())).thenAnswer((_) async {});

  final container = ProviderContainer(
    overrides: [
      governanceHistoryServiceProvider.overrideWithValue(mockHistoryService),
    ],
  );
  await container.read(governanceProvider.notifier).hydrateRegistries();
  
  Registry.registerAll();
  final registeredScreens = PlatformScreenRegistry.screens;

  print('Found ${blueprintMap.length} blueprints.');
  print('Found ${registeredScreens.length} total registered screens.');

  int driftCount = 0;
  int missingCount = 0;

  for (var reg in registries) {
    if (reg['id'] == 'registry.auditor') {
      final mapped = reg['mapped_blueprints'] as YamlList;
      for (var entry in mapped) {
        final screenId = entry['screen_id'].toString();
        final blueprintId = entry['blueprint_id'].toString();

        final parts = screenId.split('.');
        final normalizedId = 'SCREEN_${parts.skip(1).join('_').toUpperCase()}';

        final screen = registeredScreens[normalizedId] ??
            registeredScreens[screenId.toUpperCase().replaceAll('.', '_')];

        if (screen == null) {
          print('MISSING: Screen $screenId not found in registry (tried $normalizedId).');
          missingCount++;
          continue;
        }

        final required = blueprintMap[blueprintId];
        if (required == null) {
          print('ERROR: Blueprint $blueprintId not found.');
          continue;
        }

        final implemented = screen.implementedComponents;
        final pending = screen.pendingComponents;
        final allComponents = [...implemented, ...pending];

        final missingComps = required
            .where((c) => !allComponents.contains(c))
            .toList();

        if (missingComps.isNotEmpty) {
          print('DRIFT: Screen ${screen.id} is missing expected components from $blueprintId: $missingComps');
          driftCount++;
        } else {
          print('PARITY OK: Screen ${screen.id} matches $blueprintId');
        }
      }
    }
  }

  print('Summary: missingCount=$missingCount, driftCount=$driftCount');
  exit(driftCount + missingCount);
}
