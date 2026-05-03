import 'dart:convert';
import 'dart:io';
import 'package:flutter_core/flutter_core.dart';
import '../../../governance/services/ast_patch_engine.dart';
import '../../../core/governance/screen_registry.dart';

/// [BlueprintHydrationService] - Orchestrates the bulk hydration of platform registries
/// from the architectural blueprints source of truth.
class BlueprintHydrationService {
  final Ref ref;
  final ASTPatchEngine _astEngine;

  BlueprintHydrationService(this.ref) 
    : _astEngine = ASTPatchEngine('c:/Users/Admin2/Documents/GitHub/primecare-platform');

  /// Hydrates all missing screens from the blueprints JSON.
  Future<Map<String, int>> hydrateFromBlueprints() async {
    final results = <String, int>{
      'Clinical': 0,
      'Corporate': 0,
      'Operational': 0,
      'Skipped': 0,
      'Errors': 0,
    };

    try {
      final blueprintsFile = File('c:/Users/Admin2/Documents/GitHub/primecare-platform/architectural_blueprints.json');
      if (!await blueprintsFile.exists()) return {'error': -1};

      final data = jsonDecode(await blueprintsFile.readAsString());
      final categories = data['categories'] as Map<String, dynamic>;
      final existingScreens = ScreenRegistry.getAllScreens().map((s) => s.title.toLowerCase()).toSet();

      for (final entry in categories.entries) {
        final categoryName = entry.key; // Clinical, Corporate, etc.
        final screens = entry.value as List<dynamic>;

        for (final screen in screens) {
          final title = screen['name'] as String;
          
          // Skip if already exists (fuzzy check by title)
          if (existingScreens.contains(title.toLowerCase())) {
            results['Skipped'] = (results['Skipped'] ?? 0) + 1;
            continue;
          }

          final screenId = _generateIdFromTitle(title);
          final route = _generateRouteFromTitle(categoryName, title);
          
          final success = await _astEngine.injectScreenConstant(
            registryPath: _getRegistryPath(categoryName),
            className: '${categoryName}Registry',
            screenId: screenId,
            metadata: {
              'id': screenId,
              'featureName': title,
              'routePath': route,
              'title': title,
              'description': screen['intent'] ?? '',
              'office': categoryName,
              'role': _suggestRole(categoryName, title),
              'lifecycleStatus': 'LifecycleStatus.backlog',
              'icon': 'Icons.auto_awesome_mosaic',
              'pendingComponents': screen['components'] ?? [],
            },
          );

          if (success) {
            results[categoryName] = (results[categoryName] ?? 0) + 1;
          } else {
            results['Errors'] = (results['Errors'] ?? 0) + 1;
          }
        }
      }
    } catch (e) {
      PrimeLogger.error('Hydration Error', error: e);
    }

    return results;
  }

  String _getRegistryPath(String category) {
    switch (category) {
      case 'Clinical':
        return 'apps/primecare_governance/lib/core/governance/registries/clinical_registry.dart';
      case 'Corporate':
        return 'apps/primecare_governance/lib/core/governance/registries/corporate_registry.dart';
      default:
        return 'apps/primecare_governance/lib/core/governance/registries/operational_registry.dart';
    }
  }

  String _generateIdFromTitle(String title) {
    return 'SCREEN_${title.toUpperCase().replaceAll(' ', '_').replaceAll('-', '_')}';
  }

  String _generateRouteFromTitle(String category, String title) {
    final base = category.toLowerCase();
    final slug = title.toLowerCase().replaceAll(' ', '-').replaceAll('_', '-');
    return '/$base/$slug';
  }

  String _suggestRole(String category, String title) {
    if (category == 'Clinical') return 'RN';
    if (category == 'Corporate') return 'Admin';
    if (title.contains('PSW')) return 'PSW';
    return 'Staff';
  }
}

final blueprintHydrationServiceProvider = Provider((ref) => BlueprintHydrationService(ref));
