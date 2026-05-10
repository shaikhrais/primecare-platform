import 'dart:io';
import 'package:primecare_governance/core/governance/screen_metadata.dart';
import 'package:primecare_governance/core/governance/registries/core_governance_registry.dart';
import 'package:primecare_governance/governance/services/ast_patch_engine.dart';
import 'package:path/path.dart' as p;

/// [RegistryHydrationService] - Synchronizes ScreenRegistry metadata with 
/// implementation-level attributes (translationKeys, isTranslationVerified).
class RegistryHydrationService {
  final ASTPatchEngine astEngine;
  final String projectRoot;

  RegistryHydrationService({
    required this.astEngine,
    required this.projectRoot,
  });

  /// Performs a full hydration sweep across the registry.
  Future<Map<String, dynamic>> performHydrationSweep() async {
    final screens = ScreenRegistry.allScreens;
    final results = {
      'total': screens.length,
      'hydrated': 0,
      'failed': 0,
      'details': <String, String>{},
    };

    for (final screen in screens) {
      try {
        final implementationPath = _resolveImplementationPath(screen.featureId);
        if (implementationPath == null) {
          results['failed'] = (results['failed'] as int) + 1;
          results['details']![screen.featureId] = 'Could not resolve implementation path';
          continue;
        }

        // 1. Extract attributes from the class
        final className = _resolveClassName(screen.featureId);
        final attributes = await astEngine.extractScreenClassAttributes(
          filePath: implementationPath,
          className: className,
        );

        if (attributes.isEmpty) {
          results['details']![screen.featureId] = 'No governance attributes found in class';
          continue;
        }

        // 2. Update the registry
        final updated = await astEngine.injectScreenConstant(
          registryPath: 'apps/primecare_governance/lib/core/governance/registries/core_governance_registry.dart',
          className: 'CoreGovernanceRegistry',
          screenId: screen.featureId,
          metadata: {
            ...screen.toJson(), // Start with current metadata
            'translationKeys': attributes['translationKeys'] ?? screen.translationKeys,
            'hasAllTranslations': attributes['isTranslationVerified'] ?? screen.hasAllTranslations,
            'isMobileVerified': attributes['isMobileVerified'] ?? screen.isMobileVerified,
            'isTabletVerified': attributes['isTabletVerified'] ?? screen.isTabletVerified,
            'isDesktopVerified': attributes['isDesktopVerified'] ?? screen.isDesktopVerified,
            'isSecurityVerified': attributes['isSecurityVerified'] ?? screen.isSecurityVerified,
            'subsystem': attributes['subsystem'] ?? screen.subsystem,
            'hasEmptyState': attributes['hasEmptyState'] ?? screen.hasEmptyState,
          },
          overwrite: true,
        );

        if (updated) {
          results['hydrated'] = (results['hydrated'] as int) + 1;
        } else {
          results['failed'] = (results['failed'] as int) + 1;
          results['details']![screen.featureId] = 'Failed to update registry entry';
        }
      } catch (e) {
        results['failed'] = (results['failed'] as int) + 1;
        results['details']![screen.featureId] = 'Error: $e';
      }
    }

    return results;
  }

  String? _resolveImplementationPath(String featureId) {
    // Basic mapping logic for PrimeCare project structure
    // In a real scenario, this could be more sophisticated
    final parts = featureId.split('.');
    if (parts.length < 2) return null;

    final feature = parts[0]; // e.g. 'monitoring'
    final screen = parts[1];  // e.g. 'system_monitoring'

    // Check features directory
    final path = 'apps/primecare_governance/lib/features/$feature/${screen}_view.dart';
    if (File(p.join(projectRoot, path)).existsSync()) {
      return path;
    }
    
    // Check if it's in flutter_core domain
    final corePath = 'packages/flutter_core/lib/src/presentation/screens/${screen}_view.dart';
    if (File(p.join(projectRoot, corePath)).existsSync()) {
      return corePath;
    }

    return null;
  }

  String _resolveClassName(String featureId) {
    // e.g. system_monitoring -> SystemMonitoringView
    final parts = featureId.split('.');
    final screenName = parts.last;
    
    final className = screenName.split('_').map((s) {
      if (s.isEmpty) return '';
      return s[0].toUpperCase() + s.substring(1);
    }).join('') + 'View';

    return className;
  }
}
