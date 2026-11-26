import 'dart:io';
import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_governance/core/governance/screen_registry.dart';
import 'package:primecare_governance/governance/services/ast_patch_engine.dart';
import 'package:path/path.dart' as p;

/// Read-only source declarations. Getter values are not acceptance evidence.
class RegistryHydrationService {
  final ASTPatchEngine astEngine;
  final String projectRoot;

  RegistryHydrationService({required this.astEngine, required this.projectRoot});

  Future<Map<String, dynamic>> performHydrationSweep({List<ScreenMetadata>? screens}) async {
    final inventory = List<ScreenMetadata>.of(screens ?? ScreenRegistry.allScreens);
    final details = <String, String>{};
    final declarations = <String, Map<String, dynamic>>{};
    var failed = 0;
    final root = Directory(projectRoot).resolveSymbolicLinksSync();
    for (final screen in inventory) {
      try {
        if (screen.sourcePath.trim().isEmpty) {
          details[screen.id] = 'Missing registered source path; no path or verification inferred';
          failed++;
          continue;
        }
        final path = p.normalize(p.absolute(p.join(root, screen.sourcePath)));
        if (!p.isWithin(root, path)) throw StateError('Registered source lies outside project root');
        final file = File(path);
        if (!file.existsSync()) throw StateError('Registered source file is missing');
        if (!p.isWithin(root, file.resolveSymbolicLinksSync())) {
          throw StateError('Registered source resolves outside project root');
        }
        final className = '${screen.id.split('.').last.split('_').map((part) =>
          part.isEmpty ? '' : part[0].toUpperCase() + part.substring(1)).join('')}View';
        final attributes = await astEngine.extractScreenClassAttributes(
          filePath: p.relative(path, from: root), className: className);
        if (attributes.isNotEmpty) declarations[screen.id] = Map<String, dynamic>.unmodifiable({
          for (final entry in attributes.entries) entry.key:
            entry.value is List ? List.unmodifiable(entry.value as List) : entry.value,
        });
        details[screen.id] = attributes.isEmpty
          ? 'No declarations found for candidate class $className; acceptance remains pending'
          : 'Source declarations observed only; no verification, registration or metadata changed';
      } catch (error) {
        failed++;
        details[screen.id] = 'Source observation unavailable: $error';
      }
    }
    return Map<String, dynamic>.unmodifiable({
      'scope': 'source-declaration-audit-only',
      'total': inventory.length,
      'hydrated': 0,
      'observed': declarations.length,
      'pending': inventory.length,
      'failed': failed,
      'mutationsAttempted': false,
      'details': Map<String, String>.unmodifiable(details),
      'sourceDeclarations': Map<String, Map<String, dynamic>>.unmodifiable(declarations),
    });
  }
}
