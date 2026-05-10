import 'package:flutter_core/models/governance_types.dart';
import 'package:flutter_core/models/screen_metadata.dart';

class RegistryIntegrityService {
  /// Scans the registry for structural and logical inconsistencies.
  static List<PlatformAuditIssue> inspect(Map<String, ScreenMetadata> registry) {
    final List<PlatformAuditIssue> issues = [];
    final Set<String> observedPaths = {};

    registry.forEach((id, metadata) {
      // 1. ID Mismatch Check
      if (id != metadata.id) {
        issues.add(
          PlatformAuditIssue(
            id: 'registry_id_mismatch_$id',
            subsystem: 'primecare_governance',
            registry: 'CoreRegistry',
            issue: 'Registry key ($id) does not match metadata ID (${metadata.id}).',
            suggestion: 'Update the metadata.id to match the registry key.',
            severity: AuditSeverity.critical,
            metadata: {
              'screenId': id,
              'actualId': metadata.id,
            },
          ),
        );
      }

      // 2. Duplicate Route Check
      if (metadata.routePath.isNotEmpty &&
          observedPaths.contains(metadata.routePath)) {
        issues.add(
          PlatformAuditIssue(
            id: 'registry_duplicate_route_${id}_${metadata.routePath.replaceAll('/', '_')}',
            subsystem: 'primecare_governance',
            registry: 'Routing',
            issue: 'Duplicate route path detected: ${metadata.routePath}',
            suggestion: 'Assign a unique route path to this screen.',
            severity: AuditSeverity.high,
            metadata: {
              'screenId': id,
              'routePath': metadata.routePath,
            },
          ),
        );
      }
      observedPaths.add(metadata.routePath);

      // 3. Missing Implementation Path for Completed Screens
      if (metadata.lifecycleStatus == LifecycleStatus.completed &&
          metadata.sourcePath.isEmpty) {
        issues.add(
          PlatformAuditIssue(
            id: 'registry_missing_source_$id',
            subsystem: 'primecare_governance',
            registry: 'CoreRegistry',
            issue: 'Screen is marked "Completed" but lacks a sourcePath.',
            suggestion: 'Add the absolute or relative source path to the registry entry.',
            severity: AuditSeverity.high,
            metadata: {
              'screenId': id,
            },
          ),
        );
      }

      // 4. Missing Components in Production
      if (metadata.lifecycleStatus == LifecycleStatus.completed &&
          metadata.implementedComponents.isEmpty) {
        issues.add(
          PlatformAuditIssue(
            id: 'registry_missing_components_$id',
            subsystem: 'primecare_governance',
            registry: 'Compliance',
            issue: 'Completed screen has zero registered components.',
            suggestion: 'Document the primary UI components used in this screen.',
            severity: AuditSeverity.medium,
            metadata: {
              'screenId': id,
            },
          ),
        );
      }

      // 5. Zero-Weight Screen Check
      if (metadata.storyPoints == 0) {
        issues.add(
          PlatformAuditIssue(
            id: 'registry_zero_points_$id',
            subsystem: 'primecare_governance',
            registry: 'CoreRegistry',
            issue: 'Screen has 0 story points assigned.',
            suggestion: 'Perform a complexity estimation for this feature.',
            severity: AuditSeverity.low,
            metadata: {
              'screenId': id,
            },
          ),
        );
      }
    });

    return issues;
  }
}
