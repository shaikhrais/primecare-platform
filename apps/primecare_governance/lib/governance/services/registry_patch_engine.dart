// Governance - Category: service | Purpose: Attempts to automatically apply a fix to the registry file. This is a high-risk operation and should ideally be done ...
import 'dart:io';
import 'package:flutter_core/flutter_core.dart';

class RegistryPatchEngine {
  static const String registryPath = 'lib/core/governance/screen_registry.dart';

  /// Attempts to automatically apply a fix to the registry file.
  /// This is a high-risk operation and should ideally be done using AST parsing.
  /// For this implementation, we use targeted line-replacement logic.
  static Future<bool> applyFix(
    String projectRoot,
    PlatformAuditIssue issue,
    String property,
    String value,
  ) async {
    try {
      final file = File('$projectRoot/apps/primecare_governance/$registryPath');
      if (!await file.exists()) return false;

      final lines = await file.readAsLines();
      final newLines = <String>[];

      bool inScreenBlock = false;
      bool fixed = false;

      for (int i = 0; i < lines.length; i++) {
        final line = lines[i];

        // Detect start of screen block
        if (line.contains("'${issue.screenId}': const ScreenMetadata(") ||
            line.contains("'${issue.screenId}': ScreenMetadata(")) {
          inScreenBlock = true;
        }

        if (inScreenBlock && !fixed && line.trim().startsWith('$property:')) {
          // Replace property line
          final indent = line.substring(0, line.indexOf(property));
          newLines.add('$indent$property: $value,');
          fixed = true;
        } else {
          newLines.add(line);
        }

        // Detect end of screen block
        if (inScreenBlock && line.trim() == '),') {
          inScreenBlock = false;
        }
      }

      if (fixed) {
        await file.writeAsString(newLines.join('\n'));
        return true;
      }

      return false;
    } catch (e) {
      PrimeLogger.error('Failed to apply registry patch for ${issue.screenId}', tag: 'RegistryPatchEngine', error: e);
      return false;
    }
  }
}
