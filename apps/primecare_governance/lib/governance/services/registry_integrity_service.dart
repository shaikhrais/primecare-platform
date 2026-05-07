import '../models/governance_issue.dart';
import '../models/governance_severity.dart';
import '../models/governance_category.dart';
import '../../core/governance/screen_metadata.dart';

class RegistryIntegrityService {
  /// Scans the registry for structural and logical inconsistencies.
  static List<GovernanceIssue> inspect(Map<String, ScreenMetadata> registry) {
    final List<GovernanceIssue> issues = [];
    final Set<String> observedPaths = {};

    registry.forEach((id, metadata) {
      // 1. ID Mismatch Check
      if (id != metadata.id) {
        issues.add(
          GovernanceIssue(
            screenId: id,
            title: metadata.title,
            severity: GovernanceSeverity.critical,
            category: GovernanceCategory.audit,
            message:
                'Registry key ($id) does not match metadata ID (${metadata.id}).',
            fix: 'Update the metadata.id to match the registry key.',
            routePath: metadata.routePath,
            owner: metadata.productOwner,
            sourcePath: metadata.sourcePath,
            sprintName:
                'N/A', // Registry structural issues usually don't have a sprint
            detectedAt: DateTime.now(),
          ),
        );
      }

      // 2. Duplicate Route Check
      if (metadata.routePath.isNotEmpty &&
          observedPaths.contains(metadata.routePath)) {
        issues.add(
          GovernanceIssue(
            screenId: id,
            title: metadata.title,
            severity: GovernanceSeverity.high,
            category: GovernanceCategory.routing,
            message: 'Duplicate route path detected: ${metadata.routePath}',
            fix: 'Assign a unique route path to this screen.',
            routePath: metadata.routePath,
            owner: metadata.productOwner,
            sourcePath: metadata.sourcePath,
            sprintName:
                'N/A', // Registry structural issues usually don't have a sprint
            detectedAt: DateTime.now(),
          ),
        );
      }
      observedPaths.add(metadata.routePath);

      // 3. Missing Implementation Path for Completed Screens
      if (metadata.lifecycleStatus == LifecycleStatus.completed &&
          metadata.sourcePath.isEmpty) {
        issues.add(
          GovernanceIssue(
            screenId: id,
            title: metadata.title,
            severity: GovernanceSeverity.high,
            category: GovernanceCategory.audit,
            message: 'Screen is marked "Completed" but lacks a sourcePath.',
            fix:
                'Add the absolute or relative source path to the registry entry.',
            routePath: metadata.routePath,
            owner: metadata.productOwner,
            sourcePath: metadata.sourcePath,
            sprintName:
                'N/A', // Registry structural issues usually don't have a sprint
            detectedAt: DateTime.now(),
          ),
        );
      }

      // 4. Missing Components in Production
      if (metadata.lifecycleStatus == LifecycleStatus.completed &&
          metadata.implementedComponents.isEmpty) {
        issues.add(
          GovernanceIssue(
            screenId: id,
            title: metadata.title,
            severity: GovernanceSeverity.medium,
            category: GovernanceCategory.compliance,
            message: 'Completed screen has zero registered components.',
            fix: 'Document the primary UI components used in this screen.',
            routePath: metadata.routePath,
            owner: metadata.productOwner,
            sourcePath: metadata.sourcePath,
            sprintName:
                'N/A', // Registry structural issues usually don't have a sprint
            detectedAt: DateTime.now(),
          ),
        );
      }

      // 5. Zero-Weight Screen Check
      if (metadata.storyPoints == 0) {
        issues.add(
          GovernanceIssue(
            screenId: id,
            title: metadata.title,
            severity: GovernanceSeverity.low,
            category: GovernanceCategory.audit,
            message: 'Screen has 0 story points assigned.',
            fix: 'Perform a complexity estimation for this feature.',
            routePath: metadata.routePath,
            owner: metadata.productOwner,
            sourcePath: metadata.sourcePath,
            sprintName:
                'N/A', // Registry structural issues usually don't have a sprint
            detectedAt: DateTime.now(),
          ),
        );
      }


    });

    return issues;
  }
}
